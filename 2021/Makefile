default:
	@echo "Compile main"
	v main.v -o adventure2021


compiler:
		@echo "Installing V compiler from the actual master version\n\n"
		mkdir tmp && cd tmp && git clone https://github.com/vlang/v && cd v && make && sudo ./v symlink


clean:
	rm v
