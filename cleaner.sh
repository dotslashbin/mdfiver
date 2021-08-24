#!/bin/sh
if [ "$#" -ne 1 ]; then 
	echo "You must supply the original input file with the list of directories."
	echo "Sample: ./cleaner.sh 2021.txt"
	exit 1
fi

script_start=`date +%s`

for folder in $(cat $1); do
	rm -vf $folder/*_FC-SHA256.txt
done

script_end=`date +%s`

echo "completed in `expr $script_end - $script_start` seconds"
