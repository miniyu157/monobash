#!/usr/bin/env bash
set -e

SELF_PATH=$(realpath "${BASH_SOURCE[0]}")
SELF="${SELF_PATH##*/}"
SELF_DIR="${SELF_PATH%/*}" SELF_DIR="${SELF_DIR:-/}"

printf "Fetching monobash from github.com/miniyu157/monobash ...\n"
core=$(curl -fsSL "https://raw.githubusercontent.com/miniyu157/monobash/main/monobash")

printf "Fetching demo/demo.patch from github.com/miniyu157/monobash ...\n"
patch=$(curl -fsSL "https://raw.githubusercontent.com/miniyu157/monobash/main/demo/demo.patch.sh")

last_line=$(tail -n 1 <<< "$core")
tmp_file="$SELF_DIR/_tmp_demo_$RANDOM.sh"
{
    head -n -1 <<< "$core"
    printf "\n"
    printf "%s\n" "$patch"
    printf "\n"
    printf '%s\n' "$last_line"
} > "$tmp_file"

printf "\n"
printf "Welcome to MonoBash!\n"
printf "The demo is ready. Re-run './%s' to see it in action.\n" "$SELF"
printf "You can also open this file in an editor to see how it works.\n"

chmod +x "$tmp_file"
mv "$tmp_file" "$SELF_PATH"
