# Debugging

This config uses `nvim-dap` as the debugger client, `nvim-dap-ui` for panels, `nvim-dap-virtual-text` for inline values, and language adapters for Go, Python, and PHP.

## Debugger architecture

```text
┌────────────┐     ┌──────────┐     ┌──────────────────┐     ┌──────────────┐
│  Neovim    │ --> │ nvim-dap │ --> │ Debug adapter    │ --> │ Your runtime │
│ keymaps/UI │ <-- │ protocol │ <-- │ dlv/debugpy/php  │ <-- │ app/tests    │
└────────────┘     └──────────┘     └──────────────────┘     └──────────────┘
```

The adapter is the bridge between Neovim and the real debugger:

- Go uses Delve through `nvim-dap-go`.
- Python uses `debugpy` through `nvim-dap-python`.
- PHP uses `php-debug-adapter`, which listens for Xdebug.

## ASCII layout

When a debug session starts, DAP UI opens automatically:

```text
┌───────────────────────────────┬────────────────────────────────────────────┐
│ scopes                        │ code                                       │
│ variables                     │                                            │
│                               │  12  local user = get_user(id)             │
│ breakpoints                   │  13  process(user)                         │
│ stacks                        │ >14  return user.name                      │
│ watches                       │                                            │
├───────────────────────────────┴────────────────────────────────────────────┤
│ REPL                                      console                          │
│ evaluate expressions                    adapter/runtime output             │
└────────────────────────────────────────────────────────────────────────────┘
```

In tmux, keep logs or test commands in a side pane:

```text
┌──────────────────────────────────────┬─────────────────────────────┐
│ Neovim + DAP UI                      │ shell                       │
│ breakpoints, variables, stack, code  │ go test / pytest / php logs │
└──────────────────────────────────────┴─────────────────────────────┘
```

Move between Neovim and tmux panes with `<C-h>`, `<C-j>`, `<C-k>`, and `<C-l>`.

## Keybindings

| Key | Action |
| --- | --- |
| `<leader>db` | Toggle breakpoint on the current line. |
| `<leader>dc` | Start or continue debugging. |
| `<leader>dC` | Run to cursor. |
| `<leader>du` | Toggle DAP UI. |
| `<leader>dr` | Toggle DAP REPL. |
| `<leader>dq` | Terminate session and close DAP UI. |
| `<F7>` | Step into. |
| `<F8>` | Step over. |
| `<F9>` | Step out. |

## Common workflow

1. Open the file you want to debug.
2. Put the cursor on a line that should pause.
3. Press `<leader>db` to set a breakpoint.
4. Press `<leader>dc` to start or attach.
5. Step with `<F7>`, `<F8>`, and `<F9>`.
6. Inspect variables in DAP UI scopes or the REPL.
7. Stop with `<leader>dq`.

## Install adapters

The config asks Mason to install:

```vim
:MasonInstall delve debugpy php-debug-adapter
```

Manual health check:

```vim
:Mason
:checkhealth
```

Shell checks:

```bash
dlv version
python -m debugpy --version
php-debug-adapter --help
```

## Go debugging

Go debugging uses Delve.

Install:

```vim
:MasonInstall delve
```

Debug a Go test under the cursor:

```vim
:lua require("dap-go").debug_test()
```

Debug the current package or binary:

1. Set a breakpoint with `<leader>db`.
2. Press `<leader>dc`.
3. Pick the Go launch configuration.

Example:

```go
package main

import "fmt"

func add(a int, b int) int {
	return a + b
}

func main() {
	value := add(2, 3) // set breakpoint here
	fmt.Println(value)
}
```

Workflow:

```text
breakpoint on add call -> <leader>dc -> <F7> into add -> inspect a/b -> <F8> over return
```

Tmux use case:

```bash
tmux new -s go-debug
nvim main.go
```

Open another pane with `<prefix> %` and run:

```bash
go test ./...
```

## Python debugging

Python debugging uses `debugpy`.

Install:

```vim
:MasonInstall debugpy
```

Debug current file:

1. Open a Python file.
2. Set a breakpoint with `<leader>db`.
3. Press `<leader>dc`.
4. Choose the Python launch option.

Example:

```python
def total(items):
    result = 0
    for item in items:
        result += item  # set breakpoint here
    return result

print(total([1, 2, 3]))
```

Virtualenv notes:

- `nvim-dap-python` launches the adapter with Mason `debugpy`.
- Your project imports still come from the active project interpreter when `debugpy` detects it.
- Open Neovim from an activated virtualenv when a project needs that environment:

```bash
source .venv/bin/activate
nvim app.py
```

Pytest workflow:

```text
pane 1: nvim tests/test_app.py
pane 2: pytest -q
debug: breakpoint in test or code -> <leader>dc
```

## PHP debugging

PHP debugging uses Xdebug and `php-debug-adapter`.

Install adapter:

```vim
:MasonInstall php-debug-adapter
```

Xdebug must be installed in PHP itself. Check:

```bash
php -v
php -m | grep -i xdebug
```

Typical Xdebug 3 settings:

```ini
xdebug.mode=debug
xdebug.start_with_request=yes
xdebug.client_host=127.0.0.1
xdebug.client_port=9003
```

### PHP web request

1. Start your PHP app server.
2. Open Neovim in the project.
3. Set a breakpoint with `<leader>db`.
4. Press `<leader>dc`.
5. Choose `Listen for Xdebug`.
6. Load the page or hit the endpoint.

ASCII flow:

```text
browser/curl -> PHP app + Xdebug -> localhost:9003 -> php-debug-adapter -> nvim-dap
```

### PHP CLI script

Run the script with Xdebug enabled in a tmux pane:

```bash
XDEBUG_MODE=debug XDEBUG_CONFIG="client_host=127.0.0.1 client_port=9003" php script.php
```

In Neovim:

```text
set breakpoint -> <leader>dc -> Listen for Xdebug -> run CLI script in tmux pane
```

### Docker path mapping

Use `Listen for Xdebug (Docker)` when the container path is `/var/www/html` and the local project is your current workspace. If your container uses a different path, update `pathMappings` in `lua/plugins/debugging.lua`.

## Troubleshooting

No breakpoint hit:

1. Confirm the adapter is installed in Mason.
2. Confirm the language runtime has debug support installed.
3. Confirm the breakpoint line is executable.
4. For PHP, confirm Xdebug connects to port `9003`.
5. For tmux, keep server/log output visible in a side pane.

Useful commands:

```vim
:lua require("dap").set_log_level("TRACE")
:lua print(vim.fn.stdpath("data"))
:Mason
```

DAP log location:

```vim
:lua print(vim.fn.stdpath("cache") .. "/dap.log")
```
