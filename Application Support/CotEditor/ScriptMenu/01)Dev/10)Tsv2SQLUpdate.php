#!/usr/bin/php
<?php
// %%%{CotEditorXInput=Selection}%%%
// %%%{CotEditorXOutput=ReplaceSelection}%%%

require_once dirname(__FILE__) . "/-/functions.php";

function escape_value($s) {
	if (is_null($s)) {
		return "NULL";
	} elseif (!is_numeric($s)) {
		$s = "'" . str_replace("'", "''", $s) . "'";
	}
	return $s;
}

function format_update($values) {
	$lines = array();
	foreach($values as $key => $val) {
		$lines[] = sprintf('%s = %s', $key, escape_value($val));
	}
	return implode(", ", $lines);
}

$stdin = file_get_contents("php://stdin");

$tsv = Reader::tsv();
$lines = $tsv->parse($stdin);

$header = array_shift($lines);

$header_s = implode(',', $header);
foreach ($lines as $line) {
	$values = array_combine($header, $line);
	$where_s = SQLUtil::buildWhereByValues();
	printf("UPDATE xxx_table SET %s WHERE %s;\n", SQLUtil::buildSetByValues($values), SQLUtil::buildWhereByValues($values));
}
