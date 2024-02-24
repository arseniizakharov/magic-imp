#!/bin/zsh

# Setup color variables
ZSH_THEME_COLOR_bc="%F{87}"   # Bracket color
ZSH_THEME_COLOR_gc="%F{85}"   # Git color
ZSH_THEME_COLOR_pc="%F{147}"  # Path color
ZSH_THEME_COLOR_sc="%F{105}"  # Separator color
ZSH_THEME_COLOR_rpc="%F{240}" # Secondary prompt color
ZSH_THEME_COLOR_vc="%F{76}"   # Python venv color
ZSH_THEME_COLOR_vec="%F{244}" # Version color
ZSH_THEME_COLOR_ac="%F{213}"  # Asterisk color (dirty repo)
ZSH_THEME_COLOR_goc="%F{117}" # Go module color

setopt PROMPT_SUBST

# Git
git_prompt_info() {
  local branch=$(git symbolic-ref HEAD 2> /dev/null || git rev-parse --short HEAD 2> /dev/null)
  local dirty=$(git status --porcelain 2> /dev/null)
  if [[ -n $branch ]]; then
    echo "${ZSH_THEME_COLOR_bc}[${ZSH_THEME_COLOR_gc}${branch#refs/heads/}${dirty:+${ZSH_THEME_COLOR_ac}*}${ZSH_THEME_COLOR_bc}]%f"
  fi
}

# Python
python_venv_info() {
  if [[ -n $VIRTUAL_ENV ]]; then
    local env_name=$(basename "$VIRTUAL_ENV")
    echo "(${ZSH_THEME_COLOR_vc}${env_name}%f)"
  fi
}

# Go
go_module_info() {
  if [[ -f go.mod ]]; then
    local mod_name=$(go list -m 2> /dev/null)
    echo "(${ZSH_THEME_COLOR_goc}${mod_name:+$mod_name}%f)"
  fi
}

PROMPT='${ZSH_THEME_COLOR_pc}%~ $(git_prompt_info) ${ZSH_THEME_COLOR_sc}»%f '
RPROMPT='$(python_venv_info)$(go_module_info) ${ZSH_THEME_COLOR_rpc}%n@%m%f'
