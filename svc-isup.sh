usage 1 1 service "$@"
svok "$1"
svstat "$1" 2>/dev/null | fgrep ' up ' >/dev/null
