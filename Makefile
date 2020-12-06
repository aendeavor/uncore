SHELL = /bin/bash
.SHELLFLAGS := -eu -o pipefail -c

.DELETE_ON_ERROR:

MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules

CC = cargo

.PHONY: run_always
run_always:

all: build run_always

build: run_always
	@ $(CC) build

clean:
	$(CC) clean

dependencies:
	@ ./scripts/init.sh install deps
