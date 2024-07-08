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

# User configuration for bash history
HISTFILE=~/.zsh_histfile
HISTSIZE=1000
SAVEHIST=2000
HIST_IGNORE_ALL_DUPS=true
setopt appendhistory

zstyle :compinstall filename '/home/acbailey/dotfiles/zsh/.zshrc'

# tmux Sessions 
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

# Aliases
alias gs="git status"
alias ll="eza -l -g --icons --git"
alias llt="eza -l --icons --tree --git-ignore"
alias fd="fdfind"
alias cat="bat"
alias vv="nvim ."
alias v="nvim"

# Define widgets
zle -N insert-unambiguous-or-complete
zle -N menu-search
zle -N recent-paths

# fzf config 
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

source <(fzf --zsh)
alias fz='fzf --preview="bat --style=numbers --color=always --line-range=:1000 {}" --bind "enter:execute(nvim {} < /dev/tty)"'
export FZF_DEFAULT_COMMAND="rg --files --hidden -g '!.config/' -g '!.mozilla' -g '!.local/' -g '!.virtualenvs' -g '!go/' -g '!.cache', -g '!.zcomp*', -g '!node_modules' -g '!.cache'"

export FZF_CTRL_T_OPTS="
  --walker-skip .git,node_modules,target,.local,.cache,.mozilla,.config
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"

export FZF_DEFAULT_OPTS=" \
--color=bg+:#363a4f,bg:#24273a,spinner:#f4dbd6,hl:#ed8796 \
--color=fg:#cad3f5,header:#ed8796,info:#c6a0f6,pointer:#f4dbd6 \
--color=marker:#f4dbd6,fg+:#cad3f5,prompt:#c6a0f6,hl+:#ed8796"

# Path
export PATH="$PATH:/usr/local/bin:/usr/bin:/opt/nvim-linux64/bin/nvim:/opt/nvim-linux64/bin"
 
# Set GOPATH
export GOPATH=$HOME/Developer/go
export PATH=$PATH:$GOPATH/bin
export GO111MODULE=on

#Exports 
export MARKETDATA_TOKEN="RDV0U3FPM2tBcWJIQlhjQThSd0NoWjY1Y1JrSHdhbUU4LWZXZ0NTWWF2bz0"
export OPENAI_API_KEY="sk-proj-IJ170AwolhaSi1N6uMzRT3BlbkFJWWGj6DvBBQi5JTSGHGCW"

# Key bindings
bindkey -v
bindkey '^E' clear-screen
bindkey '^I' autosuggest-accept
bindkey '^ ' autosuggest-execute

bindkey -s -M viins "^[OP" "z /mnt/c/Users/abailey/Developer/svn/cameron_dev && source venv/bin/activate && nvim .^M"
bindkey -s "^O" "nvim \$(fzf)^M"
bindkey -s "^[OP" "z /mnt/c/Users/abailey/Developer/svn/cameron_dev/ && source venv/bin/activate && nvim .^M"
bindkey -s "^[[24~" "nvim ~/.config/nvim/lua/ace/plugins^M"
bindkey -s -M viins "^O" "nvim \$(fzf)^M"
bindkey -s -M emacs "^O" "nvim \$(fzf)^M"

# Source scripts and start up other
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

source /home/acbailey/.oh-my-zsh/custom/plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh
source ~/.zsh/catppuccin_mocha-zsh-syntax-highlighting.zsh
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
