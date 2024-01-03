GREEN="\033[0;32m"
RED="\033[0;31m"
NOCOLOR="\033[0m"

PASSED="\t${GREEN}PASSED${NOCOLOR}"
FAILED="\t${RED}FAILED${NOCOLOR}"

echo "[#1]\tShould handle not enough arguments"
expectOutput="Not enough arguments"
actual=$(./cat)
output=$(echo "$actual" | grep "$expectOutput")
if [[ -z "$output" ]]; then
  echo "$FAILED"
  echo "\tExpect: $expectOutput"
  echo "\tActual: $actual"
else
  echo "$PASSED"
fi

echo "[#1b]\tShould handle non-existent file"
expectOutput="Cannot read input"
actual=$(./cat foo.txt)
output=$(echo "$actual" | grep "$expectOutput")
if [[ -z "$output" ]]; then
  echo "$FAILED"
  echo "\tExpect: $expectOutput"
  echo "\tActual: $actual"
else
  echo "$PASSED"
fi

echo "[#2]\tShould print file content"
expectOutput=$(cat test.txt)
actual=$(./cat test.txt)
output=$(echo "$actual" | grep "$expectOutput")
if [[ -z "$output" ]]; then
  echo "$FAILED"
  echo "\tExpect: $expectOutput"
  echo "\tActual: $actual"
else
  echo "$PASSED"
fi

echo "[#3]\tShould print from stdin"
expectOutput=$(head -n1 test.txt | cat -)
actual=$(head -n1 test.txt | ./cat -)
output=$(echo "$actual" | grep "$expectOutput")
if [[ -z "$output" ]]; then
  echo "$FAILED"
  echo "\tExpect: $expectOutput"
  echo "\tActual: $actual"
else
  echo "$PASSED"
fi

echo "[#4]\tShould print from all input files"
expectOutput=$(cat test.txt test2.txt | md5)
actual=$(./cat test.txt test2.txt | md5)
if [[ "$expectOutput" == "$actual" ]]; then
  echo "$PASSED"
else
  echo "$FAILED"
  echo "\tExpect: $expectOutput"
  echo "\tActual: $actual"
fi

