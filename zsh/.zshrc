export LANG=ja_JP.UTF-8

autoload -Uz compinit
compinit

autoload -Uz colors
colors

bindkey -v

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

setopt auto_cd
setopt auto_menu
setopt auto_pushd
setopt pushd_ignore_dups
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt no_beep
setopt rm_star_silent
setopt list_packed
setopt list_types
setopt no_case_glob
setopt complete_in_word
setopt auto_param_slash
setopt auto_param_slash

autoload -U promptinit
promptinit

#Keybind
alias ls='command ls --color=auto -FG'

REPORTTIME=2

#Plugin
source ~/.zplug/init.zsh

zplug "chrissicool/zsh-256color", use:"zsh-256color.plugin.zsh"
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-completions"
zplug "mafredri/zsh-async", on:sindresorhus/pure
zplug "sindresorhus/pure"
zplug "b4b4r07/enhancd", use:init.sh
zplug "junegunn/fzf-bin", as:command, from:gh-r, rename-to:fzf, use:"*linux*amd64*"

zplug "zsh-users/zsh-syntax-highlighting", nice:10

if ! zplug check --verbose; then
  printf 'Install? [y/N] '
  if read -q; then
    echo; zplug install
  fi
fi    

zplug load --verbose

