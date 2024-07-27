cargo build
cp target/debug/xxd .

GREEN="\033[0;32m"
RED="\033[0;31m"
NOCOLOR="\033[0m"

PASSED="\t${GREEN}PASSED${NOCOLOR}"
FAILED="\t${RED}FAILED${NOCOLOR}"

echo "[#1]\tShould print correctly"
expectOutput=$(xxd files.tar | md5)
actual=$(./xxd files.tar | md5)
if [[ "$expectOutput" == "$actual" ]]; then
  echo "$PASSED"
else
  echo "$FAILED"
  echo "\tExpect: $expectOutput"
  echo "\tActual: $actual"
fi

echo "[#2]\tShould print with custom group size"
expectOutput=$(xxd -g 8 files.tar | md5)
actual=$(./xxd -g 8 files.tar | md5)
if [[ "$expectOutput" == "$actual" ]]; then
  echo "$PASSED"
else
  echo "$FAILED"
  echo "\tExpect: $expectOutput"
  echo "\tActual: $actual"
fi

echo "[#3]\tShould print in little endian with default group size of 4"
expectOutput=$(xxd -e files.tar | md5)
actual=$(./xxd -e files.tar | md5)
if [[ "$expectOutput" == "$actual" ]]; then
  echo "$PASSED"
else
  echo "$FAILED"
  echo "\tExpect: $expectOutput"
  echo "\tActual: $actual"
fi

echo "[#4]\tShould print in little endian with custom group size"
expectOutput=$(xxd -e -g 8 files.tar | md5)
actual=$(./xxd -e -g 8 files.tar | md5)
if [[ "$expectOutput" == "$actual" ]]; then
  echo "$PASSED"
else
  echo "$FAILED"
  echo "\tExpect: $expectOutput"
  echo "\tActual: $actual"
fi

rm xxd
