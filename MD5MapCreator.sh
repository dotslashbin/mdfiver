# Author: Joshua Fuentes
#
# This script will generate an *.md5 file formatted according to the requirements.
#!/bin/sh

# Init
currentdir=$(basename "$PWD")
output=$currentdir.md5

# Creates the header
echo "FILE NAME,MD5HASH" >>$output

# Generates the MD5 hash and writes to the output file
for file in $(find . -type f); do
	filename=$(basename $file)
	if [ $filename != $output ] && [ $filename != "MD5MapCreator.sh" ]; then
		hash=$(md5sum $file | awk '{print $1}')
		entry="${currentdir}\\${filename},${hash}"
		echo $entry >>$output
	fi
done

# String replacement to format the output file
sed -i "s/.\/// " $output
