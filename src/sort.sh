#!/usr/bin/env bash

# Sorts input by semantic versioning order.
# Output:
#   Lines in descending semantic versioning order (latest to earliest)
function main() {
  sed "/-/!{s/$/_/}" | sort -V -r | sed "s/_$//"
}

main