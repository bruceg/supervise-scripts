opt_l=false
usage 1 9999 '' "[-l] [SIGNAL] service [service ...]" "$@"
shift $(( $OPTIND - 1 ))

if $opt_l; then
    echo "svc-kill accepts the following signals:"
    echo "SIGALRM"
    echo "SIGCONT"
    echo "SIGHUP"
    echo "SIGINT"
    echo "SIGKILL"
    echo "SIGSTOP"
    echo "SIGTERM (default)"
    exit 0
fi

flag=-t
case $1 in
    SIGSTOP | STOP     ) flag=-p; shift;;
    SIGCONT | CONT     ) flag=-c; shift;;
    SIGHUP  | HUP  |  1) flag=-h; shift;;
    SIGALRM | ALRM | 14) flag=-a; shift;;
    SIGINT  | INT  |  2) flag=-i; shift;;
    SIGTERM | TERM | 15) flag=-t; shift;;
    SIGKILL | KILL |  9) flag=-k; shift;;
esac

if [ $# -lt 1 ]; then
    echo "$0: No services named to kill"
    exit 1
fi

exec svc $flag "$@"
