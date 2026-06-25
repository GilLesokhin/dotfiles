# =============================================================================
# .zshrc — Zsh configuration
# =============================================================================

# --- Prompt (Starship) ----------------------------------------------------
eval "$(starship init zsh)"

# --- Zoxide (smart cd) ----------------------------------------------------
eval "$(/usr/bin/zoxide init zsh)"

# --- Zsh options ----------------------------------------------------------
setopt extendedglob        # better pattern matching (#, ~, ^)
setopt histignoredups      # skip duplicate history entries
setopt histignorespace     # skip commands starting with space
setopt histreduceblanks    # trim extra whitespace in history
setopt incappendhistory    # write to history immediately, not just on exit
setopt sharehistory        # share history across all terminal sessions
setopt histfcntllock       # use fcntl locking for safer concurrent writes

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt autopushd           # cd pushes old dir onto stack (popd to go back)
setopt correct             # suggest spelling corrections for commands
SPROMPT='%F{red}%R%f → %F{green}%r%f? [y/N/a/e] '

# --- Zsh plugins ----------------------------------------------------------

# zsh-autosuggestions — suggests commands from history
source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# zsh-auto-notify — desktop notifications for long-running commands
source ~/.zsh/plugins/zsh-auto-notify/auto-notify.plugin.zsh

# zsh-you-should-use — reminds you to use existing aliases
source ~/.zsh/plugins/zsh-you-should-use/you-should-use.plugin.zsh

# zsh-syntax-highlighting — colorizes commands as you type
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# zsh-history-substring-search — fish-like history search via up/down
source ~/.zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# --- LS_COLORS (WSL /mnt/c/ fix) -----------------------------------------
LS_COLORS="$LS_COLORS:ow=01;34:tw=30;44"

# --- Completions ----------------------------------------------------------
autoload -Uz compinit && compinit
source ~/.zsh/plugins/fzf-tab/fzf-tab.plugin.zsh

zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# --- File system aliases --------------------------------------------------
if command -v eza &>/dev/null; then
  alias ls='eza -lh --group-directories-first --icons=auto'
  alias la='eza -a --group-directories-first --icons=auto'
  alias lsa='ls -a'
  alias lt='eza --tree --level=2 --long --icons --git'
  alias lta='lt -a'
fi

# --- FZF preview ----------------------------------------------------------
if [[ "$TERM" == "xterm-kitty" ]]; then
  alias ff="fzf --preview 'case \$(file --mime-type -b {}) in image/*) kitty icat --clear --transfer-mode=memory --stdin=no --place=\${FZF_PREVIEW_COLUMNS}x\${FZF_PREVIEW_LINES}@0x0 {} ;; *) bat --style=numbers --color=always {} ;; esac'"
else
  alias ff="fzf --preview 'bat --style=numbers --color=always {}'"
fi
alias eff='$EDITOR "$(ff)"'

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

# --- Directory shortcuts --------------------------------------------------
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# --- Tools ----------------------------------------------------------------
alias c='opencode'
alias t='tmux attach || tmux new -s Work'
alias y='yazi'
n() { if [ "$#" -eq 0 ]; then command nvim .; else command nvim "$@"; fi; }

# --- Git ------------------------------------------------------------------
alias g='git'
alias gcm='git commit -m'
alias gcam='git commit -a -m'
alias gcad='git commit -a --amend'

# --- Editor ---------------------------------------------------------------
if command -v nvim &>/dev/null; then
  export EDITOR="nvim"
  export VISUAL="nvim"
fi

# --- PATH -----------------------------------------------------------------
path=(~/.local/bin ~/bin $path)
