default:
	@cd .tmp; export PATH=$(PATH):$(shell pwd)/.tmp; cd ..; roc run main.roc

compiler:
	mkdir .tmp; cd .tmp; wget https://github.com/roc-lang/roc/releases/download/nightly/roc_nightly-linux_x86_64-2022-12-04-9becbed.tar.gz;
	cd .tmp; tar -xf roc_nightly-linux_x86_64-2022-12-04-9becbed.tar.gz;
	cd .tmp; rm -rf roc_nightly-linux_x86_64-2022-12-04-9becbed.tar.gz;
	@echo "run make to run the program"
