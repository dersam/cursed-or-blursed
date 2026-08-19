<?php

$name  = "Ada Lovelace";
$role  = "Engineer";
$langs = array("Ruby", "PHP", "Assembly");

echo implode(" ", ["Hello,", $name, "!"]);
echo "\n";
echo implode(" ", ["Role:", $role]);
echo "\n";

function greet($who) {
  return implode(" ", ["Sup,", $who]);
}

echo greet("world");
echo "\n";
echo implode(" ", ["strlen(name) =", strlen($name)]);
echo "\n";

$x = null;
echo isset($x) ? "set" : "not";
echo "\n";
?>
