#!/usr/bin/env bash
set -e

ROOT="$(cd "$(dirname "$0")/.." && pwd)"

core="$ROOT/monobash"
patch="$ROOT/demo/demo.patch.sh"
out="$ROOT/demo/demo.sh"

last_line="$(tail -n 1 "$core")"
{
    head -n -1 "$core"
    printf '\n'
    cat "$patch"
    printf '\n'
    printf '%s\n' "$last_line"
} > "$out"
chmod +x "$out"
