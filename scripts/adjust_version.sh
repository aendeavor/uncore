#! /bin/bash

: '
# ? version       v0.1.0 RC1 PRODUCTION STABLE
# ? executed by   just
# ? task          updates the version in all files
'

# shellcheck source=./lib/errors.sh
. scripts/lib/errors.sh
# shellcheck source=./lib/logs.sh
. scripts/lib/logs.sh

export SCRIPT='VERSION ADJUSTMENT'

# -->                   -->                   --> START

if [[ ! ${1} =~ [0-9]+\.[0-9]+\.[0-9]+ ]]
then
  __log_warning \
    'You did not provide a version tag' \
    'with adheres to semantic versioning'
  __log_abort \
    'aborting due to previous warning'
  
  exit 1
fi

__log_info 'new version is:' \
  "${1}" "${RC}" "${STAGE}" "${STATUS}"
  
sed -E -i \
  "s/VERSION='[0-9]+\.[0-9]+\.[0-9]+'/VERSION='${1}'/g" .env

sed -E -i \
  "s/v[0-9]+\.[0-9]+\.[0-9]+-black/v${1}-black/g" README.md

sed -E -i \
  "s/(rc|RC)[0-9]+-[a-zA-Z0-9]+-F7F5FB/${RC}-${STAGE}-F7F5FB/g" README.md

sed -E -i \
  "s/[a-zA-Z]+-FBB444/${STATUS}-FBB444/g" README.md

sed -E -i \
  "s/version = \"[0-9]+\.[0-9]+\.[0-9]+\"/version = \"${1}\"/" Cargo.toml

