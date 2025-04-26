#!/usr/bin/env bash

# Filters input down to just lines containing a specified prefix and semantic version.
# Parameters:
#   $1 tag prefix
# Output:
#   Lines which contain specified prefix followed by a semantic version
function main() {
  local expected_prefix=$1
  local line
  prefix_length=${#expected_prefix}
  while IFS= read -r line; do
    if [[ $line =~ ^(.*)(0|[1-9][0-9]*)\.(0|[1-9][0-9]*)\.(0|[1-9][0-9]*)(-((0|[1-9][0-9]*|[0-9]*[a-zA-Z-][0-9a-zA-Z-]*)(\.(0|[1-9][0-9]*|[0-9]*[a-zA-Z-][0-9a-zA-Z-]*))*))?(\+([0-9a-zA-Z-]+(\.[0-9a-zA-Z-]+)*))?$ ]]; then
      local prefix=${BASH_REMATCH[1]}
      if [[ $prefix == $expected_prefix ]]; then
        echo ${line:$prefix_length}
      fi
    fi
  done
}

main $1