SHELL = /bin/bash

.SHELLFLAGS := -eu -o pipefail -c
.DELETE_ON_ERROR:

MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules

.PHONY: run_always set_nightly

all: run_always build

set_nightly:
	@ rustup override set nightly

build: run_always
	@ mkdocs build
	@ ./build.sh build

publish:
	@ ./build.sh publish

serve: run_always
	@ mkdocs serve -a 127.0.0.1:8080

installdeps:
	@ sudo apt-get install python3 python3-pip
	@ pip3 install mkdocs mkdocs-material
