#!/usr/bin/env bash

# demo.sh

set -e

URL_BASE="https://raw.githubusercontent.com/miniyu157/monobash/main"

[[ -z ${BASH_SOURCE[0]} ]] && {
    md=$(
        curl -fsSL "$URL_BASE/README.md" |
            grep -n "curl -O $URL_BASE/demo/demo.sh" -C 5
    )
    cat << EOF
Why so lazy? Come on 😅
---- README.md ----
${md}
---- README.md ----
EOF
    exit 1
}

SELF_PATH=$(realpath "${BASH_SOURCE[0]}")
SELF="${SELF_PATH##*/}"
SELF_DIR="${SELF_PATH%/*}" SELF_DIR="${SELF_DIR:-/}"

printf "Fetching monobash from github.com/miniyu157/monobash ...\n"
core=$(curl -fsSL "$URL_BASE/monobash")

printf "Fetching demo/demo.patch from github.com/miniyu157/monobash ...\n"
patch=$(curl -fsSL "$URL_BASE/demo/demo.patch.sh")

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
