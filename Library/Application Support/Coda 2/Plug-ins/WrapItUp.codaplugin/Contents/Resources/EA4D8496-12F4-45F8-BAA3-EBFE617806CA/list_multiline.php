#!/usr/bin/php
<?php

$input = "";

$fp = fopen("php://stdin", "r");


while (($line = fgets($fp, 4096)) !== false ){
	
	$str = rtrim($line, "\n");
	echo '<li>'.$str.'</li>'.PHP_EOL;
	
}
	
	
	
	//$input .= $line;
	
fclose($fp);


?>