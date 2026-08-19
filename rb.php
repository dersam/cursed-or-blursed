<?php

$name  = "Ada Lovelace";
$role  = "Engineer";
$langs = array("Ruby", "PHP", "Assembly");

echo implode(" ", ["Hello,", $name, "!"]);
echo implode(" ", ["Role: ", $role]);

function greet($who) {
  return implode(" ", ["Sup, ", $who]);
}

echo greet("world");
echo implode(" ", ["strlen(name) =", strlen($name)]);
echo isset(null);
?>
