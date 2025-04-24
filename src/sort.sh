#!/usr/bin/env bash

function main() {
  sed "/-/!{s/$/_/}" | sort -V -r | sed "s/_$//"
}

main