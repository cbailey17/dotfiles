# iF YOU COME FROM bash you might have to change your $PATH.
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
  
EDITOR='nvim'

# Aliases
alias gs="git status"
alias ll="eza -l -g --icons --git"
alias llt="eza -l --icons --tree --git-ignore"
alias fd="fdfind"
alias cat="bat"
alias vv="nvim ."
alias v="nvim"
alias tn="tmux new -s ${PWD##*/}"
alias t="tmux"
alias zz="z .."
alias ns="npm run start"
alias lg="lazygit"
alias db="ssh -v -i ~/.ssh/device_api_ec2_keypair.pem ubuntu@ec2-3-238-38-140.compute-1.amazonaws.com  -o StrictHostKeyChecking=no"
alias tk="tmux kill-session -t"
alias kt='kill_current_tmux_session'
alias lintjava="git diff --name-only looq-dev | grep .java | xargs -I {} sudo docker run --rm -v "${PWD}":/local vandmo/google-java-format google-java-format -i /local/{}"


kill_current_tmux_session() {
  local current_session
  current_session=$(tmux display-message -p '#S')
  if [ -n "$current_session" ]; then
    tmux kill-session -t "$current_session"
  else
    echo "No tmux session found"
  fi
}
zle -N kill_current_tmux_session

eval "$(luarocks path --bin)"


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


export XDG_CONFIG_HOME="$HOME/.config"
 
# Set GOPATH
export GOPATH=$HOME/Developer/go
export PATH=$PATH:$GOPATH/bin
export GO111MODULE=on

# Spring configuration 
# export SPRING_PROFILES_ACTIVE=looqlocalhost
# export SPRING_PROFILES_ACTIVE=mweblocalhost
# export SPRING_PROFILES_ACTIVE=looqdev
# export SPRING_PROFILES_ACTIVE=looqprod

export PG_USER=cameronbailey
export PG_PASSWORD=ACBacb0117!!
export PG_PORT=5432
export PG_HOST=localhost
export PG_NAME=looqai


# Use vi keybindings in Zsh (switches to vi mode)
bindkey -v

# Clear the terminal screen when pressing Ctrl + E
bindkey '^E' clear-screen

# Accept autosuggestion when pressing Ctrl + I (Tab)
bindkey '^I' autosuggest-accept

# Execute the autosuggested command when pressing Ctrl + Space
bindkey '^ ' autosuggest-execute

# Open Neovim using fzf to select a file when pressing Ctrl + O (Emacs mode)
bindkey -s "^O" "nvim \$(fzf)^M"

# Open Neovim and edit the plugins file when pressing F12
bindkey -s "^[[24~" "nvim ~/.config/nvim/lua/ace/plugins^M"

# Open Neovim using fzf to select a file when pressing Ctrl + O (Vi insert mode)
bindkey -s -M viins "^O" "nvim \$(fzf)^M"

# Open Neovim using fzf to select a file when pressing Ctrl + O (Emacs mode)
bindkey -s -M emacs "^O" "nvim \$(fzf)^M"

# Run a command to connect to a session (using sesh and gum) when pressing F3
bindkey -s "^[OR" 'sesh connect "$(sesh list -i | gum filter --limit 1 --placeholder '\''Pick a sesh'\'' --prompt='\''⚡'\'')"^M'

# Bind F1 to switch Java versions and load a Tmuxp configuration
bindkey -s "^[OP" "sdk use java 11.0.23-amzn && tmuxp load /Users/cameronbailey/dotfiles/tmuxp/.config/tmuxp/webservice.yaml^M"

# Bind F2 to load a different Tmuxp configuration
bindkey -s "^[OQ" "tmuxp load /Users/cameronbailey/dotfiles/tmuxp/.config/tmuxp/webapp.yaml^M"

bindkey -s '^[[[D' "kill_current_tmux_session^M"

# Move backward by one word when pressing Esc + h
bindkey '\eh' backward-word

# Move forward by one word when pressing Esc + l
bindkey '\el' forward-word

# Move to the beginning of the line when pressing Ctrl + A
bindkey '^a' beginning-of-line

# Move to the end of the line when pressing Ctrl + Z
bindkey '^z' end-of-line

# Delete to the beginning of the line when pressing Esc + H
kill-to-beginning-of-line() {
  zle backward-kill-line
}
zle -N kill-to-beginning-of-line
bindkey '^A' kill-to-beginning-of-line

# Delete to the end of the line when pressing Esc + L
kill-to-end-of-line() {
  zle kill-line
}
zle -N kill-to-end-of-line
bindkey '^Z' kill-to-end-of-line

# Source scripts and start up other
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

# source $(brew --prefix nvm)/nvm.sh
# source /Users/cameronbailey/.oh-my-zsh/custom/plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh
source ~/.zsh/catppuccin_mocha-zsh-syntax-highlighting.zsh
# export HOMEBREW_PREFIX=/opt/homebrew
# source $HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# bun completions
[ -s "/Users/cameronbailey/.bun/_bun" ] && source "/Users/cameronbailey/.bun/_bun"

# bun
export OPENAI_API_KEY="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"
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
export PATH="$HOME/Developer/Software/prince-15.4.1-macos/lib/prince/bin:$PATH"

export GPG_TTY=$(tty)
