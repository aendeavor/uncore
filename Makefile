SHELL = /bin/bash
.SHELLFLAGS := -eu -o pipefail -c

.DELETE_ON_ERROR:

MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules

CC = cargo

.PHONY: run_always

all: help
help: run_always
	@ just help

lint: eclint shellcheck

eclint:
	./lints/eclint.sh

shellcheck:
	./lints/shellcheck.sh

code_test: fmt_test clippy_test

fmt_test:
	$(CC) fmt --manifest-path ./Cargo.toml --message-format human -- --check

clippy_test:
	$(CC) clippy --all-targets --all-features -- -D warnings

clean:
	$(CC) clean

run_always:
