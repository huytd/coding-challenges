GREEN="\033[0;32m"
RED="\033[0;31m"
NOCOLOR="\033[0m"

PASSED="\t${GREEN}PASSED${NOCOLOR}"
FAILED="\t${RED}FAILED${NOCOLOR}"

# compile the code
gcc wc.c -Wall -o wc

echo "[#1]\tShould handle not enough arguments"
expectOutput="Not enough arguments"
output=$(./wc | grep "$expectOutput")
if [[ -z "$output" ]]; then
  echo "$FAILED"
else
  echo "$PASSED"
fi

echo "[#2]\tShould handle unknown options"
expectOutput="Unknown option -z"
output=$(./wc -z foo.txt | grep "$expectOutput")
if [[ -z "$output" ]]; then
  echo "$FAILED"
else
  echo "$PASSED"
fi

echo "[#3]\tShould handle non-existent file"
expectOutput="Cannot open file foo.txt"
output=$(./wc -l foo.txt | grep "$expectOutput")
if [[ -z "$output" ]]; then
  echo "$FAILED"
else
  echo "$PASSED"
fi

echo "[#4]\tShould handle -c: Count file size"
expectOutput="342190 test.txt"
output=$(./wc -c test.txt | grep "$expectOutput")
if [[ -z "$output" ]]; then
  echo "$FAILED"
else
  echo "$PASSED"
fi

echo "[#5]\tShould handle -l: Count lines"
expectOutput="7145 test.txt"
output=$(./wc -l test.txt | grep "$expectOutput")
if [[ -z "$output" ]]; then
  echo "$FAILED"
else
  echo "$PASSED"
fi

echo "[#6]\tShould handle -w: Count words"
expectOutput="58164 test.txt"
output=$(./wc -w test.txt | grep "$expectOutput")
if [[ -z "$output" ]]; then
  echo "$FAILED"
else
  echo "$PASSED"
fi

echo "[#7]\tShould handle -m: Count characters"
expectOutput="339292 test.txt"
output=$(./wc -m test.txt | grep "$expectOutput")
if [[ -z "$output" ]]; then
  echo "$FAILED"
else
  echo "$PASSED"
fi


