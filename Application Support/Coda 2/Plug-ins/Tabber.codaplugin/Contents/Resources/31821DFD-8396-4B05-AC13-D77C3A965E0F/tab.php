#!/usr/bin/php
<?php

$fp = fopen('php://stdin', 'r');

while ( $line = fgets($fp, 4096) ) {
	echo $_ENV[CODA_LINE_ENDING]."\t";
	$line = explode('{', $line);
	echo $line[0].'$$IP$$ {}';
}

fclose($fp);

?>