#!/bin/sh

for i in $( ls -1 --hide=disabled tests ); do
	echo "\033[32mRunning test case: tests."$i"\033[0m" 
	luanode run.lua tests.$i
	if [ $? -ne 0 ]
	then
		echo -e "\033[1m\033[41mTest case failed: " $i "\033[0m"
		break;
	fi
done

echo "Ended without errors"
