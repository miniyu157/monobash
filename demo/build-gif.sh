#!/usr/bin/env bash
set -e

cd /workdir

./demo.sh --list | while IFS= read -r line; do
    rm -rf "./$line"
done

vhs << 'EOF'
Output demo.gif
Set FontSize 22
Set FontFamily "IosevkaTermSlab NF Obl"
Set Width 1000
Set Height 600
Set Padding 10
Set TypingSpeed 50ms

Set TypingSpeed 30ms
Type "rg '__greet' -A 1 -B 10 demo.sh | bat -pP --language=bash"
Set TypingSpeed 50ms
Sleep 0.5s
Enter
Sleep 3s

Type "./demo.sh greet --help"
Sleep 0.5s
Enter
Sleep 3s

Type "./demo.sh greet DreamFlower"
Sleep 0.5s
Enter
Sleep 1.5s

Type "./demo.sh --help"
Sleep 0.5s
Enter
Sleep 1.5s

Type "./demo.sh --list"
Sleep 0.5s
Enter
Sleep 1.5s

Type "./demo.sh -L"
Sleep 0.5s
Enter
Sleep 0.5s

Set TypingSpeed 30ms
Type "fd -t l -x ls -l {}"
Set TypingSpeed 50ms
Sleep 0.5s
Enter

Type "./greet '<Welcome to MonoBash!>'"
Sleep 0.5s
Enter
Sleep 2.5s
EOF

./demo.sh --list | while IFS= read -r line; do
    rm -rf "./$line"
done
