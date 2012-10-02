#!/usr/bin/php
<?php

$input = "";

$fp = fopen("php://stdin", "r");
while ($line = fgets($fp, 1024)){
		$str = rtrim($line, "\n");
		echo '<li>'.$str.'</li>'.PHP_EOL;
}
fclose($fp);

?>
