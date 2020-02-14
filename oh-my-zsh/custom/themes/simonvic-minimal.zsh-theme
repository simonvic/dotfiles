# PROMPT="[%*] %n:%c $(git_prompt_info)%(!.#.$) "
#neofetch
#tree -P %C

#######################################################
prompt_segment() {
  local bg fg
  if [[ -n $1 && $1 == r ]]
  then
    shift
    rprompt_segment $@
    return
  fi
  [[ -n $1 ]] && bg="%K{$1}" || bg="%k"
  [[ -n $2 ]] && fg="%F{$2}" || fg="%f"
  if [[ $CURRENT_BG != 'NONE' && $1 != $CURRENT_BG ]]; then
    echo -n "%{$bg%F{$CURRENT_BG}%}%{$fg%}"
  else
    echo -n "%{$bg%}%{$fg%}"
  fi
  CURRENT_BG=$1
  [[ -n $3 ]] && echo -n $3
}
#######################################################




#######################################################
rprompt_segment() {
  local bg fg
  [[ -n $1 ]] && bg="%K{$1}" || bg="%k"
  [[ -n $2 ]] && fg="%F{$2}" || fg="%f"

  echo -n "%{%K{$CURRENT_BG_R}%F{$1}%}$SEGMENT_SEPARATOR_R%{$bg$fg%}"
  
  CURRENT_BG_R=$1
  [[ -n $3 ]] && echo -n $3
}
#######################################################








#######################################################
prompt_end() {
  if [[ -n $CURRENT_BG ]]; then
    echo -n "%{%k%F%}"
  else
    echo -n "%{%k%}"
  fi
  echo -n "%{%f%}"
  CURRENT_BG=''
}
#######################################################





#######################################################
prompt_context() {
  local user=`whoami`

  if [[ "$user" != "$DEFAULT_USER" || -n "$SSH_CLIENT" ]]; then
    prompt_segment black white "%(!.%{%F{yellow}%}.)$user@%m"
  fi
}
#######################################################


ZSH_THEME_GIT_PROMPT_PREFIX=" %{$fg[yellow]%}git:("
ZSH_THEME_GIT_PROMPT_SUFFIX=")%{$reset_color%}"




#######################################################
prompt_dir() {
  prompt_segment $1 7 black '%30<…<%~'
}
#######################################################





#######################################################
prompt_status() {
  local symbols
  local jobs
  jobs=$(jobs -l | wc -l)
  symbols=()
  [[ $RETVAL -ne 0 ]] && symbols+="%{%F{red}%}✘${RETVAL}"
  [[ $UID -eq 0 ]] && symbols+="%{%F{yellow}%}⚡"
  [[ $jobs -gt 0 ]] && symbols+="%{%F{cyan}%}⚙${jobs}"

  [[ -n "$symbols" ]] && prompt_segment $1 7 white "$symbols"
}
#######################################################


build_prompt() {
  RETVAL=$?
  prompt_context
  prompt_dir
  prompt_end
}
build_rprompt() {
  RETVAL=$?
  prompt_status r
}




#export PROMPT='%{$fg[cyan]%}%n%{$reset_color%}@%{$fg[green]%}%c%{$reset_color%}$(git_prompt_info) %(!.#.$ )'
#export RPROMPT='[%*]'

export PROMPT='%{%f%b%k%}$(build_prompt)'
export RPROMPT='%{%f%b%k%}$(build_rprompt)'