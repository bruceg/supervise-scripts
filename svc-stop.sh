opt_k=false
usage 1 9999 'k' "[-k] service [service ...]" "$@"
shift $(( $OPTIND - 1 ))

stopandwait() {
  if svc-isup "$1"; then
    svc $2 "$1"
    svc-waitdown "$1" && echon "$1 "
  else
    echon "$1 (already down) "
  fi
}

stop() {
  touch "$1"/down
  if stopandwait "$1" -d; then
    return
  fi
  if $opt_k; then
    echon " Failed to stop, killing: "
    if stopandwait "$1" -k; then
      return
    fi
  fi
  fatal "Failed to stop '$1'."
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
