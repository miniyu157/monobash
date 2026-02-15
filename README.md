# MonoBash

A minimalist, single-file Bash framework featuring self-documenting magic and BusyBox-style multicall architecture.

![Shell](https://img.shields.io/badge/Shell-Bash%204.3-4EAA25?style=for-the-badge&logo=gnubash)
![ShellCheck](https://img.shields.io/badge/🟢%20ShellCheck-pass-2ecc71?style=for-the-badge)
![LOC](https://img.shields.io/badge/🐰%20LOC-<150-2ecc71?style=for-the-badge)  
![GitHub last commit](https://img.shields.io/github/last-commit/miniyu157/monobash?style=for-the-badge&logo=git&logoColor=white)
![GitHub repo size](https://img.shields.io/github/repo-size/miniyu157/monobash?style=for-the-badge&color=8e44ad&label=📄%20repo%20size)
![GitHub stars](https://img.shields.io/github/stars/miniyu157/monobash?style=for-the-badge&color=f1c40f&label=✨%20stars)  
[![License](https://img.shields.io/badge/License-MIT-3498db?style=for-the-badge&logo=open-source-initiative&logoColor=white)](./LICENSE)

## Features

🧩 zero-dependency  📄 single-file  📦 multicall  
🎨 ANSI-DSL  🪄 self-documenting  ⚡  auto-dispatch

***🌟 Witness the monobash magic in motion. 🌟***

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

## Multicall Architecture (Applets)

monobash natively supports BusyBox-style symlink execution. When invoked via a symlink, the framework automatically dispatches to the corresponding internal command.

```bash
# Create a symlink to monobash
ln -s ./my-tool server

# This is equivalent to running `./my-tool server`
./server --port 8080
```

## Usage

```console
> ./monobash --help
Usage:
  monobash COMMAND [options...]
  COMMAND [options...]

Commands:
  foo       Do something awesome
  bar       Another cool command

Options:
  -h, --help    Show help message
  -l, --list    List all available commands
```

## Development Guide

### 1. Define Commands

Any function prefixed with `__` automatically becomes an exposed CLI subcommand.

```bash
__build() {
    echo "Building project..."
}
```

> [!NOTE]
> For internal calls, directly invoke `__<command> "$@"`.
> Only use `run_cmd <command> "$@"` when you explicitly need to update the global `CMD` context.

### 2. Self-Documenting Comments

Documentation is extracted directly from the source using internal `awk` magic. Prefix your docstrings with `##` right above your function.

**Variable Expansion**: Variables within the `##` blocks are expanded at runtime.
Available variables:

* `${CMD}`: Current subcommand name.
* `${SELF}`: Script filename.
* `${SELF_PATH}`: Absolute path to the script.
* `${SELF_DIR}`: Directory containing the script.
* Any variable defined via `# @ui` tags.

```bash
## Compile the source code.
##
## Usage:
##   ${CMD} [options]
##
## Options:
##   -v, --verbose    Enable verbose output
__compile() {
    # implementation...
}
```

### 3. UI and Styling (ANSI-DSL)

Define global ANSI styles using `# @ui` tags at the top of the script. The framework prepends the `\e[` escape sequence automatically.

Use `# @off` to terminate the parser early and avoid unnecessary overhead.

monobash includes these core styles:

```bash
# @ui COFF=0m BOLD=1m FAINT=2m ITALIC=3m ULINE=4m INVERT=7m HIDE=8m DLINE=9m
# @off
```

You can easily declare custom color palettes:

```bash
# @ui RED=31m GREEN=32m YELLOW=33m BLUE=34m 
# @ui ERROR=31;1m SUCCESS=32;1m
```

**Applying styles in code and docs:**

```bash
## Deploy to production.
## Returns ${SUCCESS}0${COFF} on success, ${ERROR}1${COFF} on error.
__deploy() {
    echo -e "${BOLD}Deploying...${COFF}"
}
```

### 4. Global Context

The following global variables are available anywhere inside your functions:

* `IS_APPLET`: `1` if executed via symlink, `0` otherwise.
* `CMD`: The name of the currently executing subcommand (without the `__` prefix).
* `UI_VARS`: An associative array containing all parsed `@ui` styles (e.g., `${UI_VARS[BOLD]}`).

## License

[MIT LICENSE](./LICENSE)
