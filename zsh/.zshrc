# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export TMUXP_CONFIGDIR=$HOME/.config/tmuxp

export DISABLE_AUTO_TITLE='true'

# Path
export PATH="$PATH:/usr/local/bin:/usr/bin:/opt/nvim-linux64/bin/nvim:/opt/nvim-linux64/bin"
export PATH="/usr/local/bin:/opt/homebrew/bin:$PATH"
export PATH="/usr/local/sbin:$PATH:/Users/cameronbailey/bin:$PATH"

export CBIN="/Users/cameronbailey/bin"

# oh-my-zsh set up 
ZSH_THEME="cloud"
plugins=(git aliases virtualenv zsh-navigation-tools web-search wd zsh-autocomplete zsh-autosuggestions)

# start oh-my-zsh
source $ZSH/oh-my-zsh.sh

# User configuration for bash history
HISTFILE=~/.zsh_histfile
HISTSIZE=1000
SAVEHIST=2000
HIST_IGNORE_ALL_DUPS=true
setopt appendhistory

zstyle :compinstall filename '/Users/cameronbailey/dotfiles/zsh/.zshrc'

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
alias tn="tmux new -s (pwd | sed 's/.*\///g')"

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

export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
  --color=fg:#cbe0f0,fg+:#cbe0f0,bg:#011423,bg+:#011423
  --color=hl:#5f87af,hl+:#5fd7ff,info:#afaf87,marker:#87ff00
  --color=prompt:#d7005f,spinner:#af5fff,pointer:#af5fff,header:#87afaf
  --color=border:#00d9ff,label:#aeaeae,query:#d9d9d9
  --border="rounded" --border-label="" --preview-window="border-rounded" --prompt="> "
  --marker=">" --pointer="◆" --separator="─" --scrollbar="│"'

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


 
# Set GOPATH
export GOPATH=$HOME/Developer/go
export PATH=$PATH:$GOPATH/bin
export GO111MODULE=on

#Exports 
export MARKETDATA_TOKEN="RDV0U3FPM2tBcWJIQlhjQThSd0NoWjY1Y1JrSHdhbUU4LWZXZ0NTWWF2bz0"
export OPENAI_API_KEY="sk-proj-IJ170AwolhaSi1N6uMzRT3BlbkFJWWGj6DvBBQi5JTSGHGCW"

# Spring configuration 
export SPRING_PROFILES_ACTIVE=looqlocalhost
export SPRING_PROFILES_ACTIVE=looqdev
# export SPRING_PROFILES_ACTIVE=looqprod

neofetch

# Key bindings
bindkey -v
bindkey '^E' clear-screen
bindkey '^I' autosuggest-accept
bindkey '^ ' autosuggest-execute

bindkey -s "^O" "nvim \$(fzf)^M"
bindkey -s "^[[24~" "nvim ~/.config/nvim/lua/ace/plugins^M"
bindkey -s -M viins "^O" "nvim \$(fzf)^M"
bindkey -s -M emacs "^O" "nvim \$(fzf)^M"

# Source scripts and start up other
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

source /Users/cameronbailey/.oh-my-zsh/custom/plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh
source ~/.zsh/catppuccin_mocha-zsh-syntax-highlighting.zsh
export HOMEBREW_PREFIX=/opt/homebrew
source $HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
