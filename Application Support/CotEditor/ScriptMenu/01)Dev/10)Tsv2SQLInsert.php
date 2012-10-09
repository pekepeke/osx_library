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

$stdin = file_get_contents("php://stdin");

$tsv = Reader::tsv();
$lines = $tsv->parse($stdin);

$header = array_shift($lines);

$header_s = implode(',', $header);
foreach ($lines as $line) {
	printf("INSERT INTO xxx_table (%s) VALUES (%s);\n", $header_s, implode(',', array_map('escape_value', $line)));
}
