usage_nocd 2 3 '' "directory run-file [log-run-file]" "$@"
shift $(( $OPTIND - 1 ))

dir="$1"
run="$2"
log="$3"

if ! echo X"$dir" | egrep '^/' >/dev/null 2>&1; then
  dir="$SVCLOCKDIR/$dir"
fi

mkdir -p "$dir"
install -m 755 "$run" "$dir"/run
if [ "X$log" != X ]; then
  mkdir -p "$dir"/log
  install -m 755 "$log" "$dir"/log/run
  chmod +t "$dir"
fi
