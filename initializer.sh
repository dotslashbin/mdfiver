#!/bin/sh

creator=MD5MapCreator.sh

for folder in $(cat ./input.txt); do
	echo "Copying reator to folder ..."
	cp -vf ./$creator $folder
	cd $folder
	chmod +x $creator
	./$creator
done
