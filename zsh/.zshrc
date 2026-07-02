# =============================================================================
# .zshrc — Zsh configuration
# =============================================================================

# --- Prompt (Starship) ----------------------------------------------------
eval "$(starship init zsh)"

# --- Zoxide (smart cd) ----------------------------------------------------
eval "$(/usr/bin/zoxide init zsh)"

# --- Zsh options ----------------------------------------------------------
setopt extendedglob
setopt autopushd
setopt correct
setopt histignoredups
setopt histignorespace
setopt histreduceblanks
setopt incappendhistory
setopt sharehistory
setopt histfcntllock

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

SPROMPT='%F{red}%R%f → %F{green}%r%f? [y/N/a/e] '

# --- Completions ----------------------------------------------------------
autoload -Uz compinit && compinit
source ~/.zsh/plugins/fzf-tab/fzf-tab.plugin.zsh

LS_COLORS="$LS_COLORS:ow=01;34:tw=30;44"
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# --- fzf Smart Previews ---------------------------------------------------
zstyle ':fzf-tab:*' fzf-flags '--height=50%'
zstyle ':fzf-tab:complete:*:*' fzf-preview '
  mime=$(file --mime-type -b ${(Q)realpath})
  if [[ -d ${(Q)realpath} ]]; then
    eza --tree --level=2 --color=always --icons ${(Q)realpath}
  elif [[ $mime == image/* ]]; then
    kitty icat --clear --transfer-mode=memory --stdin=no --place=${FZF_PREVIEW_COLUMNS}x${FZF_PREVIEW_LINES}@0x0 ${(Q)realpath}
  else
    bat --style=numbers --color=always --line-range=:500 ${(Q)realpath}
  fi'

# --- Plugins --------------------------------------------------------------
source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# --- Editor ---------------------------------------------------------------
bindkey -v
bindkey "^[[3~" delete-char
bindkey -a "^[[3~" delete-char
if command -v nvim &>/dev/null; then
  export EDITOR="nvim"
  export VISUAL="nvim"
fi

# --- PATH -----------------------------------------------------------------
path=(~/.local/bin ~/bin $path)

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
