#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
# shellcheck source=scripts/lib.sh
source "$script_dir/lib.sh"

main() {
  parse_common_args "$@"
  local source_root
  source_root="$(repo_root_from_script_dir "$script_dir")"

  log "Installing Neovim and tmux config for Linux"
  install_linux_packages_all
  install_neovim_from_source "$source_root"
  install_tmux_from_source "$source_root"
  print_next_steps
}

main "$@"
