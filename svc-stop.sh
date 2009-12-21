usage 1 9999 "service [service ...]" "$@"
shift $(( $OPTIND - 1 ))

stop() {
  touch "$1"/down
  if svc-isup "$1"; then
    svc -d "$1"
    if svc-waitdown "$1"; then
      echon "$1 "
    else
      fatal "Failed to stop '$1'."
    fi
  else
    echon "$1 (already down) "
  fi
}

for svc in "$@"; do

  if ! [ -d "$svc" -o -L "$svc" ]; then
    fatal "Service '$svc' does not exist."
  fi

  echon "Stopping $svc: "

  stop "$svc"

  if [ -d "$svc/log" ]; then
    stop "$svc/log"
  fi

  echo "done."

done
