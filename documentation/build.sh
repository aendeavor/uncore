#! /bin/bash

: '
# ? version       v0.2.0 RC1 PRODUCTION STABLE
# ? executed by   make
# ? task          build documentation container properly 
'

. ../scripts/lib/errors.sh
. ../scripts/lib/logs.sh

set -eEuo pipefail

SCRIPT="BUILD DOCUMNENTATION"
IMAGE='registry.itbsd.com/georg/uncore/docs'
VERSION_TAG='stable'

trap 'unset CDIR SCRIPT' EXIT

# -->                   -->                   --> START

function log
{
  case $1 in
    1) # PHASE
      printf '%s PHASE {\n' "${2}"
      ;;
    2) # STAGE
      printf '  (%s/%s) : %s\n' "${2}" "${3}" "${4}"
      ;;
    3) # MSG SUCCESS
      printf '    \e[32m->\e[0m %s\n' "${2}"
      ;;
    4) # MSG FAILURE
      printf '    \e[31m->\e[0m %s\n' "${2}"
      ;;
    5) # PHASE SUCCESS
      printf '} \e[32m✓\e[0m\n'
      ;;
    *)
      return 1
      ;;
  esac
}

function _check
{
  : >.log

  if ! command -v docker &>/dev/null
  then
    printf 'Docker not in PATH or not installed.'
    return 1
  fi

  if ! command -v cargo &>/dev/null
  then
    printf 'Cargo not in PATH or not installed.'
    return 1
  fi
}

function _build
{
  local MUSL_TAG=':nightly-2020-08-26'
  local rust_musl_builder
  rust_musl_builder="docker run --rm -it -v $(pwd):/home/rust/src ekidd/rust-musl-builder${MUSL_TAG}"

  log 1 'BUILD'
  log 2 1 2 'RUST'
  log 3 "Using rust-musl-builder${MUSL_TAG}"

  if ! ${rust_musl_builder} cargo build --release --color never &>.log
  then
    log 4 'Could not compile sources. Check logfile.'
    return 1
  fi

  log 2 2 2 'DOCKER'

  if ! docker build -t "${IMAGE}:${VERSION_TAG}" . >/dev/null 2>.log
  then
    log 4 'Could not build Docker image. Check logfile.'
    return 1
  fi

  log 3 "Built ${IMAGE}"
  log 5
}

function _publish
{
  log 1 'PUBLISH'
  log 2 1 4 'LOGIN'
  
  printf '    \e[32m->\e[0m Password: '
  if ! docker login -u georg registry.itbsd.com >/dev/null 2>.log
  then
    printf '\e[31m✕\e[0m\n'
    log 4 'Login unsuccessful'
    return 200
  fi
  printf '\e[32m✓\e[0m\n'

  log 3 "Version tag is ':${VERSION_TAG}'"
  log 2 2 3 'PUSHING'

  if ! docker push "${IMAGE}:${VERSION_TAG}" >/dev/null 2>.log
  then
    log 4 'Push unsuccessful. Check logfile.'
    return 201
  fi

  docker logout &>/dev/null
  log 2 3 3 'LOGOUT'
  log 5
}

function main
{
  case ${1} in
    'build'   ) _check && _build ;;
    'publish' ) _publish         ;;
    *         ) return 2         ;;
  esac
}

main "${@}"
