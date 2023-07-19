#!/usr/bin/env sh
set -e

[ "$#" -ne 1 ] && echo "Usage: $0 <file>" && return 1
[ ! -f "$1" ] && echo "error: '$1' is not a file" && return 1

file="$1"

zig_ver="zig $(zig version)"
iso_gmt_date="$(date -u +'%Y-%m-%dT%H:%M:%SZ')"

note="// Last tested with $zig_ver on $iso_gmt_date"

echo "$note"

tmpfile="$(mktemp)"

sed "1s#.*#$note#" "$file" > "$tmpfile"

[ "$(wc -l < "$file")" -eq "$(wc -l < "$tmpfile")" ] && mv "$tmpfile" "$file"
