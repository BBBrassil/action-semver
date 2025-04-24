#!/usr/bin/env bash

function transform() {
  local expected_prefix=$1
  local line
  prefix_length=${#expected_prefix}
  while IFS= read -r line; do
    if [[ $line =~ ^(.+)-(.+)$ ]]; then
        echo "$line_"
    else
        echo "$line"
    fi
  done
}

function my_sort() {
    transformed=$(transform)
    echo "$transformed" | sort -V
}

my_sort