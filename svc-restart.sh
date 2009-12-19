if [ "$1" = -q ]; then
  exec >/dev/null
  shift
fi

usage 1 9999 "[-q] service [service ...]" "$@"

for svc in "$@"; do

  svc-stop "$svc"

  svc-start "$svc"

done
