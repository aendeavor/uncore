set shell := [ "bash", "-eu", "-o", "pipefail", "-c" ]

export CDIR    := `realpath -e -L .`
VERSION        := "${VERSION}"

# -->                   -->                   --> DEFAULT

DEFAULT: help

@help:
  just --version ; echo
  just --list ; echo

# -->                   -->                   --> CODE

build release='': _require_realpath
  cargo build {{release}}

run:
  @ cargo run

bootimage:
  cargo bootimage

# -->                   -->                   --> FORMATTING

fmt: _require_realpath
  @ cargo fmt --manifest-path ./Cargo.toml --message-format human

# -->                   -->                   --> TESTS

full_test: lint code_test

code_test: fmt_test clippy_test cargo_test

test: cargo_test

@fmt_test:
  make fmt_test

@clippy_test:
  make clippy_test

@cargo_test:
  cargo test

lint: eclint shellcheck

@eclint:
  make eclint

@shellcheck:
  make shellcheck

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
  @ rustup override set nightly
