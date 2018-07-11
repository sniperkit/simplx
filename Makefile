.PHONY: build-%

# build-all: build-osx build-linux
print-%: ; @echo $*=$($*)

build-%:
	@build.py --toolchain $* --verbose --clear --reconfig --jobs 4

toolchains:
	@build.py --help | sed -n '/Script for building. Available toolchains/,/optional arguments/p'

deps:
	@cd .. && wget https://github.com/ruslo/polly/archive/master.zip && unzip master.zip
	@POLLY_ROOT="`pwd`/../polly-master"
	@echo "WARNING !!! Please add to your ~/.bash_profile: export PATH=\"\${POLLY_ROOT}/bin:\${PATH}\""

help: ## this help
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {sub("\\\\n",sprintf("\n%22c"," "), $$2);printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)