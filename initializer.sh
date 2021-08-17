#!/bin/sh

creator=MD5MapCreator.sh

for folder in $(cat $1); do
	echo "Copying reator to folder ..."
	cp -vf ./$creator $folder
	cd $folder
	chmod +x $creator
	./$creator
done
