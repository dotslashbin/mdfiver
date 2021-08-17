#!/bin/bash

for folder in $(cat ./input.txt); do
	count=$(ls $folder | wc -l)
	echo $count ... $folder
	# if [[$count -gt 0]]; then
	# 	echo "$folder is OK"
	# fi
done
