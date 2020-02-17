ZSH_THEME_GIT_PROMPT_PREFIX=" «%{$fg[yellow]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}»"
ZSH_THEME_GIT_PROMPT_DIRTY="$FG[130] ✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[cyan]%} ±%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_AHEAD="%{$fg[cyan]%} ▴%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_BEHIND="%{$fg[magenta]%} ▾%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%} ✓%{$reset_color%}"
#ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%} ♥%{$reset_color%}"
#ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%} ♡%{$reset_color%}"

function prompt_begin {
	#separator
	#echo "·························································\n"
	
	#Starting block
	echo "%{$bg[red]%}%{$fg[white]%} %{$reset_color%}"
}

function prompt_char {
	if [ $UID -eq 0 ]; then echo "# "; else echo "§ "; fi
}

PROMPT='$(prompt_begin)%{$fg[gray]%}<%{$fg[red]%}%~%{$reset_color%}%{$fg[gray]%}>$(git_prompt_info) %{$fg[red]%}$(prompt_char)%{$reset_color%}'
RPROMPT='$FG[059][%*]%(?,$FG[022][R-$?],$FG[130][R-$?])$FG[024][!%!]%{$reset_color%}'

