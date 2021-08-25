# hasher  ( formerly mdfiver )
A simple bash script that creates an output file, listing the files within a folder and their generated hash. Originally, MD5 was used to generate the hash, until it was changed to sha256 to comply with certain requirements. 

The format of the file is not using the standard output, but following a certain reqiurement that is quite similiar. 

### Change log

|Version / Tag| Description  |
|--|--|
|  version_1| Initial implemenation that ran the generation from a given folder ( first attempt)  |	
version_1.2	 | Second attempt to use separate file as script
version_1.3 | Finalized the approach to run from the same folder, and added validation
version_1.4 | refactored to use SHA256
version_1.5 | Log genearation
version_1.6 | Modified script to allow generating of logs concurrently
versoin_1.6.1 | Documentation update


## TODOs
* Organize folder logs using the name of the inputted year
* Some enhancements
* Look into setting the sha256sum into background
