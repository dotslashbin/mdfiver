#!/bin/sh

# creator=MD5MapCreator.sh



cleanup_previous_output() {
	folder=$1
	file=$2

	rm -f $folder/$file
}

for folder in $(cat $1); do
	IFS="/" read -a container <<< $folder
	# echo "Array: ${container[@]}"
	max=${#container[@]}
	index="$(($max-1))"
	# echo "${container[4]}"
	output="${container[$index]}.md5"
	echo $folder
	echo $output

	cleanup_previous_output $folder $output
	# for file in $(find $folder -type f); do
		
	# done

	# cp -vf ./$creator $folder
	# cd $folder
	# chmod +x $creator
	# ./$creator
done
