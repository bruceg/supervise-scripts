usage_nocd $# 2 3 "directory run-file [log-run-file]"

dir="$1"
run="$2"
log="$3"

mkdir -p "$dir"
install -m 755 "$run" "$dir"/run
if [ "X$log" != X ]; then
  mkdir -p "$dir"/log
  install -m 755 "$log" "$dir"/log/run
  chmod +t "$dir"
fi
