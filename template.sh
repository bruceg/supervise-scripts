#!/bin/sh
set -e
PATH="/bin:/usr/bin:/usr/local/bin:$PATH"
export PATH
cd "${SVSCANDIR-/service}"

fatal() {
  echo "%PROGRAM%: Fatal error: $@" >&2
  exit 1
}

usage() {
  args=$1; min=$2; max=$3; shift 3
  if [ $args -lt $min -o $args -gt $max ]; then
    echo "$0: usage: %PROGRAM% $@" >&2
    exit 1
  fi
}

