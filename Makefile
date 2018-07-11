.PHONY: build-all build-osx build-linux

build-all: build-osx build-linux

build-xcode:
	@build.py --toolchain osx-10-13 --verbose --clear --reconfig --jobs 4

build-gcc:
	@build.py --toolchain gcc --verbose --clear --reconfig --jobs 4

build-libcxx:
	@build.py --toolchain libcxx --verbose --clear --reconfig --jobs 4

deps:
	@cd .. && wget https://github.com/ruslo/polly/archive/master.zip && unzip master.zip
	@POLLY_ROOT="`pwd`/../polly-master"
	@echo "WARNING !!! Please add to your ~/.bash_profile: export PATH=\"\${POLLY_ROOT}/bin:\${PATH}\""