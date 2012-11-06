#!/usr/bin/php
<?php
// %%%{CotEditorXInput=Selection}%%%
// %%%{CotEditorXOutput=ReplaceSelection}%%%

require_once dirname(__FILE__) . "/-/functions.php";

$stdin = file_get_contents("php://stdin");

$tsv = Reader::tsv();
$lines = $tsv->parse($stdin);

$header = array_shift($lines);

$header_s = implode(',', $header);
foreach ($lines as $line) {
	$values = array_combine($header, $line);
	printf("UPDATE xxx_table SET %s WHERE %s;\n", SQLUtil::buildSetByValues($values), SQLUtil::buildWhereByValues($values));
}
