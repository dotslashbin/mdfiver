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

	touch $folder/$file
}

for folder in $(cat $1); do
	IFS="/" read -a container <<< $folder
	# echo "Array: ${container[@]}"
	max=${#container[@]}
	index="$(($max-1))"
	# echo "${container[4]}"
	basename="${container[$index]}"
	output="$basename.md5"

	# Cleans up the previous folder	
	cleanup_previous_output $folder $output

	#Creates the output file
	create_ouput_file $folder $output
	echo "FILE NAME,MD5HASH" >>$folder/$output
	
	for file in $(find $folder -type f); do
		hash=$(md5sum $file | awk '{print $1}')
		entry="${basename}\\${filename},${hash}"
		echo $entry >> $folder/$output
	done

	# cp -vf ./$creator $folder
	# cd $folder
	# chmod +x $creator
	# ./$creator
done
