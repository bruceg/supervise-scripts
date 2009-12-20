usage 1 1 service "$@"
shift $(( $OPTIND - 1 ))

svc="$1"

svc-stop -q "$svc"

if ! [ -L "$svc" ]; then
  fatal "Service '$svc' is not symlinked into /service and can't be removed."
fi

# Remove the symlink without loosing track of where it points to
cd "$svc"
rm ${SVSCANDIR-/service}/"$svc"

# Stop the supervise tasks
if [ -d log ]; then
  svc -dx log
  sleep 1
  rm log/down log/supervise/{control,lock,ok,status}
  rmdir log/supervise
fi
svc -dx .
sleep 1
rm down supervise/{control,lock,ok,status}
rmdir supervise
