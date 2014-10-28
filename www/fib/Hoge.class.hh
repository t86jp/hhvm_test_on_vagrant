<?hh

class Hoge{
    function fib(int $n): int{
        if($n < 2) return $n;
        return $this->fib($n - 1) + $this->fib($n - 2);
    }
}
