set -e
PATH="/bin:/usr/bin:/usr/local/bin:$PATH"
export PATH
program=`basename $0`

fatal() {
  echo "$program: Fatal error: $@" >&2
  exit 1
}

usage_nocd() {
  args=$1; min=$2; max=$3; shift 3
  if [ $args -lt $min -o $args -gt $max ]; then
    echo "$0: usage: $program $@" >&2
    exit 1
  fi
}

usage() {
  usage_nocd "$@"
  cd "${SVSCANDIR-/service}"
}

