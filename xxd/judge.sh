cargo build

GREEN="\033[0;32m"
RED="\033[0;31m"
NOCOLOR="\033[0m"

PASSED="\t${GREEN}PASSED${NOCOLOR}"
FAILED="\t${RED}FAILED${NOCOLOR}"

echo "[#1]\tShould print correctly"
expectOutput=$(xxd files.tar | md5)
actual=$(./target/debug/xxd files.tar | md5)
if [[ "$expectOutput" == "$actual" ]]; then
  echo "$PASSED"
else
  echo "$FAILED"
  echo "\tExpect: $expectOutput"
  echo "\tActual: $actual"
fi
