#!/usr/bin/env bash

set -euo pipefail

DEFAULT_REPO_URL="git@github.com:mihaiflorentin88/neovim.git"
NVIM_CONFIG_DIR="${NVIM_CONFIG_DIR:-${XDG_CONFIG_HOME:-$HOME/.config}/nvim}"
NVIM_DATA_DIR="${NVIM_DATA_DIR:-${XDG_DATA_HOME:-$HOME/.local/share}/nvim}"
NVIM_STATE_DIR="${NVIM_STATE_DIR:-${XDG_STATE_HOME:-$HOME/.local/state}/nvim}"
NVIM_CACHE_DIR="${NVIM_CACHE_DIR:-${XDG_CACHE_HOME:-$HOME/.cache}/nvim}"
TMUX_CONFIG_FILE="${TMUX_CONFIG_FILE:-$HOME/.tmux.conf}"
TMUX_PLUGIN_DIR="${TMUX_PLUGIN_DIR:-$HOME/.tmux/plugins}"
TMUX_TPM_DIR="${TMUX_TPM_DIR:-$TMUX_PLUGIN_DIR/tpm}"
BACKUP_STAMP="${BACKUP_STAMP:-$(date +%Y%m%d-%H%M%S)}"
DRY_RUN="${DRY_RUN:-0}"

log() {
  printf '%s\n' "$*"
}

die() {
  printf 'ERROR: %s\n' "$*" >&2
  exit 1
}

usage() {
  cat <<'USAGE'
Usage: install-macos.sh [--dry-run]
       install-linux.sh [--dry-run]
       install-tmux-macos.sh [--dry-run]
       install-tmux-linux.sh [--dry-run]
       install-all-macos.sh [--dry-run]
       install-all-linux.sh [--dry-run]

Options:
  --dry-run   Print actions without changing files or installing packages.
  -h, --help  Show this help.
USAGE
}

parse_common_args() {
  while (($#)); do
    case "$1" in
      --dry-run)
        DRY_RUN=1
        ;;
      -h|--help)
        usage
        exit 0
        ;;
      *)
        die "unknown option: $1"
        ;;
    esac
    shift
  done
  if [[ "$DRY_RUN" == "1" ]]; then
    log "DRY RUN: no changes will be made."
  fi
}

run() {
  if [[ "$DRY_RUN" == "1" ]]; then
    printf '+'
    printf ' %q' "$@"
    printf '\n'
  else
    "$@"
  fi
}

run_shell() {
  if [[ "$DRY_RUN" == "1" ]]; then
    printf '+ %s\n' "$*"
  else
    bash -c "$*"
  fi
}

command_exists() {
  command -v "$1" >/dev/null 2>&1
}

require_command() {
  command_exists "$1" || die "missing required command: $1"
}

repo_root_from_script_dir() {
  local script_dir="$1"
  cd "$script_dir/.." && pwd -P
}

repo_url_for_source() {
  local source_root="$1"
  if [[ -d "$source_root/.git" ]]; then
    git -C "$source_root" config --get remote.origin.url 2>/dev/null || printf '%s\n' "$DEFAULT_REPO_URL"
  else
    printf '%s\n' "$DEFAULT_REPO_URL"
  fi
}

same_existing_path() {
  local left="$1"
  local right="$2"
  [[ -e "$left" && -e "$right" ]] || return 1
  [[ "$(cd "$left" && pwd -P)" == "$(cd "$right" && pwd -P)" ]]
}

backup_path_if_present() {
  local path="$1"
  if [[ -e "$path" || -L "$path" ]]; then
    local backup="${path}.backup-${BACKUP_STAMP}"
    log "Backing up $path -> $backup"
    run mv "$path" "$backup"
  fi
}

backup_neovim_runtime_paths() {
  backup_path_if_present "$NVIM_DATA_DIR"
  backup_path_if_present "$NVIM_STATE_DIR"
  backup_path_if_present "$NVIM_CACHE_DIR"
}

backup_tmux_runtime_paths() {
  if [[ -L "$TMUX_CONFIG_FILE" && "$(readlink "$TMUX_CONFIG_FILE")" == "$NVIM_CONFIG_DIR/tmux.conf" ]]; then
    log "Keeping existing tmux config symlink at $TMUX_CONFIG_FILE"
  else
    backup_path_if_present "$TMUX_CONFIG_FILE"
  fi
  backup_path_if_present "$TMUX_PLUGIN_DIR"
}

install_config_from_source() {
  local source_root="$1"
  local repo_url
  repo_url="$(repo_url_for_source "$source_root")"

  if same_existing_path "$source_root" "$NVIM_CONFIG_DIR"; then
    log "Using current checkout at $NVIM_CONFIG_DIR"
    return
  fi

  backup_path_if_present "$NVIM_CONFIG_DIR"
  run mkdir -p "$(dirname "$NVIM_CONFIG_DIR")"
  log "Cloning $repo_url -> $NVIM_CONFIG_DIR"
  run git clone "$repo_url" "$NVIM_CONFIG_DIR"
}

