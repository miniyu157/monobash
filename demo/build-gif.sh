#!/usr/bin/env bash
set -e

export all_proxy=http://127.0.0.1:7890
export PATH=/workdir:$PATH

SELF_PATH=$(realpath "${BASH_SOURCE[0]}")
SELF_DIR="${SELF_PATH%/*}" SELF_DIR="${SELF_DIR:-/}"

cp "$SELF_DIR/demo.sh" "/workdir"

cd /workdir
./demo.sh

./demo.sh --list | while IFS= read -r line; do
    rm -rf "./$line"
done

vhs << 'EOF'
Output demo.gif
Set FontSize 24
Set FontFamily "IosevkaTermSlab NF Obl"
Set Width 1000
Set Height 500
Set Padding 10
Set TypingSpeed 50ms

Hide
Type 'export PS1="\n\[\e[1;34m\]➜ \[\e[32m\]"'
Enter
Type 'export PS0="\e[0m"'
Enter
Ctrl+L
Show


Set TypingSpeed 30ms
Type "head -n 7 demo.sh | bat -pP --language=bash"
Set TypingSpeed 50ms
Sleep 0.5s
Enter
Sleep 2.5s

Set TypingSpeed 30ms
Type "rg '__greet' -A 1 -B 8 demo.sh | bat -pP --language=bash"
Set TypingSpeed 50ms
Sleep 0.5s
Enter
Sleep 2.5s


Type "demo.sh greet --help"
Sleep 0.5s
Enter
Sleep 3s

Type "demo.sh"
Sleep 0.5s
Enter
Sleep 3s

Type "demo.sh greet DreamFlower"
Sleep 0.5s
Enter
Sleep 1.5s

Type "ln -sf ./demo.sh greet"
Sleep 0.5s
Enter
Sleep 1s

Type "greet 'Welcome to MonoBash'"
Sleep 0.5s
Enter
Sleep 4s

EOF

./demo.sh --list | while IFS= read -r line; do
    rm -rf "./$line"
done

cp "./demo.gif" "$SELF_DIR/demo.gif"
