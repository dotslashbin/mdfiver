#!/bin/sh

# creator=MD5MapCreator.sh

cleanup_previous_output() {
	folder=$1
	file=$2

	rm -f $folder/$file
}

# Removes the creator script from the curent folder
cleanup_operation_folder() {
	rm -vf MD5MapCreator.sh
}

executiondir=$PWD

for folder in $(cat $1); do
	start=`date +%s`
	IFS="/" read -a container <<< $folder
	# echo "Array: ${container[@]}"
	max=${#container[@]}
	index="$(($max-1))"
	# echo "${container[4]}"
	basename="${container[$index]}"
	output="$basename.md5"

	# Create Log file
	touch ./logs/$basename.log

	# Deleting previous output
	cleanup_previous_output $folder $output

	# Copying the execution script to folder of operation
	echo "Copying creator script ..."
	cp -vf ./MD5MapCreator.sh $folder

	# Going to folder and running the script
	cd $folder
	./MD5MapCreator.sh

	# Cleans the operation folder by removing the script
	cleanup_operation_folder

	cd $executiondir

	end=`date +%s`


	echo "TOTAL TIME: `expr $end - $start` seconds" >> ./logs/$basename.log
	echo "PATH: $folder" >> ./logs/$basename.log
	echo "OUTPUT: $folder/$output" >> ./logs/$basename.log

done
