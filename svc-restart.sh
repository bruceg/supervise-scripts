usage 1 9999 "service [service ...]" "$@"
shift $(( $OPTIND - 1 ))

for svc in "$@"; do

  svc-stop "$svc"

  svc-start "$svc"

done
