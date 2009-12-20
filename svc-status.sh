usage 1 9999 service [service ...] "$@"
shift $(( $OPTIND - 1 ))

for svc in "$@"; do
  if svok "$svc"; then
    svstat "$svc"
    if [ -d "$svc/log" ]; then
      svstat "$svc"/log
    fi
  else
    echo "Supervise not running on $svc"
  fi
done
