#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

fail() {
  printf 'FAIL: %s\n' "$*" >&2
  exit 1
}

assert_file() {
  [[ -f "$repo_root/$1" ]] || fail "missing file: $1"
}

assert_contains() {
  local file="$1"
  local text="$2"
  grep -Fq -- "$text" "$repo_root/$file" || fail "$file missing text: $text"
}

assert_executable_or_readable_script() {
  local file="$1"
  assert_file "$file"
  bash -n "$repo_root/$file"
}

assert_file "scripts/lib.sh"
assert_executable_or_readable_script "scripts/install-macos.sh"
assert_executable_or_readable_script "scripts/install-linux.sh"
assert_executable_or_readable_script "scripts/install-tmux-macos.sh"
assert_executable_or_readable_script "scripts/install-tmux-linux.sh"
assert_executable_or_readable_script "scripts/install-all-macos.sh"
assert_executable_or_readable_script "scripts/install-all-linux.sh"

mac_output="$(bash "$repo_root/scripts/install-macos.sh" --dry-run)"
linux_output="$(bash "$repo_root/scripts/install-linux.sh" --dry-run)"
tmux_mac_output="$(bash "$repo_root/scripts/install-tmux-macos.sh" --dry-run)"
tmux_linux_output="$(bash "$repo_root/scripts/install-tmux-linux.sh" --dry-run)"
all_mac_output="$(bash "$repo_root/scripts/install-all-macos.sh" --dry-run)"
all_linux_output="$(bash "$repo_root/scripts/install-all-linux.sh" --dry-run)"

grep -Fq "DRY RUN" <<<"$mac_output" || fail "mac dry-run did not announce dry-run mode"
grep -Fq "brew install" <<<"$mac_output" || fail "mac dry-run missing brew install"
grep -Fq "Lazy! sync" <<<"$mac_output" || fail "mac dry-run missing Lazy sync"

grep -Fq "DRY RUN" <<<"$linux_output" || fail "linux dry-run did not announce dry-run mode"
grep -Eq "(apt-get|dnf|pacman)" <<<"$linux_output" || fail "linux dry-run missing package manager install"
grep -Fq "Lazy! sync" <<<"$linux_output" || fail "linux dry-run missing Lazy sync"

grep -Fq "tmux" <<<"$tmux_mac_output" || fail "tmux mac dry-run missing tmux install"
grep -Fq ".tmux.conf" <<<"$tmux_mac_output" || fail "tmux mac dry-run missing tmux.conf setup"
grep -Fq "install_plugins" <<<"$tmux_mac_output" || fail "tmux mac dry-run missing TPM plugin install"
! grep -Fq "Lazy! sync" <<<"$tmux_mac_output" || fail "tmux-only mac dry-run should not sync Neovim"

grep -Fq "tmux" <<<"$tmux_linux_output" || fail "tmux linux dry-run missing tmux install"
grep -Fq ".tmux.conf" <<<"$tmux_linux_output" || fail "tmux linux dry-run missing tmux.conf setup"
grep -Fq "install_plugins" <<<"$tmux_linux_output" || fail "tmux linux dry-run missing TPM plugin install"
! grep -Fq "Lazy! sync" <<<"$tmux_linux_output" || fail "tmux-only linux dry-run should not sync Neovim"

grep -Fq "Lazy! sync" <<<"$all_mac_output" || fail "all mac dry-run missing Neovim sync"
grep -Fq "install_plugins" <<<"$all_mac_output" || fail "all mac dry-run missing TPM plugin install"
grep -Fq "Lazy! sync" <<<"$all_linux_output" || fail "all linux dry-run missing Neovim sync"
grep -Fq "install_plugins" <<<"$all_linux_output" || fail "all linux dry-run missing TPM plugin install"

assert_file "docs/installation.md"
assert_file "docs/plugins.md"
assert_file "docs/keybindings.md"
assert_file "docs/vim-cheatsheet.md"
assert_file "docs/troubleshooting.md"
assert_file "docs/tmux.md"

assert_contains "README.md" "Quick Install"
assert_contains "README.md" "Documentation"
assert_contains "docs/installation.md" "Backup behavior"
assert_contains "docs/plugins.md" "none-ls.nvim"
assert_contains "docs/plugins.md" "nvim-treesitter"
assert_contains "docs/keybindings.md" "<C-n>"
assert_contains "docs/keybindings.md" "<leader>gf"
assert_contains "docs/keybindings.md" "<leader>tn"
assert_contains "docs/keybindings.md" "<prefix> r"
assert_contains "docs/keybindings.md" "<C-h>"
assert_contains "docs/vim-cheatsheet.md" "Movement"
assert_contains "docs/tmux.md" "TPM"
assert_contains "docs/tmux.md" "vim-tmux-navigator"
assert_contains "docs/plugins.md" "catppuccin/tmux"
assert_contains "docs/troubleshooting.md" "Lazy"
assert_contains "docs/troubleshooting.md" "TPM"

tpm_run_count="$(grep -c "run '~/.tmux/plugins/tpm/tpm'" "$repo_root/tmux.conf")"
[[ "$tpm_run_count" == "1" ]] || fail "tmux.conf should initialize TPM exactly once"

assert_contains "lua/plugins/tmux-navigator.lua" "<C-h>"
assert_contains "lua/plugins/tmux-navigator.lua" "<C-j>"
assert_contains "lua/plugins/tmux-navigator.lua" "<C-k>"
assert_contains "lua/plugins/tmux-navigator.lua" "<C-l>"

printf 'install/docs checks passed\n'
