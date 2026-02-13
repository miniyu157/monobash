APP_DESC="A demonstration for the MonoBash framework."

# @ui RED=31m     GREEN=32m     YELLOW=33m     BLUE=34m     MAGENTA=35m     CYAN=36m     WHITE=37m
# @ui bgRED=41m   bgGREEN=42m   bgYELLOW=43m   bgBLUE=44m   bgMAGENTA=45m   bgCYAN=46m   bgWHITE=47m
# @ui LRED=91m    LGREEN=92m    LYELLOW=93m    LBLUE=94m    LMAGENTA=95m    LCYAN=96m    LWHITE=37m
# @ui bgLRED=101m bgLGREEN=102m bgLYELLOW=103m bgLBLUE=104m bgLMAGENTA=105m bgLCYAN=106m bgLWHITE=107m
# @ui FOFF=39m BOFF=49m

## ${CYAN}Say hello to someone in the ${INVERT}terminal.${COFF}
## A basic example of argument handling and UI variable injection.
##
## ${BOLD}Usage:${COFF}
##   ${SELF} ${CMD} [name]
##
## ${BOLD}Arguments:${COFF}
##   name    The person to greet (default: World)
__greet() {
    local name="${1:-World}"
    printf "Hello, ${BOLD}%s${COFF}! Executing from %s.\n" "$name" "$SELF"
}

## Run a simulated system diagnostic.
## Demonstrates ANSI colors, sleep, and carriage return overwriting.
__check() {
    printf "${BOLD}Starting system diagnostics...${COFF}\n"

    printf "  [${GRAY}....${COFF}] Kernel module"
    sleep 0.3
    printf "\r  [${GREEN} OK ${COFF}] Kernel module\n"

    printf "  [${GRAY}....${COFF}] Socket stream"
    sleep 0.4
    printf "\r  [${GREEN} OK ${COFF}] Socket stream (12ms)\n"

    printf "\n${CYAN}All subroutines executed successfully.${COFF}\n"
}

## Display current runtime environment variables.
## Useful for debugging applet symlinks and paths.
__info() {
    printf "CMD:       %s\n" "$CMD"
    printf "SELF:      %s\n" "$SELF"
    printf "SELF_PATH: %s\n" "$SELF_PATH"
    printf "SELF_DIR:  %s\n" "$SELF_DIR"
    printf "IS_APPLET: %s (%s)\n" "$IS_APPLET" \
        "$([[ $IS_APPLET -eq 1 ]] && echo Symlink || echo Script)"
}
