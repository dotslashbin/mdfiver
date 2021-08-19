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

	# Cleans up the previous folder	
	cleanup_previous_output $folder $output

	#Creates the output file
	create_ouput_file $folder $output $chmodvalue $userval $groupval
	echo "FILE NAME,MD5HASH" >>$folder/$output
	
	COUNTER=0
	for file in $(find $folder -type f); do
		filename=$(basename $file)
		hash=$(md5sum $file | awk '{print $1}')
		entry="${basename}\\${filename},${hash}"
		echo $entry >> $folder/$output
		echo "hashed $filename" >> ./logs/$basename.log
		COUNTER=$[$COUNTER +1]
	done

	end=`date +%s`

	sed -i "s/.\/// " $folder/$output

	echo "TOTAL TIME: `expr $end - $start` seconds" >> ./logs/$basename.log
	echo "PATH: $folder" >> ./logs/$basename.log
	echo "OUTPUT: $folder/$output" >> ./logs/$basename.log
	echo "TOTAL FILES: $COUNTER" >> ./logs/$basename.log
done
