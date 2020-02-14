echo
neofetch --color_blocks off
local return_code="%(?..%{$fg[red]%}%?↵%{$reset_color%})"

# Check if root
if [ $UID -eq 0 ]; then 
	NCOLOR="green"
	local symbol='#'
else 
	NCOLOR="red"
	local symbol='$'
fi

# Prompt
PROMPT='[%*]%{$fg[$NCOLOR]%}%B%n%b%{$reset_color%}@%{$fg_bold[blue]%}%B%~%b%{$reset_color%}$(git_prompt_info)%(!.#.$) '
#RPROMPT='%B${return_code}%b'

# Git Branch
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}(%{$fg_no_bold[yellow]%}%B"
ZSH_THEME_GIT_PROMPT_SUFFIX="%b%{$fg_bold[blue]%})%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg_bold[red]%}✗"
