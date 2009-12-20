set -e
PATH="/bin:/usr/bin:/usr/local/bin:$PATH"
export PATH
program=`basename $0`

fatal() {
  echo "$program: Fatal error: $@" >&2
  exit 1
}

usage_nocd() {
  min=$1; max=$2; msg=$3; shift 3

  while getopts qg flag; do
    case $flag in
      q)
        exec >/dev/null
	;;
      \? | :)
        exit 1
	;;
      ?)
        eval "opt_${flag}=1"
	;;
    esac
  done

  shift=$(( $OPTIND - 1 ))
  shift $shift

  if [ $# -lt $min -o $# -gt $max ]; then
    echo "$0: usage: $program [-q] $msg" >&2
    exit 1
  fi
}

usage() {
  usage_nocd "$@"
  cd "${SVSCANDIR-/service}"
}

