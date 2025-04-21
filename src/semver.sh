#!/usr/bin/env bash

function bump_number() {
  local current=$1
  local delta=$2
  if [[ $delta == "*" ]]; then
    echo "$current"
  elif [[ $delta =~ ^([-\+])?(0|[1-9][0-9]*)?$ ]]; then
    local op=${BASH_REMATCH[1]}
	local value=${BASH_REMATCH[2]}
    if [[ $value == "" ]]; then
      value="1"
    fi
	if [[ $op == "+" ]]; then
	  echo "$(($current + $value))"
	elif [[ $op == "-" ]]; then
	  echo "$(($current - $value))"
	else
	  echo "$value"
	fi
  else
    echo ""
  fi
}

function bump_word() {
  local current=$1
  local delta=$2
  if [[ $delta == "*" ]]; then
    echo "$current"
  else
    echo "$delta"
  fi
}

function bump() {
  local current=$1
  local delta=$2
  if [[ $current =~ ^(.*)(0|[1-9][0-9]*)\.(0|[1-9][0-9]*)\.(0|[1-9][0-9]*)(-((0|[1-9][0-9]*|[0-9]*[a-zA-Z-][0-9a-zA-Z-]*)(\.(0|[1-9][0-9]*|[0-9]*[a-zA-Z-][0-9a-zA-Z-]*))*))?(\+([0-9a-zA-Z-]+(\.[0-9a-zA-Z-]+)*))?$ ]]; then
	local prefix=${BASH_REMATCH[1]}
	local major=${BASH_REMATCH[2]}
	local minor=${BASH_REMATCH[3]}
	local patch=${BASH_REMATCH[4]}
	local prerelease=${BASH_REMATCH[6]}
	local build=${BASH_REMATCH[11]}
	if [[ $delta =~ ^(major|minor|patch|((.*)(\*|[-\+]|([-\+]?(0|[1-9][0-9]*)))\.(\*|[-\+]|([-\+]?(0|[1-9][0-9]*)))\.(\*|[-\+]|([-\+]?(0|[1-9][0-9]*)))))(-(\*|((0|[1-9][0-9]*|[0-9]*[a-zA-Z-][0-9a-zA-Z-]*)(\.(0|[1-9][0-9]*|[0-9]*[a-zA-Z-][0-9a-zA-Z-]*))*)))?(\+(\*|([0-9a-zA-Z-]+(\.[0-9a-zA-Z-]+)*)))?$ ]]; then
	  local keyword=${BASH_REMATCH[1]}
	  local dmajor=${BASH_REMATCH[4]}
	  local dminor=${BASH_REMATCH[7]}
	  local dpatch=${BASH_REMATCH[10]}
	  local dprerelease=${BASH_REMATCH[14]}
	  local dbuild=${BASH_REMATCH[20]}
	  if [[ $keyword == "major" ]]; then
	    major=$(bump_number "$major" "+")
		minor="0"
		patch="0"
	  elif [[ $keyword == "minor" ]]; then
	    minor=$(bump_number "$minor" "+")
		patch="0"
	  elif [[ $keyword == "patch" ]]; then
	    patch=$(bump_number "$patch" "+")
	  else
	    major=$(bump_number "$major" "$dmajor")
	    minor=$(bump_number "$minor" "$dminor")
	    patch=$(bump_number "$patch" "$dpatch")
	  fi
	  prerelease=$(bump_word "$prerelease" "$dprerelease")
	  build=$(bump_word "$build" "$dbuild")
	  local v="$prefix$major.$minor.$patch"
	  if [[ $prerelease != "" ]]; then
	    v+="-$prerelease"
	  fi
	  if [[ $build != "" ]]; then
	    v+="+$build"
	  fi
	  echo "$v"
	else
	  echo ""
	fi
  else
    echo ""
  fi
}

bump $1 $2
