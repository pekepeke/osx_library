#!/usr/bin/php
<?php

// %%%{CotEditorXInput=Selection}%%%
// %%%{CotEditorXOutput=ReplaceSelection}%%%

require_once dirname(__FILE__) . "/-/functions.php";

$stdin = file_get_contents("php://stdin");

$csv = Reader::tsv();
$lines = $csv->parse($stdin);
// echo Writer::csv()->build();

echo AlignRenderer::create()
	->renderTextileTable($lines);

