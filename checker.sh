#!/bin/sh

if [ "$#" -ne 1 ]; then
	echo "You must supply the required and valid inputs."
	echo "Sample: ./checker.sh input.txt"
	exit 1
fi

script_start=$(date +%s)
# Create Log for the script
SCRIPT_LOG_FILE=checking-"${1}".log
touch $SCRIPT_LOG_FILE
echo "Script started ..." >>$SCRIPT_LOG_FILE
echo "processing file: $1" >>$SCRIPT_LOG_FILE


echo "No checksum on ..." >> $SCRIPT_LOG_FILE

for folder in $(cat $1); do
	result=$(ls $folder/*_FC-SHA256.txt | wc -l)
	if [[ $result -eq 0 ]]; then
		echo "NONE on ${folder}"
		echo $folder >> $SCRIPT_LOG_FILE
	fi

done

script_end=$(date +%s)

echo "completed in $(expr $script_end - $script_start) seconds" >>$SCRIPT_LOG_FILE
