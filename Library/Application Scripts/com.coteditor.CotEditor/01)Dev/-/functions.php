<?php

date_default_timezone_set('Asia/Tokyo');
// setlocale(LC_ALL, 'ja_JP');
mb_language('japanese');
mb_internal_encoding('utf-8');
if (function_exists('ini_set')) {
	ini_set('default_charset', 'UTF-8');

	ini_set('magic_quotes_gpc', false);
	ini_set('magic_quotes_runtime', false);
	ini_set('magic_quotes_sybase', false);
	//ini_set('display_errors', 0);
	// ini_set('auto_detect_line_endings', true);
}

class Reader {

	var $delim = ",";
	var $escape = '"';

	function parse($src) {
		$lines = array();
		$fp = fopen("php://memory", 'rw');
		// $src = mb_convert_encoding(file_get_contents("test.csv"), mb_internal_encoding(), "cp932");
		fwrite($fp, preg_replace('!\\r\\n|\\r|\\n!', "\n", $src));
		rewind($fp);
		if ($fp) {
			//$header = $this->fgetcsv_reg($fp, null);
			while (($items = $this->fgetcsv_reg($fp)) !== false) {
				// $hash = array_combine($header, $items);
				$lines[] = $items;
			}
		}
		return $lines;
	}

	function namedParse($src) {
		$lines = $this->parse($src);
		$header = array_shift($lines);
		$hashes = array();
		foreach ($lines as $line) {
			$hashes[] = array_combine($header, $line);
		}
		return $hashes;
	}

	function fgetcsv_reg(&$handle, $length = null, $d = null, $e = null) {
		is_null($d) && $d = $this->delim;
		is_null($e) && $e = $this->escape;
		$eof = false;
		$d = preg_quote($d);
		$e = preg_quote($e);
		$_line = "";
		while ($eof != true) {
			$_line .= (empty($length) ? fgets($handle) : fgets($handle, $length));
			$itemcnt = preg_match_all('/'.$e.'/', $_line, $dummy);
			if ($itemcnt % 2 == 0) $eof = true;
		}
		if ($d == "\t" || $d == " " || $d == "\r" || $d == "\n") {
			$_csv_line = preg_replace('/(?:\\r\\n|[\\r\\n])?$/', $d, preg_replace('!^[\r\n]*|[\r\n]*$!', '', $_line));
		} else {
			$_csv_line = preg_replace('/(?:\\r\\n|[\\r\\n])?$/', $d, trim($_line));
		}
		$_csv_pattern = '/('.$e.'[^'.$e.']*(?:'.$e.$e.'[^'.$e.']*)*'.$e.'|[^'.$d.']*)'.$d.'/';
		preg_match_all($_csv_pattern, $_csv_line, $_csv_matches);
		$_csv_data = $_csv_matches[1];
		for($_csv_i=0;$_csv_i<count($_csv_data);$_csv_i++){
			$_csv_data[$_csv_i]=preg_replace('/^'.$e.'(.*)'.$e.'$/s','$1',$_csv_data[$_csv_i]);
			$_csv_data[$_csv_i]=str_replace($e.$e, $e, $_csv_data[$_csv_i]);
		}
		return empty($_line) ? false : $_csv_data;
	}

	function delim($s) {
		$this->delim = $s;
		return $this;
	}

	function escape($s) {
		$this->escape = $s;
		return $this;
	}

	function tsvType() {
		return $this->delim("\t");
	}

	static function csv() {
		$csv = new Reader();
		return $csv;
	}
	static function tsv() {
		$csv = new Reader();
		return $csv->tsvType();
	}
}

class Writer {

	var $delim = ",";
	var $escape = '"';

	function build($lines) {
		$fp = fopen("php://memory", 'rw');
		foreach ($lines as $line) {
			$this->fputcsv_reg($fp, $line);
		}
		rewind($fp);
		return stream_get_contents($fp);
	}

	function fputcsv_reg($fh, array $fields, $delimiter = null, $enclosure = null, $mysql_null = false) {
		is_null($delimiter) && $delimiter = $this->delim;
		is_null($enclosure) && $enclosure = $this->escape;
		$delimiter_esc = preg_quote($delimiter, '/');
		$enclosure_esc = preg_quote($enclosure, '/');

		$output = array();
		foreach ($fields as $field) {
			if ($field === null && $mysql_null) {
				$output[] = 'NULL';
				continue;
			}

			$output[] = preg_match("/(?:${delimiter_esc}|${enclosure_esc}|\s)/", $field) ? (
				$enclosure . str_replace($enclosure, $enclosure . $enclosure, $field) . $enclosure
			) : $field;
		}

		fwrite($fh, implode($delimiter, $output) . "\r\n");
	}

	function delim($s) {
		$this->delim = $s;
		return $this;
	}

	function escape($s) {
		$this->escape = $s;
		return $this;
	}

	function tsvType() {
		return $this->delim("\t");
	}


