#!/usr/bin/env bash

# Splits the parts of a semantic version, each on a separate line
# Parameters:
#   $1 semantic version
# Output:
#   > major version number
#   > minor version number
#   > patch version
#   > pre-release label or . if none
#   > build metadata label or . if none
function main() {
  version=$1
  if [[ $version =~ ^(.*)(0|[1-9][0-9]*)\.(0|[1-9][0-9]*)\.(0|[1-9][0-9]*)(-((0|[1-9][0-9]*|[0-9]*[a-zA-Z-][0-9a-zA-Z-]*)(\.(0|[1-9][0-9]*|[0-9]*[a-zA-Z-][0-9a-zA-Z-]*))*))?(\+([0-9a-zA-Z-]+(\.[0-9a-zA-Z-]+)*))?$ ]]; then
    local major=${BASH_REMATCH[2]}
    local minor=${BASH_REMATCH[3]}
    local patch=${BASH_REMATCH[4]}
    local pre_release=${BASH_REMATCH[6]}
    local build=${BASH_REMATCH[11]}
    echo "$major"
    echo "$minor"
    echo "$patch"
    if [[ $pre_release == "" ]]; then
      echo "."
    else
      echo "$pre_release"
    fi
    if [[ $build == "" ]]; then
      echo "."
    else
      echo "$build"
    fi
  else
    echo "0"
    echo "0"
    echo "0"
    echo "."
    echo "."
  fi
}

main $1