#!/bin/bash
assert() {
  expected="$1"
  input="$2"

  ./9cc "$input" > tmp.s
  cc -o tmp tmp.s
  ./tmp
  actual="$?"

  if [ "$actual" = "$expected" ]; then
    echo "$input => $actual"
  else
    echo "$input => $expected expected, but got $actual"
    exit 1
  fi
}

assert 0 0
assert 42 42
assert 21 "5+20-4"
assert 3 "1 + 2"
assert 41 " 12 + 34 - 5 "
assert 6 " 2 * 3 "
assert 20 " 40 / 2"
assert 10 " 10 + 5 + -5"
assert 10 '- -10'

echo OK