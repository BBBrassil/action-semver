#!/usr/bin/env bash

# Splits the elements of a semantic version, separated by spaces.
# Parameters:
#   $1 semantic version
# Output:
#   - "[major] [minor] [patch] [pre-release] [build]"
#   - Optional elements are output as "." if not present
#   - "0 0 0 . ." if input is not a valid semantic version
function main() {
  local version=$1
  if [[ $version =~ ^(.*)(0|[1-9][0-9]*)\.(0|[1-9][0-9]*)\.(0|[1-9][0-9]*)(-((0|[1-9][0-9]*|[0-9]*[a-zA-Z-][0-9a-zA-Z-]*)(\.(0|[1-9][0-9]*|[0-9]*[a-zA-Z-][0-9a-zA-Z-]*))*))?(\+([0-9a-zA-Z-]+(\.[0-9a-zA-Z-]+)*))?$ ]]; then
    local major=${BASH_REMATCH[2]}
    local minor=${BASH_REMATCH[3]}
    local patch=${BASH_REMATCH[4]}
    local pre_release=${BASH_REMATCH[6]}
    if [[ $pre_release == "" ]]; then
      pre_release="."
    fi
    local build=${BASH_REMATCH[11]}
    if [[ $build == "" ]]; then
      build="."
    fi
    echo "$major $minor $patch $pre_release $build"
  else
    echo "0 0 0 . ."
  fi
}

main $1