default: fmt
	v main.v -o adventure2021


compiler:
		@echo "Installing V compiler\n\n"
		mkdir tmp && cd tmp && wget https://github.com/vlang/v/releases/download/0.3.2/v_linux.zip && unzip v_linux.zip;
		cd tmp/v && sudo ./v symlink

fmt:
	v fmt -w day* main.v

clean:
	rm v
