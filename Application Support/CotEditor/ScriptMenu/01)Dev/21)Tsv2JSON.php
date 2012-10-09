#!/usr/bin/php
<?php
// %%%{CotEditorXInput=Selection}%%%
// %%%{CotEditorXOutput=ReplaceSelection}%%%

require_once dirname(__FILE__) . "/-/functions.php";

$stdin = file_get_contents("php://stdin");
$tsv = Reader::tsv();
$stdout = json_encode($tsv->parse($stdin));//'/*' . $stdin . '*/';
echo $stdout;


