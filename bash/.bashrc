# =============================================================================
# .bashrc — Bash configuration
# =============================================================================

# --- Prompt (Starship) ----------------------------------------------------
eval "$(starship init bash)"

# --- Zoxide (smart cd) ----------------------------------------------------
eval "$(/usr/bin/zoxide init bash)"

# --- LS_COLORS (WSL /mnt/c/ fix) -----------------------------------------
LS_COLORS="$LS_COLORS:ow=01;34:tw=30;44"

# --- Editor ---------------------------------------------------------------
if command -v nvim &>/dev/null; then
  export EDITOR="nvim"
  export VISUAL="nvim"
fi

# --- PATH -----------------------------------------------------------------
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
  PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# =============================================================================
# Aliases & functions
# =============================================================================

# --- File system ----------------------------------------------------------
if command -v eza &>/dev/null; then
  alias ls='eza -lh --group-directories-first --icons=auto'
  alias la='eza -a --group-directories-first --icons=auto'
  alias lsa='ls -a'
  alias lt='eza --tree --level=2 --long --icons --git'
  alias lta='lt -a'
fi

# --- Directory shortcuts --------------------------------------------------
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# --- Git ------------------------------------------------------------------
alias g='git'
alias gcm='git commit -m'
alias gcam='git commit -a -m'
alias gcad='git commit -a --amend'

# --- Tools ----------------------------------------------------------------
alias c='opencode'
alias t='tmux attach || tmux new -s Work'
alias y='yazi'
n() { if [ "$#" -eq 0 ]; then command nvim .; else command nvim "$@"; fi; }

# --- cd override with zoxide ----------------------------------------------
if command -v zoxide &>/dev/null; then
  alias cd="zd"
  zd() {
    if (($# == 0)); then
      builtin cd ~ || return
    elif [[ -d $1 ]]; then
      builtin cd "$1" || return
    else
      if ! z "$@"; then
        echo "Error: Directory not found"
        return 1
      fi
      printf "\U000F17A9 "
      pwd
    fi
  }
fi

# --- FZF preview ----------------------------------------------------------
if [[ "$TERM" == "xterm-kitty" ]]; then
  alias ff="fzf --preview 'case \$(file --mime-type -b {}) in image/*) kitty icat --clear --transfer-mode=memory --stdin=no --place=\${FZF_PREVIEW_COLUMNS}x\${FZF_PREVIEW_LINES}@0x0 {} ;; *) bat --style=numbers --color=always {} ;; esac'"
else
  alias ff="fzf --preview 'bat --style=numbers --color=always {}'"
fi
alias eff='$EDITOR "$(ff)"'

# =============================================================================
# Bash-specific
# =============================================================================

# --- Global definitions ---------------------------------------------------
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

# --- User rc fragments ----------------------------------------------------
if [ -d ~/.bashrc.d ]; then
  for rc in ~/.bashrc.d/*; do
    if [ -f "$rc" ]; then
      . "$rc"
    fi
  done
fi
unset rc
