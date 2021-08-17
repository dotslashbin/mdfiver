default:
	@echo "Ensuring permissoins"
	chmod +x *.sh

check:
	@echo "Checking destination folders ..."
	./folderChecker.sh