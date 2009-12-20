usage 1 1 service "$@"
shift $(( $OPTIND - 1 ))
if svc-isdown "$1"; then exit 0; fi
sleep 1
count=1
while svc-isup "$1"; do
  echon .
  sleep 1
  count=$(($count+1))
  if [ $count -gt ${SVCTIMEOUT-15} ]; then exit 1; fi
done
