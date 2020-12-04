set shell := [ "bash", "-eu", "-o", "pipefail", "-c" ]

export CDIR  := `realpath -e -L .`
CC           := "cargo"
VERSION      := "${VERSION}"
TOOLCHAIN    := "nightly-2020-11-09"

# -->                   -->                   --> DEFAULT

DEFAULT: help

@help:
  just --version ; echo
  just --list ; echo

# -->                   -->                   --> BUILDING & RUNNING

build release='': _require_realpath
  {{CC}} build {{release}}

run:
  @ {{CC}} run

bootimage:
  {{CC}} bootimage

# -->                   -->                   --> CODE ADJUSTMENTS

fmt: _require_realpath
  @ {{CC}} fmt --manifest-path ./Cargo.toml --message-format human

# -->                   -->                   --> LINTING TESTS

lint: eclint shellcheck fmt_check

eclint:
  @ ./scripts/lints/eclint.sh

shellcheck:
  @ ./scripts/lints/shellcheck.sh

fmt_check:
  @ {{CC}} fmt -- --check

# -->                   -->                   --> CODE TESTS

full_test: lint test

test: clippy test_bin test_lib test_integration_tests

clippy:
  @ {{CC}} clippy --all-targets --all-features -- -D warnings

test_bin:
  @ {{CC}} test --bin uncore

test_lib:
  @ {{CC}} test --lib

test_integration_tests:
  @ {{CC}} test --test '*'

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

_nightly:
  @ rustup override set {{TOOLCHAIN}} 2>&1 | grep -v -E 'info|nightly'
