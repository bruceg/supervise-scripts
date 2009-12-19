if [ "$1" = -q ]; then
  exec >/dev/null
  shift
fi

usage 1 9999 "[-q] service [service ...]" "$@"

start() {
  # Check the "run" file
  if [ ! -e "$1/run" ]; then
    fatal "'$1/run' file does not exist!"
  fi

  rm -f "$1/down"

  if ! svok "$1"; then
    echon "(supervise"
    count=1
    until svok "$1"; do
      echon .
      sleep 1
      count=$(($count+1))
      if [ $count -gt ${SVCTIMEOUT-15} ]; then
        echon ") "
	fatal "supervise for '$1' did not start!  Is svscan running?"
      fi
    done
    echon ") "
  fi

  svc -u "$1"
  svc-waitup "$1"

  echon "$1 "
}

for svc in "$@"; do

  if ! [ -e "$svc" ]; then
    fatal "Service '$svc' does not exist."
  fi

  echon "Starting $svc: "

  # Control the log process first, so that all messages are logged ...
  if [ -d "$svc/log" ]; then
    start "$svc/log"
  fi

  # ... and then the main process.
  start "$svc"

  echo "done."

done
