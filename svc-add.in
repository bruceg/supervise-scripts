if [ "$1" = -d ]; then
  down=true
  shift
else
  down=false
fi

usage $# 1 2 "[-d] svc-directory [svc-name]"

svcdir="$1"
if ! echo "$svcdir" | egrep '^/' >/dev/null 2>&1; then
  svcdir="${SVCLOCKDIR-/var/service}/$svcdir"
fi

if [ "X$2" = X ]; then
  svcname="`basename "$svcdir"`"
else
  svcname="$2"
fi

if [ -e "$svcname" ]; then
  fatal "Service '$svcname' is already set up."
fi

if ! [ -d "$svcdir" ]; then
  fatal "'$svcdir' is not a directory."
fi

if $down; then
  touch "$svcdir"/down
fi

if [ -d "$svcdir"/log ]; then
  chmod +t "$svcdir"
  if $down; then
    touch "$svcdir"/log/down
  fi
else
  chmod -t "$svcdir"
fi

ln -s "$svcdir" "$svcname"

if "$down"; then
  echo "Type 'svc-start $svcname' to start the service."
fi
