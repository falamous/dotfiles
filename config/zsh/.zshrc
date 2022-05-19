# If not running interactively, don't do anything
[[ $- != *i* ]] && return

HISTSIZE=10000
SAVEHIST=10000
HISTFILE=$XDG_CACHE_HOME/zsh/history

# TOP_LEFT_ANGLE=$(echo -ne "\ue0bc")
# TOP_RIGHT_ANGLE=$(echo -ne "\ue0be")
# LEFT_TRIANGLE=$(echo -ne "\ue0b2")
# RIGHT_TRIANGLE=$(echo -ne "\ue0b0")

source ~/scripts/alias.sh

# colors
autoload -U colors && colors

# syntax highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

ZSH_DONT_USE_VI_MODE=1
if [[ -z $ZSH_DONT_USE_VI_MODE ]] then
    # vi mode
    source /usr/share/zsh/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh
else
    bindkey -e
fi

# The plugin will auto execute this `zvm_after_select_vi_mode` function
function zvm_after_select_vi_mode() {
    case $ZVM_MODE in
        $ZVM_MODE_NORMAL)
            local bg_color=red
            local fg_color=white
            local text=NORMAL
            # Something you want to do...
            ;;
        $ZVM_MODE_INSERT) 
            local bg_color=cyan
            local fg_color=white
            local text=INSERT
            # Something you want to do...
            ;;
        $ZVM_MODE_VISUAL)
            local bg_color=green
            local fg_color=black
            local text=VISUAL
            # Something you want to do...
            ;;
        $ZVM_MODE_VISUAL_LINE)
            local bg_color=green
            local fg_color=black
            local text=V-LINE
            # Something you want to do...
            ;;
    esac
    VI_MODE=""
    VI_MODE+="%K{normal}%F{$bg_color}$LEFT_TRIANGLE"
    VI_MODE+="%K{$bg_color}%F{$fg_color}$text"
    VI_MODE+="%K{normal}%F{$bg_color}$RIGHT_TRIANGLE"
    VI_MODE+="%K{normal}%F{normal}"
}

# show completion
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#555555"

# options
setopt autocd
setopt prompt_subst
setopt interactive_comments
setopt hist_ignore_dups
setopt hist_reduce_blanks

# home end fix
local bound_keys=()

declare -A bound_keys
key='\e[1~'; bound_keys[$key]=beginning-of-line # Linux console
key='\e[H' ; bound_keys[$key]=beginning-of-line # xterm
key='\eOH' ; bound_keys[$key]=beginning-of-line # gnome-terminal
key='\e[2~'; bound_keys[$key]=overwrite-mode    # Linux console, xterm, gnome-terminal
key='\e[3~'; bound_keys[$key]=delete-char       # Linux console, xterm, gnome-terminal
key='\e[P' ; bound_keys[$key]=delete-char      
key='\e[3~'; bound_keys[$key]=delete-char      
key='\e[4~'; bound_keys[$key]=end-of-line       # Linux console
key='\e[F' ; bound_keys[$key]=end-of-line       # xterm
key='\eOF' ; bound_keys[$key]=end-of-line       # gnome-terminal
modes=(
    command
    emacs
    isearch
    main
    vicmd
    viins
    viopp
    visual
)
for key in ${(k)bound_keys}
do
    for mode in $modes
    do
        bindkey -M "$mode" "$key" "$bound_keys[$key]"
    done
done


# completion
autoload -U compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' cache-path $XDG_CACHE_HOME/zsh/zcompcache
zmodload zsh/complist
compinit -d $XDG_CACHE_HOME/zsh/zcompdump
_comp_options+=(globdots)		# Include hidden files.

# vcs for promt
autoload -U vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
zstyle ':vcs_info:git:*' formats ' %F{yellow}%s(%b)'
zstyle ':vcs_info:svn:*' formats ' %F{red}%s(%b)'
zstyle ':vcs_info:hg:*' formats ' %F{grey}%s(%b)'

PS1='%F{magenta}%T %(0?..%F{normal}%K{red}%?%K{normal} )%F{cyan}%~${vcs_info_msg_0_} %F{blue}> %F{normal}'
if [[ -z $ZSH_DONT_USE_VI_MODE ]] then
    PS1='%a${VI_MODE}'"$PS1"
fi

export REDIS_HOST=51.250.2.246
export REDIS_PORT=6378
