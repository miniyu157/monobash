# MonoBash

A minimalist, single-file Bash framework featuring self-documenting magic and BusyBox-style multicall architecture.

![GitHub last commit](https://img.shields.io/github/last-commit/miniyu157/monobash?logo=git)
![ShellCheck](https://img.shields.io/badge/shellcheck-pass-brightgreen?logo=gnu-bash&logoColor=white)
![License](https://img.shields.io/badge/license-MIT-blue.svg)

## Features

🧩 zero-dependency  📄 single-file  📦 multicall  
🎨 ANSI-DSL  🪄 self-documenting  ⚡  auto-dispatch  🪶 <150 LOC

Witness the monobash magic in motion.

![demo](./demo/demo.gif)

## Quick Start

### For Beginners (Demo)

Witness the framework assemble itself. Download the self-bootstrapping script that dynamically fetches the latest core and fuses it with demo features at runtime.

```bash
curl -O https://raw.githubusercontent.com/miniyu157/monobash/main/demo/demo.sh
chmod +x demo.sh
./demo.sh        # 1st run: Bootstraps and assembles the demo
./demo.sh --help # 2nd run: Explore available commands
```

### For Developers (Production)

Start your new project with the clean core framework:

```bash
curl -o my-tool https://raw.githubusercontent.com/miniyu157/monobash/main/monobash
chmod +x my-tool
# Edit 'my-tool' to add your own functions!
```

## Usage

```console
> ./monobash --help
Usage:
  monobash COMMAND [options...]
  COMMAND [options...]

Options:
  -h, --help         Show help information for the specified command

When using monobash directly as COMMAND:
  Usage: monobash <options> [arguments...]
  Options:
    -h, --help         Show this help message
    -l, --list         List all available commands
    -L, --link [DIR]   Create symlinks in DIR
               (default: directory of monobash)
```

## Development

### 1. Define commands

Functions prefixed with `__` become subcommands.

> For internal calls, directly invoke `__<command> "$@"`.
> Only use `run_cmd <command> "$@"` when you explicitly need to update the global `CMD` context.

### 2. Write Documentation

Add a `# $$$` comment block. It is parsed at runtime to generate help text.

**Variable Expansion**: Inside the doc block, the following variables are expanded at runtime:

* `${CMD}`: Current subcommand name.
* `${SELF}`: Script filename.
* `${SELF_PATH}`: Absolute path to the script.
* `${SELF_DIR}`: Directory containing the script.
* `${VAR}`: Any variable defined in # @ui tags.

### 3. Configure UI

Define global ANSI styles using `# @ui` tags at the top of the script.

The `\e[` escape sequence is automatically prepended.

Use `# @off` to stop scanning early and avoid unnecessary overhead.

monobash provides the following preset styles:

```bash
# @ui COFF=0m BOLD=1m FAINT=2m ITALIC=3m 
# @ui ULINE=4m INVERT=7m HIDE=8m DLINE=9m
```

Of course, you can add more styles, for example:

```bash
# @ui RED=31m     GREEN=32m     YELLOW=33m     BLUE=34m     MAGENTA=35m     CYAN=36m     WHITE=37m
# @ui bgRED=41m   bgGREEN=42m   bgYELLOW=43m   bgBLUE=44m   bgMAGENTA=45m   bgCYAN=46m   bgWHITE=47m
# @ui LRED=91m    LGREEN=92m    LYELLOW=93m    LBLUE=94m    LMAGENTA=95m    LCYAN=96m    LWHITE=37m
# @ui bgLRED=101m bgLGREEN=102m bgLYELLOW=103m bgLBLUE=104m bgLMAGENTA=105m bgLCYAN=106m bgLWHITE=107m
# @ui FOFF=39m BOFF=49m
# @ui SAKURA=1;4;38;2;255;176;191;48;2;96;48;72m
```

**Example:**

```bash
#!/usr/bin/env bash
# @ui ERROR=31;1m SUCCESS=32;1m foo=bar
# @ui RESET=0m
# @off

# ... (The Core of monobash) ...

# $$$
# Deploy the application to production.
#
# Usage:
#   ${CMD} [options]
#
# Options:
#   -f, --force      Force deployment
#
# returns: ${SUCCESS}0${COFF} on success, ${ERROR}1${COFF} on error.
# $$$
__deploy() {
    echo "Deploying..."
}
```

### 4. Additional Variables

You can access these globals anywhere in your functions:

* `IS_APPLET`: 1 if run via symlink 0 otherwise.
* `UI_VARS`: An associative array containing all parsed @ui styles (e.g., `${UI_VARS[FOO]}` `${!UI_VARS[*]}`).
* `CMD`: The name of the currently executing subcommand.

## License

[MIT LICENSE](./LICENSE)
