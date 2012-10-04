#!/usr/bin/env php
<?php
// %%%{CotEditorXInput=AllText}%%%
// %%%{CotEditorXOutput=ReplaceAllText}%%%

$xml_s = file_get_contents('php://stdin');

$dom = DOMDocument::loadXML($xml_s);

if (!$dom->encoding) {
    $dom->encoding = 'UTF-8';
}

$dom->formatOutput = true;

echo $dom->saveXML();