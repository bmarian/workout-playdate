#!/bin/bash
set -uo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT="$(dirname "$SCRIPT_DIR")"
SOURCE_DIR="$ROOT/source"
OUTPUT="$ROOT/Gymdate.pdx"

build() {
	echo -e "\033[36mBuilding...\033[0m"
	pdc "$SOURCE_DIR" "$OUTPUT"
	if [ $? -eq 0 ]; then
		echo -e "\033[32mBuild OK. Press Ctrl-R in the Simulator to reload.\033[0m"
	else
		echo -e "\033[31mBuild failed.\033[0m"
	fi
}

latest_write_time() {
	find "$SOURCE_DIR" -type f -exec stat -f "%m" {} \; | sort -n | tail -1
}

build
last_seen=$(latest_write_time)

echo "Watching $SOURCE_DIR for changes. Ctrl-C to stop."
while true; do
	sleep 0.5
	current=$(latest_write_time)
	if [ "$current" != "$last_seen" ]; then
		last_seen="$current"
		build
	fi
done
