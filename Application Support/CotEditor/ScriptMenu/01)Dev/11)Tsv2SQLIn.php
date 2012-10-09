#!/usr/bin/php
<?php
// %%%{CotEditorXInput=Selection}%%%
// %%%{CotEditorXOutput=ReplaceSelection}%%%

require_once dirname(__FILE__) . "/-/functions.php";

function escape_value($s) {
	if (!is_numeric($s)) {
		$s = "'" . str_replace("'", "''", $s) . "'";
	}
	return $s;
}

$stdin = file_get_contents("php://stdin");

$tsv = Reader::tsv();

$lines = ArrayUtil::invert($tsv->parse($stdin));
foreach ($lines as $line) {

}
$head = array_shift($lines);

foreach ($lines as $line) {
	printf("%s in (%s)\n", array_shift($line), implode(',', array_map('escape_value', $line)));
}
