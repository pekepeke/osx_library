#!/usr/bin/php
<?php
// %%%{CotEditorXInput=Selection}%%%
// %%%{CotEditorXOutput=ReplaceSelection}%%%

require_once dirname(__FILE__) . "/-/functions.php";

$stdin = file_get_contents("php://stdin");

$csv = Reader::csv();
$stdout = json_encode($csv->namedParse($stdin));//'/*' . $stdin . '*/';
echo $stdout;

