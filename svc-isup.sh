usage 1 1 '' service "$@"
shift $(( $OPTIND - 1 ))
svok "$1"
svstat "$1" 2>/dev/null | fgrep ' up ' >/dev/null
