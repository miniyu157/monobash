# $$$
# ${BOLD}Description:${COFF}
#   Says hello to someone. A basic example of argument handling.
#
# ${BOLD}Usage:${COFF}
#   ${SELF} ${CMD} [name]
#
# ${BOLD}Arguments:${COFF}
#   name    The person to greet (default: World)
# $$$
__greet() {
    local name="${1:-World}"
    printf "Hello, ${BOLD}%s${COFF}! This a %s.\n" "$name" "$SELF"
}

# $$$
# ${BOLD}Description:${COFF}
#   Simulates a system check with beautiful output.
#   Demonstrates the UI colors and formatting variables.
# $$$
__check() {
    printf "${BOLD}Starting system check...${COFF}\n"

    printf "  [${GRAY}....${COFF}] Database connection"
    sleep 0.5
    printf "\r  [${BOLD} OK ${COFF}] Database connection\n"

    printf "  [${GRAY}....${COFF}] API latency"
    sleep 0.5
    printf "\r  [${BOLD} OK ${COFF}] API latency (24ms)\n"

    printf "\n${BOLD}All systems go!${COFF}\n"
}

# $$$
# ${BOLD}Description:${COFF}
#   Prints the current user and script execution path.
# $$$
__info() {
    printf "CMD: %s\n" "$CMD"
    printf "SELF: %s\n" "$SELF"
    printf "SELF_PATH: %s\n" "$SELF_PATH"
    printf "SELF_DIR: %s\n" "$SELF_DIR"
    printf "IS_APPLET: %s (%s)\n" "$IS_APPLET" \
        "$([[ $IS_APPLET -eq 1 ]] && echo Symlink || echo Script)"
}
