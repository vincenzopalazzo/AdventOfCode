default:
	roc run main.roc

compiler:
	cd /tmp; wget https://github.com/roc-lang/roc/releases/download/nightly/roc_nightly-linux_x86_64-2022-12-01-d2d8511.tar.gz;
	cd /tmp; tar -xf roc_nightly-linux_x86_64-2022-12-01-d2d8511.tar.gz;
	cd /tmp; rm -rf roc_nightly-linux_x86_64-2022-12-01-d2d8511.tar.gz;
	cd /tmp; export PATH=$PATH:$(pwd); roc --help
