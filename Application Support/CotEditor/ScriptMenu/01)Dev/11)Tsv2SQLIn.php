#!/usr/bin/php
<?php
// %%%{CotEditorXInput=Selection}%%%
// %%%{CotEditorXOutput=ReplaceSelection}%%%

require_once dirname(__FILE__) . "/-/functions.php";

$stdin = file_get_contents("php://stdin");

$tsv = Reader::tsv();

$lines = ArrayUtil::invert($tsv->parse($stdin));
foreach ($lines as $line) {
	$line = ArrayUtil::compact($line);
	printf("%s in (%s)\n", array_shift($line), implode(',', SQLUtil::escapeAll($line)));
}
