default:
	@echo "Ensuring permissoins"
	chmod +x *.sh

check:
	@echo "Checking destination folders ..."
	./folderChecker.sh

generate:
	@echo "Generating MD5s..."
	time ./md5Generator.sh ./input.txt