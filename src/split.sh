#!/usr/bin/env bash

function main() {
  version=$1
  if [[ $version =~ ^(.*)(0|[1-9][0-9]*)\.(0|[1-9][0-9]*)\.(0|[1-9][0-9]*)(-((0|[1-9][0-9]*|[0-9]*[a-zA-Z-][0-9a-zA-Z-]*)(\.(0|[1-9][0-9]*|[0-9]*[a-zA-Z-][0-9a-zA-Z-]*))*))?(\+([0-9a-zA-Z-]+(\.[0-9a-zA-Z-]+)*))?$ ]]; then	local prefix=${BASH_REMATCH[1]}
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