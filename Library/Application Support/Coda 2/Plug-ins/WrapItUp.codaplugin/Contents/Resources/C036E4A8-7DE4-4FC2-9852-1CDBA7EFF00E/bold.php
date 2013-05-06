#!/usr/bin/php
<?php

$input = "";

$fp = fopen("php://stdin", "r");
while ( $line = fgets($fp, 1024) )
	$input .= $line;
	
fclose($fp);

echo '<strong>';
echo $input;
echo '</strong>';

?>