#!/bin/bash
set -u
set -o pipefail
IFS=$'\n\t'

declare -i has_error=0

for i in $( ls -1 tests/*.lua ); do
	echo -e "\033[32mRunning test case: tests."$i"\033[0m"
	luanode run.lua $i
	if [ $? -ne 0 ]
	then
		echo -e "\033[1m\033[41mTest case failed: " $i "\033[0m"
		has_error=1
	fi
done

if [ $has_error -eq 0 ]; then
	echo "Ended without errors"
else
	echo "Ended with errors"
fi

exit $has_error
