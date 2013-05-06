#!/usr/bin/php
<?php

function makeSafe($str){	
	$str = strtolower(preg_replace('/[^a-zA-Z0-9 ]/','',$str));
	$str = str_replace(" ", "-", $str);
	return $str;
}


$input = "";
echo '<ul id="menu">'.PHP_EOL;
$fp = fopen("php://stdin", "r");
while ($line = fgets($fp, 1024)){
	$str = rtrim($line, "\n");
	echo '<li><a href="" id="'.makeSafe($str).'">'.$str.'</a></li>'.PHP_EOL;
}
fclose($fp);
echo '</ul>'.PHP_EOL;
?>
