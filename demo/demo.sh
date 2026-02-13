#!/usr/bin/env bash

# demo.sh

set -euo pipefail

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

tmp_file=$(mktemp "$SELF_DIR/_tmp_demo_XXXXXX.sh")
trap '[[ -f "$tmp_file" ]] && rm -f "$tmp_file"' EXIT

patch_ui=$(grep '^# @ui' <<< "$patch" || true)
patch_code=$(grep -v "^# @ui" <<< "$patch" || true)
off_line=$(grep -n "^# @off" <<< "$core" | cut -d: -f1 | head -1)

{
    head -n "$((off_line - 1))" <<< "$core"
    [[ -n $patch_ui ]] && printf '%s\n' "$patch_ui"
    tail -n "+$off_line" <<< "$core" | head -n -1
    printf '\n%s\n' "$patch_code"
    tail -n 1 <<< "$core"
} > "$tmp_file"

printf "\nWelcome to MonoBash!\n"
printf "The demo is ready. Re-run './%s' to see it in action.\n" "$SELF"
printf "You can also open this file in an editor to see how it works.\n"

chmod +x "$tmp_file"
mv "$tmp_file" "$SELF_PATH"
