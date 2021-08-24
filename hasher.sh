#!/bin/sh

# creator=MD5MapCreator.sh

cleanup_previous_output() {
	folder=$1
	file=$2

	rm -f $folder/$file
}

create_ouput_file() {
	folder=$1
	file=$2
	permission=$3
	owner=$4
	group=$5

	touch $folder/$file
	chmod -v $permission $folder/$file
	chown -v $owner:$group $folder/$file
}

chmodvalue=$2
userval=$3
groupval=$4

if [ "$#" -ne 4 ]; then 
	echo "You must supply the required and valid inputs."
	echo "Sample: ./md5generator.sh input.txt 764 wasdamin users"
	exit 1
fi

script_start=`date +%s`
# Create Log for the script
SCRIPT_LOG_FILE=./logs/"${1}".log
touch $SCRIPT_LOG_FILE
echo "Script started ..." >> $SCRIPT_LOG_FILE
echo "processing file: $1" >> $SCRIPT_LOG_FILE

for folder in $(cat $1); do
	folder_eval_start=`date +%s`
	IFS="/" read -a container <<< $folder
	# echo "Array: ${container[@]}"
	max=${#container[@]}
	index="$(($max-1))"
	# echo "${container[4]}"
	basename="${container[$index]}"
	output="${basename}_FC-SHA256.txt"

	# Create Log file
	touch ./logs/folders/$basename.log
	LOG_FILE=./logs/folders/$basename.log

	# Cleans up the previous folder	
	cleanup_previous_output $folder $output

	#Creates the output file
	create_ouput_file $folder $output $chmodvalue $userval $groupval
	echo "FILE NAME,MD5HASH" >>$folder/$output
	
	COUNTER=0
	for file in $(find $folder -type f); do
		filename=$(basename $file)
		hash=$(sha256sum $file | awk '{print $1}')
		entry="${basename}\\${filename},${hash}"
		echo $entry >> $folder/$output
		echo "hashed $filename" >> $LOG_FILE
		COUNTER=$[$COUNTER +1]
	done

	folder_eval_end=`date +%s`

	sed -i "s/.\/// " $folder/$output

	echo "TOTAL TIME: `expr $folder_eval_end - $folder_eval_start` seconds" >> $LOG_FILE
	echo "PATH: $folder" >> $LOG_FILE
	echo "OUTPUT: $folder/$output" >> $LOG_FILE
	echo "TOTAL FILES: $COUNTER" >> $LOG_FILE
done

script_end=`date +%s`

echo "completed in `expr $script_end - $script_start` seconds" >> $SCRIPT_LOG_FILE
