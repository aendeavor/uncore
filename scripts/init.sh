#! /bin/bash

: '
# ? version       v0.1.0 RC1 ALPHA1 UNSTABLE
# ? executed by   just
# ? task          handles init jobs
'

# shellcheck source=./lib/errors.sh
. scripts/lib/errors.sh
# shellcheck source=./lib/logs.sh
. scripts/lib/logs.sh

export SCRIPT='INIT'

# -->                   -->                   --> START

function __install_deps
{
  __log_info "installing dependencies"

  rustup override set nightly
  rustup component add llvm-tools-preview

  cargo install cargo-xbuild bootimage

  sudo apt-get install qemu-system-x86
}

function _main
{
  case ${*} in
    "install deps" ) __install_deps ;;
    * ) 
      echo "No task provided. Aborting. (init.sh)"
      exit 1
      ;;
  esac
}

_main "${@}"
