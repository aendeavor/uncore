#! /bin/bash

: '
# ? version       v0.1.1 RC1 PRODUCTION STABLE
# ? executed by   just / make / manually
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
  # shellcheck disable=SC2034
  local SHELLCHECK_VERSION='0.7.0-2build2'
  local ECLINT_VERSION='2.2.0'

  __log_info "installing dependencies"

  sudo apt-get -qq --fix-missing update
  sudo apt-get -qq -y --no-install-recommends install shellcheck wget qemu-system-x86 python3 python3-pip make

  rustup override set nightly-2020-11-09
  rustup component add llvm-tools-preview

  cargo install cargo-xbuild bootimage just

  pip3 install mkdocs mkdocs-material

  cd /tmp
  wget -qq "https://github.com/editorconfig-checker/editorconfig-checker/releases/download/${ECLINT_VERSION}/ec-linux-amd64.tar.gz"
  tar xf ec-linux-amd64.tar.gz && chmod +x bin/ec-linux-amd64 && sudo mv bin/ec-linux-amd64 /usr/bin/eclint

  __log_success 'finished installing dependencies'
}

function _main
{
  case ${*} in
    "install deps" ) __install_deps ;;
    * ) 
      echo "(init.sh) :: No task provided. Exiting."
      exit 1
      ;;
  esac
}

_main "${@}"
