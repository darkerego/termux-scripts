export PATH=$PATH:/data/com.termux/files/home/bin
alias fs='/data/data/com.termux/files'
alias cdfs='cd /data/data/com.termux/files'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias ls='ls --color=auto'
alias ll='ls -l'
alias la='ls -A'
alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -p -v'
alias df='df -h'
alias du='du -h -c'
alias reload='source ~/.bashrc'
alias biggest='BLOCKSIZE=1048576; du -x | sort -nr | head -10'
alias bb='busybox'
alias cdboot='cd ~/.termux/boot'
alias nn='netstat -taupenv'
# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Base 64 En/Decode
decode () {
  echo "$1" | base64 -d ; echo
}

encode () {
  echo "$1" | base64 ; echo
}

# Easy extract
extract () {
  if [ -f $1 ] ; then
      case $1 in
          *.tar.bz2)   tar xvjf $1    ;;
          *.tar.gz)    tar xvzf $1    ;;
          *.bz2)       bunzip2 $1     ;;
          *.rar)       rar x $1       ;;
          *.gz)        gunzip $1      ;;
          *.tar)       tar xvf $1     ;;
          *.tbz2)      tar xvjf $1    ;;
          *.tgz)       tar xvzf $1    ;;
          *.zip)       unzip $1       ;;
          *.Z)         uncompress $1  ;;
          *.7z)        7z x $1        ;;
          *)           echo "don't know how to extract '$1'..." ;;
      esac
  else
      echo "'$1' is not a valid file!"
  fi
}
# gzip directory
alias compress=cgz $@
# Makes directory then moves into it

genpass() {
        local l=$1
        [ "$l" == "" ] && l=16
        tr -dc A-Za-z0-9_ < /dev/urandom | head -c ${l} | xargs | tee -a ~/.passlist
}

encrypt(){
  case $1 in
  -e) echo "$2" | openssl enc -base64 -aes-128-cbc -a -salt -pass pass:"$3"
  ;;
  -f) cat "$2" | openssl enc -base64 -aes-128-cbc -a -salt -pass pass:"$3"
  ;;
  -h|--help) echo "Encrypt a file/string with AES-128-CBC w/ Base64 "
             echo "                   encrypt -e <string> <password>"
             echo "                   encrypt -f <file> <password>  "
  ;;
  esac
}


decrypt(){
  case $1 in
  -e) echo "$2" | openssl enc -d -base64 -aes-128-cbc -a -salt -pass pass:"$3"
  ;;
  -f) cat "$2" | openssl enc -d -base64 -aes-128-cbc -a -salt -pass pass:"$3"
  ;;
  -h|--help) echo  "Decrypt a file/string with AES-128-CBC w/ Base64 "
             echo   "                  decrypt -e <string> <password>"
             echo   "                  decrypt -f <file> <password>"
  ;;
  esac
}




function mkcd() {
  mkdir -p -v $1
  cd $1
}

# Creates an archive from given directory
mktar() { tar cvf  "${1%%/}.tar"     "${1%%/}/"; }
mktgz() { tar cvzf "${1%%/}.tar.gz"  "${1%%/}/"; }
mktbz() { tar cvjf "${1%%/}.tar.bz2" "${1%%/}/"; }

### ALIASES

## Keeping things organized


## Moving around & all that jazz
alias back='cd $OLDPWD'
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."

## Dir shortcuts
alias home='cd ~/'
alias root='cd /data/data/com.termux/files'
alias bin='cd ~/bin'


weather(){ curl -s "http://api.wunderground.com/auto/wui/geo/ForecastXML/index.xml?query=${@:-<YOURZIPORLOCATION>}"|perl -ne '/<title>([^<]+)/&&printf "%s: ",$1;/<fcttext>([^<]+)/&&print $1,"\n"';}


alias urle='python -c "import urllib, sys; print urllib.quote(  sys.argv[1] if len(sys.argv) > 1 else sys.stdin.read()[0:-1])"'
alias urld='python -c "import urllib, sys; print urllib.unquote(sys.argv[1] if len(sys.argv) > 1 else sys.stdin.read()[0:-1])"'

urlencode() {
    # urlencode <string>
    local length="${#1}"
    for (( i = 0; i < length; i++ )); do
        local c="${1:i:1}"
        case $c in
            [a-zA-Z0-9.~_-]) printf "$c" ;;
            *) printf '%%%02X' "'$c"
        esac
    done
}

urldecode() {
    # urldecode <string>

    local url_encoded="${1//+/ }"
    printf '%b' "${url_encoded//%/\\x}"
}

subnets(){
cat $1 | sort -u | cut -d "." -f -3 | sed 's/$/.*/'
}

getIp(){
curl -s checkip.dyndns.org | sed -e 's/.*Current IP Address: //' -e 's/<.*$//'
}

proxup(){
proxy_server='some anonymous vps of yours'
ssh -fND 8080 proxy_server
echo "Status: $?"
}

sprunge(){
cat "$@" |proxychains curl -F 'sprunge=<-' http://sprunge.us 
}
alias spr="curl -F 'sprunge=<-' http://sprunge.us"
# Not sure how to use this on Android yet
#stream(){

#if [[ ! -d /home/$USER/.webcam ]] ; then
#  mkdir  -d /home/$USER/.webcam 
#fi

#secs="$@"
#secs_=$(echo -n "$secs"| grep -oe "[0-9].*")

#{ test -n $secs || secs="30" ;}
#echo "Recording for $secs seconds..."
#streamer -q -c /dev/video0 \
# -f rgb24 \
#-r 3 \
#-t 00:"$secs" \
#-ns 352x240 \
# -o /home/$USER/.webcam/stream-`date +%s`.avi
#}


ping8(){
int=${1:-"4"}
echo -n "Pinging 8.8.8.8 $int times...\n"
ping -c $int 8.8.8.8
}

compst(){
case "$1" in '-')
cat /dev/stdin | curl compst.io/static -Fp=\<-
;;
*)
cat "$@" | curl compst.io/static -Fp=\<-
;;
esac
}

tb(){
test -f "$@" && cat "$@"|nc termbin.com 9999  || echo "$@" | nc termbin.com \
9999
}



getTx(){
tx="$@"
which torify >/dev/null 2>&1 || { echo 'Install tor for privacy first and than rereun. Alternatly, edit this function.' ; exit 1 ;}
torify curl https://api.blockcypher.com/v1/btc/main/txs/"$tx"
}
