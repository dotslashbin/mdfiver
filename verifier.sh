#!/bin/bash

while read line; do 
	ls -a $line | grep -i ".md5"
	testvalue=$?
	if [ $testvalue -eq 1 ]
	then
		echo "no md5 file found on $line"
	fi
done < ./source.txt