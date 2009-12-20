usage 1 1 '' service "$@"
shift $(( $OPTIND - 1 ))
svstat "$1" 2>/dev/null | fgrep -v ' up ' >/dev/null
