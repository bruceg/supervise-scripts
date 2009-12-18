set -e

filename="${1-/etc/inittab}"

# Look for the svscan lines, and exit if they both exist

SV_pattern='^SV:.*svscan-start'
SX_pattern='^SX:.*svscan-stopall'
if egrep "$SV_pattern" "$filename" >/dev/null 2>&1 &&
   egrep "$SX_pattern" "$filename" >/dev/null 2>&1
then
  echo "$0: Nothing to do:"
  echo "  '$filename' appears to already have the svscan lines in it."
  exit 0
fi

# Set up variables for a backup copy of the inittab, and a temporary
# output file.

date=`date +%Y-%m-%d`
backup="$filename-$date"
if [ -e "$backup" ]; then
  echo "$0: Backup file '$backup' already exists."
  exit 1;
fi

tmpfile="${filename}.tmp.$$"
if [ -e "$tmpfile" ]
then
  echo "$0: Temporary file '$tmpfile' already exists."
  exit 1
fi

catit() { cat "$filename" | egrep -v "$SV_pattern" | egrep -v "$SX_pattern"; }

# Insert the two svscan lines between the first rc line and the rest of
# the inittab so that svscan gets executed before the rc# scripts do.

# First, find the target pattern
lineno=`catit | egrep -n '^[^:]*:0:wait:.*rc' | cut -d: -f1 | head -1`
if [ -z "$lineno" ]
then
  echo "$0: Couldn't find the search line in '$filename'."
  exit 1;
fi

# Pre-create the temporary file
if ! touch "$tmpfile" >/dev/null 2>&1
then
  echo "$0: Could not create the temporary output file '$tmpfile'"
  exit 1
fi

# Splice the new lines into the old file
{
  catit | head -$(($lineno-1))
  echo "SV:2345:respawn:$conf_bin/svscan-start /service"
  echo "SX:S016:wait:$conf_bin/svscan-stopall /service"
  catit | tail +$lineno
} >"$tmpfile"

# And move it over the existing file
ln "$filename" "$backup"
mv -f "$tmpfile" "$filename"
