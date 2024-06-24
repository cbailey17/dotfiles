# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export TMUXP_CONFIGDIR=$HOME/.config/tmuxp

# oh-my-zsh set up 
ZSH_THEME="cloud"
plugins=(git aliases virtualenv zsh-navigation-tools web-search tmux wd zsh-autocomplete zsh-autosuggestions)

# start oh-my-zsh
source $ZSH/oh-my-zsh.sh

# Source custom oh-my-zsh plugins that require cloning
source /home/acbailey/.oh-my-zsh/custom/plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh

# User configuration for bash history
HISTFILE=~/.zsh_histfile
HISTSIZE=1000
SAVEHIST=1000
HIST_IGNORE_ALL_DUPS=true
setopt appendhistory

zstyle :compinstall filename '/home/acbailey/.zshrc'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Key bindings
bindkey -v
bindkey '^E' clear-screen
# bindkey '\t' autosuggest-accept
bindkey '^ ' autosuggest-execute
bindkey '^I' autosuggest-accept

bindkey -s -M viins "^[OP" "z /mnt/c/Users/abailey/Developer/svn/cameron_dev && source venv/bin/activate && nvim .^M"
bindkey -s "^O" "nvim \$(fzf)^M"
bindkey -s "^[OP" "z /mnt/c/Users/abailey/Developer/svn/cameron_dev/ && source venv/bin/activate && nvim .^M"
bindkey -s "^[[24~" "nvim ~/.config/nvim/lua/ace/plugins^M"
bindkey -s -M viins "^O" "nvim \$(fzf)^M"
# bindkey -s -M viins "^[OP" "z /mnt/c/Users/abailey/Developer/svn/cameron_dev/ && source venv/bin/activate && nvim .^M" bindkey -s -M viins "^[[24~" "nvim ~/.config/nvim/lua/ace/plugins^M"
bindkey -s -M emacs "^O" "nvim \$(fzf)^M"


function sesh-sessions() {
  {
    exec </dev/tty
    exec <&1
    local session
    session=$(sesh list -t -c | fzf --height 40% --reverse --border-label ' sesh ' --border --prompt '⚡  ')
    [[ -z "$session" ]] && return
    sesh connect $session
  }
}

zle     -N             sesh-sessions
bindkey -M emacs '\es' sesh-sessions
bindkey -M vicmd '\es' sesh-sessions
bindkey -M viins '\es' sesh-sessions
  

EDITOR='nvim'

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

alias ll="eza -l -g --icons --git"
alias llt="eza -l --icons --tree --git-ignore"
alias fd="fdfind"
alias cat="bat"
alias v="nvim ."

export FZF_DEFAULT_OPTS=" \
--color=bg+:#363a4f,bg:#24273a,spinner:#f4dbd6,hl:#ed8796 \
--color=fg:#cad3f5,header:#ed8796,info:#c6a0f6,pointer:#f4dbd6 \
--color=marker:#f4dbd6,fg+:#cad3f5,prompt:#c6a0f6,hl+:#ed8796"

# Define the insert-unambiguous-or-complete widget
zle -N insert-unambiguous-or-complete

# Define the menu-search widget
zle -N menu-search

# Define the recent-paths widget
zle -N recent-paths

# Set up sources 
# Set up fzf key bindings and fuzzy completion
#
source <(fzf --zsh)
# set up syntax highlighting
source ~/.zsh/catppuccin_mocha-zsh-syntax-highlighting.zsh

export OPENAI_API_KEY=sk-proj-IJ170AwolhaSi1N6uMzRT3BlbkFJWWGj6DvBBQi5JTSGHGCW
export PATH="$PATH:/usr/local/bin:/usr/bin:/opt/nvim-linux64/bin/nvim"
export PATH="/opt/nvim-linux64/bin/nvim:$PATH:/opt/nvim-linux64/bin"
# Set GOPATH
export GOPATH=$HOME/go
# Add GOPATH/bin to PATH
export PATH=$PATH:$GOPATH/bin
export GO111MODULE=on

source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
