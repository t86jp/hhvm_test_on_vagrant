<?hh

function calc(?int $x): int{
  return $x + 1;
}

function bar($y): Closure{
  return $x ==> $x * $y;
}

var_dump(calc(null));
$a = bar(2);
var_dump($a(1));
var_dump($a(2));
