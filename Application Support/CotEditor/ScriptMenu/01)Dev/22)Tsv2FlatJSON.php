#!/usr/bin/php
<?php
// %%%{CotEditorXInput=Selection}%%%
// %%%{CotEditorXOutput=ReplaceSelection}%%%

require_once dirname(__FILE__) . "/-/functions.php";

$stdin = file_get_contents("php://stdin");
$tsv = Reader::tsv();

$items = array();
$lines = $tsv->parse($stdin);
foreach ($lines as $line) {
	$items[array_shift($line)] = count($line) == 1 ? $line[0] : $line;
}

$stdout = json_encode($items);//'/*' . $stdin . '*/';
echo $stdout;