sync_neovim_plugins() {
  require_command nvim
  log "Syncing Lazy plugins"
  log 'Command: nvim --headless "+Lazy! sync" "+qa"'
  run nvim --headless "+Lazy! sync" "+qa"
  log "Starting Neovim once so Mason can process configured tools"
  run nvim --headless "+qa"
}

smoke_test_neovim() {
  require_command nvim
  log "Running Neovim smoke test"
  run nvim --headless "$NVIM_CONFIG_DIR/README.md" "+qa"
}

install_tmux_config_from_source() {
  local source_root="$1"
  local source_tmux_conf="$source_root/tmux.conf"
  [[ -f "$source_tmux_conf" ]] || die "missing tmux config: $source_tmux_conf"

  run mkdir -p "$(dirname "$TMUX_CONFIG_FILE")"
  log "Linking $source_tmux_conf -> $TMUX_CONFIG_FILE"
  run ln -sfn "$source_tmux_conf" "$TMUX_CONFIG_FILE"
}

install_tpm_and_plugins() {
  require_command git
  require_command tmux

  run mkdir -p "$TMUX_PLUGIN_DIR"
  if [[ ! -d "$TMUX_TPM_DIR" ]]; then
    log "Installing TPM into $TMUX_TPM_DIR"
    run git clone https://github.com/tmux-plugins/tpm "$TMUX_TPM_DIR"
  else
    log "TPM already present at $TMUX_TPM_DIR"
  fi

  log "Installing tmux plugins with TPM"
  run "$TMUX_TPM_DIR/bin/install_plugins"
}

smoke_test_tmux() {
  require_command tmux
  log "Running tmux config smoke test"
  run tmux -f "$TMUX_CONFIG_FILE" start-server ";" source-file "$TMUX_CONFIG_FILE" ";" display-message "tmux config loaded" ";" kill-server
}

install_neovim_from_source() {
  local source_root="$1"
  install_config_from_source "$source_root"
  backup_neovim_runtime_paths
  sync_neovim_plugins
  smoke_test_neovim
}

install_tmux_from_source() {
  local source_root="$1"
  backup_tmux_runtime_paths
  install_tmux_config_from_source "$source_root"
  install_tpm_and_plugins
  smoke_test_tmux
}

install_macos_packages_neovim() {
  if ! command_exists brew; then
    if [[ "$DRY_RUN" == "1" ]]; then
      log "+ brew install neovim git ripgrep"
      return
    fi
    die "Homebrew is required. Install it from https://brew.sh, then rerun this script."
  fi
  run brew install neovim git ripgrep
}

install_macos_packages_tmux() {
  if ! command_exists brew; then
    if [[ "$DRY_RUN" == "1" ]]; then
      log "+ brew install tmux git"
      return
    fi
    die "Homebrew is required. Install it from https://brew.sh, then rerun this script."
  fi
  run brew install tmux git
}

install_macos_packages_all() {
  if ! command_exists brew; then
    if [[ "$DRY_RUN" == "1" ]]; then
      log "+ brew install neovim tmux git ripgrep"
      return
    fi
    die "Homebrew is required. Install it from https://brew.sh, then rerun this script."
  fi
  run brew install neovim tmux git ripgrep
}

install_linux_packages_neovim() {
  install_linux_packages_named neovim git ripgrep
}

install_linux_packages_tmux() {
  install_linux_packages_named tmux git
}

install_linux_packages_all() {
  install_linux_packages_named neovim tmux git ripgrep
}

install_linux_packages_named() {
  if command_exists apt-get; then
    run sudo apt-get update
    run sudo apt-get install -y "$@"
  elif command_exists dnf; then
    run sudo dnf install -y "$@"
  elif command_exists pacman; then
    run sudo pacman -Sy --needed "$@"
  elif [[ "$DRY_RUN" == "1" ]]; then
    log "+ sudo apt-get update"
    log "+ sudo apt-get install -y $*"
  else
    die "unsupported Linux package manager. Install required packages manually, then rerun."
  fi
}

print_next_steps() {
  cat <<EOF

Install flow finished.

Open Neovim:
  nvim

Open tmux:
  tmux

Useful checks:
  nvim --headless "$NVIM_CONFIG_DIR/README.md" "+qa"
  nvim --headless "+checkhealth lazy" "+qa"
  tmux -f "$TMUX_CONFIG_FILE" start-server \\; source-file "$TMUX_CONFIG_FILE" \\; display-message "tmux config loaded" \\; kill-server

Backups use suffix:
  .backup-$BACKUP_STAMP
EOF
}
