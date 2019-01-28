#!/usr/bin/php
<?php
// %%%{CotEditorXInput=Selection}%%%
// %%%{CotEditorXOutput=ReplaceSelection}%%%

require_once dirname(__FILE__) . "/-/functions.php";

$stdin = file_get_contents("php://stdin");

$tsv = Reader::tsv();

$lines = $tsv->parse($stdin);
$head = array_shift($lines);

foreach ($lines as $line) {
	echo SQLUtil::buildWhere($head, $line) . "\n";
}
