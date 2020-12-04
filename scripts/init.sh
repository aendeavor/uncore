#! /bin/bash

: '
# ? version       v0.1.0 RC1 PRODUCTION STABLE
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

  rustup override set nightly-2020-11-09
  rustup component add llvm-tools-preview

  cargo install cargo-xbuild bootimage

  sudo apt-get install qemu-system-x86

  local ECLINT_VERSION='2.2.0'
  local SHELLCHECK_VERSION='0.7.0-2build2'

  sudo apt-get -qq --fix-missing update
  sudo apt-get -qq -y --no-install-recommends install shellcheck="${SHELLCHECK_VERSION}" wget

  cd /tmp
  wget -qq --no-check-certificate "https://github.com/editorconfig-checker/editorconfig-checker/releases/download/${ECLINT_VERSION}/ec-linux-amd64.tar.gz"
  tar xf ec-linux-amd64.tar.gz && chmod +x bin/ec-linux-amd64 && sudo mv bin/ec-linux-amd64 /usr/bin/eclint
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
