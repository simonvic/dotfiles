###########################################
#	Made by
#       _                              _        
#      (_)                            (_)       
#  ___  _  ____    ___   ____   _   _  _   ____ 
# /___)| ||    \  / _ \ |  _ \ | | | || | / ___)
#|___ || || | | || |_| || | | | \ V / | |( (___ 
#(___/ |_||_|_|_| \___/ |_| |_|  \_/  |_| \____)

#	Check updates and give a look at my dotfiles here:
#		https://github.com/simonvic/dotfiles

###########################################


######################################
# HISTORY

mkdir -p ~/.local/share/zsh

HISTFILE=~/.local/share/zsh/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt \
	BEEP \
	NO_MATCH \
	PROMPT_SUBST \
	EXTENDED_GLOB \
	NO_FLOW_CONTROL \
	COMPLETE_IN_WORD \
	EXTENDED_HISTORY \
	HIST_EXPIRE_DUPS_FIRST \
	HIST_IGNORE_SPACE \
	HIST_VERIFY \
	PUSHD_IGNORE_DUPS

######################################
# COLORS
export LS_COLORS="rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.zst=01;31:*.tzst=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.wim=01;31:*.swm=01;31:*.dwm=01;31:*.esd=01;31:*.jpg=01;35:*.jpeg=01;35:*.mjpg=01;35:*.mjpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.webp=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:"

######################################
# ENVIROMENT VARIABLES
export EDITOR="nvim"

######################################
# KEY BINDING
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

bindkey -e
typeset -g -A key=(
[Home]="${terminfo[khome]}"
[End]="${terminfo[kend]}"
[Insert]="${terminfo[kich1]}"
[Backspace]="${terminfo[kbs]}"
[Control-Backspace]="^H"
[Delete]="${terminfo[kdch1]}"
[Control-Delete]="^[[3;5~"
[Up]="${terminfo[kcuu1]}"
[Down]="${terminfo[kcud1]}"
[Left]="${terminfo[kcub1]}"
[Control-Left]="${terminfo[kLFT5]}"
[Right]="${terminfo[kcuf1]}"
[Control-Right]="${terminfo[kRIT5]}"
[PageUp]="${terminfo[kpp]}"
[PageDown]="${terminfo[knp]}"
[Shift-Tab]="${terminfo[kcbt]}"
)


bindkey "${key[Home]}"                beginning-of-line
bindkey "${key[End]}"                 end-of-line
bindkey "${key[Insert]}"              overwrite-mode
bindkey "${key[Backspace]}"           backward-delete-char
bindkey "${key[Control-Backspace]}"   backward-delete-word
bindkey "${key[Delete]}"              delete-char
bindkey "${key[Control-Delete]}"      delete-word
bindkey "${key[Up]}"                  up-line-or-beginning-search
bindkey "${key[Down]}"                down-line-or-beginning-search
bindkey "${key[Left]}"                backward-char
bindkey "${key[Control-Left]}"        backward-word
bindkey "${key[Right]}"               forward-char
bindkey "${key[Control-Right]}"       forward-word
bindkey "${key[PageUp]}"              beginning-of-buffer-or-history
bindkey "${key[PageDown]}"            end-of-buffer-or-history
bindkey "${key[Shift-Tab]}"           reverse-menu-complete

if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
	autoload -Uz add-zle-hook-widget
	function zle_application_mode_start { echoti smkx }
	function zle_application_mode_stop { echoti rmkx }
	add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
	add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
fi

# Change word style to alphanumeric only (better when deleting in paths)
autoload -U select-word-style
select-word-style bash

######################################
# COMPLETITION
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*' # Set completition to be case insensitive
zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' format '%F{245}[ %d ]%f'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' max-errors 2
zstyle ':completion:*' menu select=2
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'
zstyle ':completion:*' special-dirs true
zstyle :compinstall filename '$HOME/.zshrc'


autoload -Uz compinit
# .zcompdump custom location
compinit -d ~/.local/share/zsh/.zcompdump


######################################
# GIT
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
precmd() {
	vcs_info
}

######################################
# THEME
fpath+=($HOME/.config/zsh/custom/themes)

autoload -Uz promptinit
promptinit
prompt simonvic-minimal


######################################
# ALIASES
function xo() {	xdg-open $1 &! }
function t() { tree -h -F -D -L ${1:-1} }
alias ls="ls --color=auto"
alias l="ls -al --human-readable"
alias grep="grep --color"
alias Cp="xclip -r -selection clipboard"
alias todo='sTodo'
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
