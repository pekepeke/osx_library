#!/usr/bin/php
<?php
// %%%{CotEditorXInput=Selection}%%%
// %%%{CotEditorXOutput=ReplaceSelection}%%%

require_once dirname(__FILE__) . "/-/functions.php";

function wherelize($head, $s) {
	if (!is_numeric($s)) {
		$s = "'" . str_replace("'", "''", $s) . "'";
	}
	return sprintf("%s = %s", $head, $s);
}

$stdin = file_get_contents("php://stdin");

$tsv = Reader::tsv();

$lines = $tsv->parse($stdin);
$head = array_shift($lines);

foreach ($lines as $line) {
	echo implode(" AND ", array_map('wherelize', $head, $line)) . "\n";
}
