#!/usr/bin/env bash

# Filters input down to just lines containing a specified prefix and semantic version.
# Parameters:
#   $1 tag prefix
# Output:
#   Lines which contain specified prefix followed by a semantic version
function main() {
  local expected_prefix=$1
  local line
  local prefix_length=${#expected_prefix}
  while IFS= read -r line; do
    if [[ ${#line} -le $prefix_length ]]; then continue
    fi
    local prefix=${line:0:$prefix_length}
    local target=${line:$prefix_length}
    if [[ $prefix == $expected_prefix && $target =~ ^(0|[1-9][0-9]*)\.(0|[1-9][0-9]*)\.(0|[1-9][0-9]*)(-((0|[1-9][0-9]*|[0-9]*[a-zA-Z-][0-9a-zA-Z-]*)(\.(0|[1-9][0-9]*|[0-9]*[a-zA-Z-][0-9a-zA-Z-]*))*))?(\+([0-9a-zA-Z-]+(\.[0-9a-zA-Z-]+)*))?$ ]]; then
      echo $target
    fi
  done
}

main $1