	static function csv() {
		$csv = new Writer();
		return $csv;
	}
	static function tsv() {
		$csv = new Writer();
		return $csv->tsvType();
	}
}

class ArrayUtil {
	static function invert($lines) {
		$arr = array();
		$i = 0;
		foreach ($lines as $line) {
			for ($j = 0, $jlen = count($line); $j < $jlen; $j++) {
				$arr[$j][$i] = $line[$j];
			}
			$i++;
		}
		return $arr;
	}
	static function compact($lines) {
		// $fn = create_function('$k, $v', 'return $v != "";');
		// return array_filter($lines, '_function_array_compact');
		$arr = array();
		foreach ($lines as $v) {
			$v != "" && $arr[] = $v;
		}
		return $arr;
	}
}

// function _function_array_compact($k, $v) {
// 	return $v != "";
// }

class SQLUtil {
	static function escape($s) {
		if (is_null($s) || $s == "") {
			return "NULL";
		} elseif (!is_numeric($s) &&
			!preg_match('!^(now|sysdate|timeofday)\(.*\)$!i', $s)) {
			// $s = "'" . str_replace("'", "''", $s) . "'";
			$s = preg_replace('#\r\n|\r|\n#', '\n', $s);
			$s = "'" . str_replace("'", "''", $s) . "'";
		}
		return $s;
	}

	static function escapeAll($arr) {
		return array_map(array('SQLUtil', 'escape'), $arr);
	}

	static function buildSetByValues($values) {
		$lines = array();
		foreach($values as $key => $val) {
			$lines[] = sprintf('%s = %s', $key, self::escape($val));
		}
		return implode(", ", $lines);
	}

	static function buildWhere($header, $line) {
		$lines = array();
		foreach (array_combine($header, $line) as $key => $val) {
			$lines[] = sprintf('%s = %s', $key, self::escape($val));
		}
		return implode(' AND ', $lines);
	}

	static function buildWhereByValues($values) {
		$keys = array_filter(array_keys($values), array('SQLUtil', 'filterId'));
		$lines = array();
		foreach ($keys as $key) {
			$lines[] = sprintf('%s = %s', $key, self::escape($values[$key]));
		}
		return implode(' AND ', $lines);
	}

	static function filterId($key) {
		return preg_match('!id$!i', $key);
	}
}


class AlignRenderer {
	var $layouts = null;
	var $lines = null;

	static function create() {
		return new static();
	}

	function __construct() {
		$this->clear();
	}

	function clear() {
		$this->layouts = array();
	}

	function calc() {
		$lines = $this->lines;

		$layouts = array();
		foreach ($lines as $line) {
			foreach ($line as $i => $item) {
				$len = $this->strlenMbDouble($item);
				if (!isset($layouts[$i]) || $layouts[$i] < $len) {
					$layouts[$i] = $len;
				}
			}
		}
		$this->layouts = $layouts;
		return $this;
	}

	function renderMarkdownTable($lines) {
		$this->lines = $lines;
		$this->calc();

		// $lines = $this->lines;
		$items = array();

		$items[] = $this->makeLine(array_shift($lines));
		$items[] = $this->makeSeparator();
		foreach ($lines as $line) {
			$items[] = $this->makeLine($line);
		}
		return implode("\n", $items);
	}

	function renderTextileTable($lines) {
		$this->lines = $lines;
		$this->calc();

		// $lines = $this->lines;
		$items = array();

		$items[] = $this->makeLine(array_shift($lines));
		foreach ($lines as $line) {
			$items[] = $this->makeLine($line);
		}
		return implode("\n", $items);
	}
	function renderBacklogTable($lines) {
		$this->lines = $lines;
		$this->calc();

		// $lines = $this->lines;
		$items = array();

		$items[] = "|" . $this->makeLine(array_shift($lines)) . "|h";
		foreach ($lines as $line) {
			$items[] = "|" . $this->makeLine($line) . "|";
		}
		return implode("\n", $items);
	}

	function makeSeparator() {
		$layouts = $this->layouts;
		$items = array();
		foreach ($layouts as $len) {
			$items[] = str_repeat("-", $len);
		}
		return implode("|", $items);
	}

	function makeLine($line) {
		if (empty($line)) {
			return "";
		}
		$layouts = $this->layouts;
		$items = array();
		foreach ($line as $i => $item) {
			// $items[] = sprintf("%".$layouts[$i]."s", $item);
			$len = $this->strlenMbDouble($item);
			// $items[] = str_repeat(" ", $layouts[$i] - $len) . $item;
			$items[] = $item . str_repeat(" ", $layouts[$i] - $len);
		}
		return implode("|", $items);
	}

	function strlenMbDouble($s) {
		$mblen = mb_strlen($s);
		$wlen = (strlen($s) - $mblen) / 2;
		$len = ($mblen - $wlen) + $wlen * 2;
		return $len;
	}
}

