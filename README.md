# MonoBash

A minimalist, single-file Bash framework featuring self-documenting magic and BusyBox-style multicall architecture.

![GitHub last commit](https://img.shields.io/github/last-commit/miniyu157/monobash?logo=git)
![ShellCheck](https://img.shields.io/badge/shellcheck-pass-brightgreen?logo=gnu-bash&logoColor=white)
![License](https://img.shields.io/badge/license-MIT-blue.svg)

Witness the monobash magic in motion.

![demo](./demo/demo.gif)

## ✨ Features

* **Zero Dependency**: Runs anywhere with just Bash.
* **Multicall Binary**: Acts like BusyBox. One script, multiple commands via symlinks.
* **Self-Documenting**: Parses subcommand documentation directly from comments via an Awk magic state machine.
* **Declarative UI**: Define ANSI colors and styles via simple header tags.
* **Auto-Dispatch**: Just write a  **__func**, and it automatically dispatches subcommands.
* **Ultra Lightweight**: The core framework is under **200** lines of code.

## ⚡ Quick Start

### 🐣 For Beginners (Demo)

Witness the framework assemble itself. Download the self-bootstrapping script that dynamically fetches the latest core and fuses it with demo features at runtime.

```bash
curl -O https://raw.githubusercontent.com/miniyu157/monobash/main/demo/demo.sh
chmod +x demo.sh
./demo.sh        # 1st run: Bootstraps and assembles the demo
./demo.sh --help # 2nd run: Explore available commands
```

### 🛠️ For Developers (Production)

Start your new project with the clean core framework:

```bash
curl -o my-tool https://raw.githubusercontent.com/miniyu157/monobash/main/monobash
chmod +x my-tool
# Edit 'my-tool' to add your own functions!
```

## 📖 Usage

```console
> ./monobash --help
Description of the application monobash.

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

Available commands:
    build deploy test (Example commands)
```

## 💻 Development

### 1. Define Commands

Create a function with a `__` prefix. It automatically becomes a subcommand.

### 2. Write Documentation

Add a `# $$$` comment block. It is parsed at runtime to generate help text.

### 3. Configure UI

Define global ANSI styles using `# @ui` tags at the top of the script.

The `\e[` escape sequence is automatically prepended.

Use `# @off` to stop scanning early and avoid unnecessary overhead.

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

**Variable Expansion**: Inside the doc block, the following variables are expanded at runtime:

* `${CMD}`: Current subcommand name.
* `${SELF}`: Script filename.
* `${SELF_PATH}`: Absolute path to the script.
* `${SELF_DIR}`: Directory containing the script.
* `${VAR}`: Any variable defined in # @ui tags.

**Additional Variables**: You can access these globals anywhere in your functions:

* `IS_APPLET`: 1 if run via symlink 0 otherwise.
* `UI_VARS`: An associative array containing all parsed @ui styles (e.g., ${UI_VARS[FOO]} ${!UI_VARS[*]}).

## ⚖️ License

[MIT LICENSE](./LICENSE)
