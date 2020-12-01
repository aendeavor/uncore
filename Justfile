set shell := [ "bash", "-eu", "-o", "pipefail", "-c" ]

export CDIR    := `realpath -e -L .`
CC             := "cargo"
VERSION        := "${VERSION}"

# -->                   -->                   --> DEFAULT

DEFAULT: help

@help:
  just --version ; echo
  just --list ; echo

# -->                   -->                   --> CODE

build release='': _require_realpath
  {{CC}} build {{release}}

run:
  @ {{CC}} run

bootimage:
  {{CC}} bootimage

# -->                   -->                   --> FORMATTING

fmt: _require_realpath
  @ {{CC}} fmt --manifest-path ./Cargo.toml --message-format human

# -->                   -->                   --> TESTS

full_test: lint code_test

code_test: fmt_test clippy_test test

test: test_bin test_lib test_integration_tests

@fmt_test:
  {{CC}} fmt --manifest-path ./Cargo.toml --message-format human -- --check

@clippy_test:
  {{CC}} clippy --all-targets --all-features -- -D warnings

test_bin:
  @ {{CC}} test --bin uncore

test_lib:
  @ {{CC}} test --lib

test_integration_tests:
  @ {{CC}} test --test '*'

lint: eclint shellcheck fmt_test clippy_test

@eclint:
  ./lints/eclint.sh

@shellcheck:
  ./lints/shellcheck.sh

# -->                   -->                   --> DOCUMENTATION

docs target='serve': _require_realpath
  cd documentation && make {{target}}

# -->                   -->                   --> VERSIONING

export RC     := `echo "${V_TAGS_RC}"`
export STAGE  := `echo "${V_TAGS_STAGE}"`
export STATUS := `echo "${V_TAGS_STATUS}"`
update_version new_version=VERSION: _require_realpath
  @ ./scripts/adjust_version.sh {{new_version}}

# -->                   -->                   --> HELPER

install package *manager:
  #! /bin/bash
  if [[ "{{manager}}" =~ "cargo" ]]
  then
    cargo install {{package}}
  elif [[ "{{package}}" =~ "deps" ]]
  then
    ./scripts/init.sh install deps
  else
    sudo apt-get install {{package}}
  fi

_require_realpath:
  @ cd {{CDIR}}

_require_nightly:
  @ rustup override set nightly >/dev/null
