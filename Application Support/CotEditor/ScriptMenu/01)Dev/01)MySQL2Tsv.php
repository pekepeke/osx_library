#!/usr/bin/php
<?php
// %%%{CotEditorXInput=Selection}%%%
// %%%{CotEditorXOutput=ReplaceSelection}%%%

require_once dirname(__FILE__) . "/-/functions.php";

$stdin = str_replace('"', '""', file_get_contents("php://stdin"));
$stdin = preg_replace('!^[\+\-\r\n]+$!m', '', $stdin);
$stdin = preg_replace('!^\| *| *\|$!m', '"', $stdin);
$stdin = preg_replace('! *\| *!', '"' . "\t" . '"', $stdin);

echo $stdin;