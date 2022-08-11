# Color aliases
alias grep='grep --color=auto'
alias egrep='grep -E --color=auto'
alias fgrep='grep -F --color=auto'
alias grep='grep --color=auto'
alias ls='lsd'
alias l='lsd -al'
alias cat='bat --paging=never'
# alias cp='rsync -aP'
alias tokei="tokei "$@" | sed 's/=/─/g;s/|/│/g;s/-/─/g;s/^/│/;s/─$//;s/$/│/;s/│─/├─/g;s/─│/─┤/;1s/├/┌/;1s/┤/┐/;/ Total /,\$s/├/└/g;/ Total /,\$s/┤/┘/g'"
alias rg='rg --binary -n -H --no-heading'
alias m='ncmpcpp -S visualizer'

# Confing aliases
alias dosbox='dosbox -conf "$XDG_CONFIG_HOME"/dosbox/dosbox.conf'
alias mongo='mongo --norc'

# System alises
alias poweroff='sudo poweroff'
alias reboot='sudo reboot'
alias hibernate='sudo systemctl suspend'
alias halt='sudo halt'
alias ss='sudo systemctl'
alias ssu='sudo su'
alias suka='sudo'
alias ydl='youtube-dl'
alias gc='git clone'
alias logout='pkill xinit'
alias john='HOME=$XDG_DATA_HOME john'
alias tor='sudo systemctl restart tor && sudo systemctl restart privoxy'

function chpwd_tokei() {
    if test -d .git || test -f docker-compose.yml; then
        timeout 1 tokei 2>/dev/null | sed 's/=/─/g;s/|/│/g;s/-/─/g;s/^/│/;s/─$//;s/$/│/;s/│─/├─/g;s/─│/─┤/;1s/├/┌/;1s/┤/┐/;/ Total /,$s/├/└/g;/ Total /,$s/┤/┘/g'
    fi
}
chpwd_functions=("${chpwd_functions[@]}" chpwd_tokei)

function de() {
    # docker enter
    container_name=$1
    shift
    if [[ -z "$@" ]] then
        case $container_name in
            *mongo* )
                docker exec -it $(docker ps | grep $container_name | cut -d' ' -f'1' | sed q) mongo
                ;;
            *python* )
                docker exec -it $(docker ps | grep $container_name | cut -d' ' -f'1' | sed q) python
                ;;
            * )
                docker exec -it $(docker ps | grep $container_name | cut -d' ' -f'1' | sed q) bash
                ;;
        esac
    else
        docker exec -it $(docker ps | grep $container_name | cut -d' ' -f'1' | sed q) "$@"
    fi
}

function set_proxies(){
        export proxy=socks5://localhost:9050
        export http_proxy=http://localhost:8118
        export https_proxy=$http_proxy
        export ftp_proxy=$http_proxy
        export rsync_proxy=$http_proxy
}

function pystr(){
        python3 -c \
'from falamous import *
import sys
for s in sys.stdin:
    s = s[:-1] 
'"    print($1)"
}

function pybstr(){
        python3 -c \
'from falamous import *
for s in open("/dev/stdin", "rb"):
    s = s[:-1] 
'"    print($1)"
}

# Abbreviations
alias py='ipython -i'
alias py2='python2 -i'
alias py3='ipython3 -i'
alias v='nvim'
alias vim='nvim'
alias hl='highlight -O xterm256'
alias pathfiles='find $(echo $PATH | sed "s|:|/ |g") -type f 2>/dev/null'
alias save_file='tgfile Шизофрения'
alias save_text='tgmsg Шизофрения'
alias aria2c='http_proxy=http://localhost:8118 https_proxy=http://localhost:8118 ftp_proxy=http://localhost:8118 ftps_proxy=http://localhost:8118 rsync_proxy=http://localhost:8118 aria2c'
alias recordscreen='ffmpeg -video_size 1920x1080 -framerate 60 -f x11grab -i :0.0'
