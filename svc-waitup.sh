usage $# 1 1 service
if svc-isup "$1"; then exit 0; fi
sleep 1
count=1
until svc-isup "$1"; do
  echon .
  sleep 1
  count=$(($count+1))
  if [ $count -gt ${SVCTIMEOUT-15} ]; then exit 1; fi
done
