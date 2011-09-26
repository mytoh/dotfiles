
# Options {{{
bindkey -e
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_save_no_dups
setopt hist_reduce_blanks
setopt share_history

setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushd_to_home
setopt auto_name_dirs

setopt extended_glob
setopt glob_dots
setopt multibyte
setopt notify
setopt clobber
setopt list_packed list_types nolist_beep
setopt hash_list_all
setopt list_rows_first
setopt long_list_jobs
setopt noflow_control
setopt ignore_eof
setopt complete_aliases
setopt complete_in_word
setopt magic_equal_subst
setopt mark_dirs
setopt auto_remove_slash
setopt no_auto_param_slash
setopt dvorak

setopt always_last_prompt
setopt prompt_subst
setopt prompt_percent
setopt transient_rprompt

setopt cdable_vars
setopt print_eightbit
setopt auto_menu
unsetopt bg_nice appendhistory beep nomatch
limit coredumpsize 0
#umask 022
# }}}

# internal function {{{
check_com() { # {{{
# grml zshrc
# utility functions
# this function checks if a command exists and returns either true
# or false. This avoids using 'which' and 'whence', which will
# avoid problems with aliases for which on certain weird systems. :-)
# Usage: check_com [-c|-g] word
#   -c  only checks for external commands
#   -g  does the usual tests and also checks for global aliases
#   ex) if check_com -c vim; then
#           ..... 
#       fi
#
    emulate -L zsh
    local -i comonly gatoo

    if [[ $1 == '-c' ]] ; then
        (( comonly = 1 ))
        shift
    elif [[ $1 == '-g' ]] ; then
        (( gatoo = 1 ))
    else
        (( comonly = 0 ))
        (( gatoo = 0 ))
    fi

    if (( ${#argv} != 1 )) ; then
        printf 'usage: check_com [-c] <command>\n' >&2
        return 1
    fi

    if (( comonly > 0 )) ; then
        [[ -n ${commands[$1]}  ]] && return 0
        return 1
    fi

    if   [[ -n ${commands[$1]}    ]] \
      || [[ -n ${functions[$1]}   ]] \
      || [[ -n ${aliases[$1]}     ]] \
      || [[ -n ${reswords[(r)$1]} ]] ; then

        return 0
    fi

    if (( gatoo > 0 )) && [[ -n ${galiases[$1]} ]] ; then
        return 0
    fi

    return 1
}
# }}}

xsource() { # {{{
# grml zshrc
# Check if we can read given files and source those we can.
    emulate -L zsh
    if (( ${#argv} < 1 )) ; then
        printf 'usage: xsource FILE(s)...\n' >&2
        return 1
    fi

    while (( ${#argv} > 0 )) ; do
        [[ -r "$1" ]] && source "$1"
        shift
    done
    return 0
}
#}}}
# }}}

# Environment {{{
# set local variables
local home=$HOME

setopt all_export # may cause problem

LANG=fi_FI.UTF-8
REPORTTIME=3


GAUCHE_LOAD_PATH="$home/.gosh"
FTP_PASSIVE_MODE=true
MYGITDIR=~/local/git
G_FILENAME_ENCODING=@locale
RLWRAP_HOME=~/.rlwrap
LISTMAX=0
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

# history
HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=$HISTSIZE

# vim
EDITOR=vim
if ! check_com -c vim; then
  alias vim=vi
fi
MYVIMRC=~/.vimrc
VIMRUNTIME=(~/.vim/vundle:$VIMRUNTIME)


# ls
LSCOLORS=exFxCxdxBxegedabagacad
if check_com -c gdircolors && [[ ! -e $home/.dir_colors ]]; then
  eval $(gdircolors $home/.dir_colors -b)
  ZLS_COLORS=$LS_COLORS
else
  LS_COLORS='di=34:ln=35:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
fi

# less
PAGER="less"
LESS='-i  -w -z-4 -g -M -X -F -R -P%t?f%f \
  :stdin .?pb%pb\%:?lbLine %lb:?bbByte %bb:-...'
LESS_TERMCAP_mb=$'\E[01;31m'
LESS_TERMCAP_md=$'\E[01;31m'
LESS_TERMCAP_me=$'\E[0m'
LESS_TERMCAP_se=$'\E[0m'
LESS_TERMCAP_so=$'\E[01;44;33m'
LESS_TERMCAP_ue=$'\E[0m'
LESS_TERMCAP_us=$'\E[01;32m'

# paths
path=(
~/local/*/{sbin,bin}(N-/)
~/local/bin(N-/)
/opt/X11/bin(N-/)
/usr/X11/bin(N-/)
/usr/X11R6/bin(N-/)
/usr/games(N-/)
/usr/local/{sbin,bin}(N-/)
/usr/local/*/{sbin,bin}(N-/)
/usr/{sbin,bin}(N-/)
/{sbin,bin}(N-/))

if [ -d /usr/local/lib/cw ]; then
  path=( ~/.cw(N-/) $path )
fi
## zsh functions directory
fpath=(~/.zsh/functions/completion ${fpath})

manpath=(
~/local/share/man(N-/)
/usr/local/man(N-/)
/usr/local/*/man(N-/)
/usr/share/man(N-/)
$manpath)

unset INFOPATH
typeset -xT INFOPATH infopath
typeset -U infopath
infopath=(~/.info(N-/)
~/local/share/info(N-/)
/usr/local/*/info(N-/)
$infopath)

typeset -U cdpath
cdpath=(~/local ~/local/var)

# remove duplicates
typeset -U path cdpath fpath manpath infopath
# }}}

# named directories {{{
# $ cd ~dir
hash -d quatre=~/local/mnt/quatre
hash -d desk=~/local/mnt/deskstar
hash -d mypass=~/local/mnt/mypassport
# }}}

# Autoloads {{{
autoload -Uz compinit  && compinit -C # ignore insecure directories in $fpath
autoload colors &&  colors
autoload -Uz zmv
autoload -Uz is-at-least
autoload -Uz run-help
autoload -Uz zrecompile
# remove all ~ files recursively
# zargs **/*~ -- rm
autoload -Uz zargs

# }}}

# Modules {{{
zmodload zsh/complist
# }}}

# compdef {{{
compdef _portmaster portbuilder 
# }}}

# Zstyles {{{
zstyle :compinstall filename $home/.zshrc
zstyle ':completion:*' completer _oldlist _complete _match _history _ignored _approximate _prefix
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:default' menu select=2
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}'  '+m:[-._]=[-._] r:|[-._]=** r:|=*' '+l:|=*' '+m:{A-Z}={a-z}'
zstyle ':completion:*' format 'Completing %F{blue}%d%F{white}'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' use-cache true
zstyle ':completion:*:functions' ignore-patterns '_*'
# complete $cdpath directories when no candidates in local directory
zstyle ':completion:*:cd:*' tag-order local-directories path-directories
# }}}

# git prompt {{{
# briancarper.net/tag/249/zsh 
autoload -Uz vcs_info
autoload -Uz add-zsh-hook

zstyle ':vcs_info:*' stagedstr '%F{28}● '
zstyle ':vcs_info:*' unstagedstr '%F{11}●'
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' enable git svn

_update_vcs_info_msg() {
  if [[ -z $(git ls-files --other --exclude-standard 2> /dev/null) ]] {
    zstyle ':vcs_info:*' formats ' [%F{green}%b%c%u%F{blue}]'
  } else {
  zstyle ':vcs_info:*' formats ' [%F{green}%b%c%u%F{red}+%F{blue}]'
}
vcs_info
}

precmd_functions=(_update_vcs_info_msg $precmd_functions)
# }}}

# Prompts {{{
setup_prompt(){
unset PROMPT
PROMPT+="%{$fg[green]%}[%~]%{$fg[white]%} "
# git prompt
gitprompt='%F{blue}${vcs_info_msg_0_}%F{blue} %(?/%F{blue}/%F{red})%{$reset_color%}'
PROMPT+=$gitprompt
# ip
#ip="(%F{yellow}$(curl ifconfig.me 2>/dev/null)%{$reset_color%})"
#PROMPT+=$ip
####
PROMPT+=$'\n'
PROMPT+="%{$fg[cyan]%}>>>%{$reset_color%} "
PROMPT2="%{$fg[cyan]%}%_%%%{$reset_color%} "
SPROMPT="%{$fg[cyan]%}%r is correct? [n,y,a,e]:%{^[[m%} "
[ -n "${REMOTEHOST}${SSH_CONNECTION}" ] &&
  PROMPT="%{$fg[red]%}$(echo ${HOST%%.*} | tr '[a-z]' '[A-Z]') $PROMPT"
if [[ $TERM != cons25 && $TERM != xterm ]]; then
  local muridana="%{$fg[cyan]%}(・x・) %{$reset_color%}"
  RPROMPT=$muridana
fi
}
setup_prompt
# }}}

# History search keymap {{{
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "\\ep" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end
bindkey "\\en" history-beginning-search-forward-end
# }}}

# Functions {{{

# zshwiki hardstatus
_title() {
  if [[ $TERM == screen* ]]; then
    print -nR $'\033k'$1$'\033'\\
    print -nR $'\033]0;'$2$'\a'
  elif [[ $TERM == xterm* || $TERM == jfbterm* ]]; then
    print -nR $'\033]0;'$*$'\a'
  fi
}

precmd_functions=(precmd_update_title $precmd_functions)
precmd_update_title() {
  _title zsh "$PWD"
  rehash
}

preexec_functions=(preexec_update_title $precmd_functions)
preexec_update_title() {
  emulate -L zsh
  local -a cmd; cmd=(${(z)1})
  _title $cmd[1]:t "$cmd[2,-1]"
}

tm() {
  if tmux ls >/dev/null 2>&1; then
    tmux attach
  else
    tmux -u2
  fi
}

svim() {
  if [[ -n `pgrep X` ]]; then
    vim --servername VIM --remote-silent $1
  else
    vim $1
  fi
}


## 256色生成用便利関数
# 
### red: 0-5
### green: 0-5
### blue: 0-5
color256()
{
  local red=$1; shift
  local green=$2; shift
  local blue=$3; shift

  echo -n $[$red * 36 + $green * 6 + $blue + 16]
}

fg256()
{
  echo -n $'\e[38;5;'$(color256 "$@")"m"
}

bg256()
{
  echo -n $'\e[48;5;'$(color256 "$@")"m"
}

colortest()
{
# colortesh.sh
# from arch linux forum 
# september 2011 screenshots thread
emulate -L zsh
local T='▆ ▆'   # The test text

echo -e "\n                 40m     41m     42m     43m\
     44m     45m     46m     47m";

for FGs in '    m' '   1m' '  30m' '1;30m' '  31m' '1;31m' '  32m' \
           '1;32m' '  33m' '1;33m' '  34m' '1;34m' '  35m' '1;35m' \
           '  36m' '1;36m' '  37m' '1;37m';
  do FG=${FGs// /}
  echo -en " $FGs \033[$FG  $T  "
  for BG in 40m 41m 42m 43m 44m 45m 46m 47m;
    do echo -en "$EINS \033[$FG\033[$BG  $T  \033[0m";
  done
  echo;
done
echo

}

get-html() {
# save webpages as html file
# -r recursive
# -np : no folow parent
# -k  : make links as relative path
  wget --page-requisites \
    --no-parent \
    --convert-links \
    --backup-converted \
    --mirror \
    --adjust-extension \
    --random-wait $*
}

SS2mkd(){
## get SSes from wiki page and
# convert to mkd
 emulate -L zsh
local num=1

for num in `seq 1 1200`;
do
  if [ ! -e SS$num.txt ]; then
w3m -dump_source nagatoyuki.info/?SS%BD%B8%2F$num |nkf|pandoc -t markdown -f html | sed -e 's/\\$//g' > SS$num.mkd
fi
echo $num.mkd
done
}


hex() {
# print hex value of a number
    emulate -L zsh
    [[ -n "$1" ]] && printf "%x\n" $1 || { print 'Usage: hex <number-to-convert>' ; return 1 }
}

cd() {
# smart cd function, allows switching to /etc when running 'cd /etc/fstab'
    if (( ${#argv} == 1 )) && [[ -f ${1} ]]; then
        [[ ! -e ${1:h} ]] && return 1
        print "Correcting ${1} to ${1:h}"
        builtin cd ${1:h}
    else
        builtin cd "$@"
    fi
}

unpack() {
# Usage: simple-extract <file>
# Using option -d deletes the original archive file.
#f5# Smart archive extractor
    emulate -L zsh
    setopt extended_glob noclobber
    local DELETE_ORIGINAL DECOMP_CMD USES_STDIN USES_STDOUT GZTARGET WGET_CMD
    local RC=0
    zparseopts -D -E "d=DELETE_ORIGINAL"
    for ARCHIVE in "${@}"; do
        case $ARCHIVE in
            *.(tar.bz2|tbz2|tbz))
                DECOMP_CMD="tar -xvjf -"
                USES_STDIN=true
                USES_STDOUT=false
                ;;
            *.(tar.gz|tgz))
                DECOMP_CMD="tar -xvzf -"
                USES_STDIN=true
                USES_STDOUT=false
                ;;
            *.(tar.xz|txz|tar.lzma))
                DECOMP_CMD="tar -xvJf -"
                USES_STDIN=true
                USES_STDOUT=false
                ;;
            *.tar)
                DECOMP_CMD="tar -xvf -"
                USES_STDIN=true
                USES_STDOUT=false
                ;;
            *.rar)
                DECOMP_CMD="unrar x"
                USES_STDIN=false
                USES_STDOUT=false
                ;;
            *.lzh)
                DECOMP_CMD="lha x"
                USES_STDIN=false
                USES_STDOUT=false
                ;;
            *.7z)
                DECOMP_CMD="7z x"
                USES_STDIN=false
                USES_STDOUT=false
                ;;
            *.(zip|jar))
                DECOMP_CMD="unzip"
                USES_STDIN=false
                USES_STDOUT=false
                ;;
            *.deb)
                DECOMP_CMD="ar -x"
                USES_STDIN=false
                USES_STDOUT=false
                ;;
            *.bz2)
                DECOMP_CMD="bzip2 -d -c -"
                USES_STDIN=true
                USES_STDOUT=true
                ;;
            *.(gz|Z))
                DECOMP_CMD="gzip -d -c -"
                USES_STDIN=true
                USES_STDOUT=true
                ;;
            *.(xz|lzma))
                DECOMP_CMD="xz -d -c -"
                USES_STDIN=true
                USES_STDOUT=true
                ;;
            *)
                print "ERROR: '$ARCHIVE' has unrecognized archive type." >&2
                RC=$((RC+1))
                continue
                ;;
        esac

        if ! check_com ${DECOMP_CMD[(w)1]}; then
            echo "ERROR: ${DECOMP_CMD[(w)1]} not installed." >&2
            RC=$((RC+2))
            continue
        fi

        GZTARGET="${ARCHIVE:t:r}"
        if [[ -f $ARCHIVE ]] ; then

            print "Extracting '$ARCHIVE' ..."
            if $USES_STDIN; then
                if $USES_STDOUT; then
                    ${=DECOMP_CMD} < "$ARCHIVE" > $GZTARGET
                else
                    ${=DECOMP_CMD} < "$ARCHIVE"
                fi
            else
                if $USES_STDOUT; then
                    ${=DECOMP_CMD} "$ARCHIVE" > $GZTARGET
                else
                    ${=DECOMP_CMD} "$ARCHIVE"
                fi
            fi
            [[ $? -eq 0 && -n "$DELETE_ORIGINAL" ]] && rm -f "$ARCHIVE"

        elif [[ "$ARCHIVE" == (#s)(https|http|ftp)://* ]] ; then
            if check_com curl; then
                WGET_CMD="curl -k -s -o -"
            elif check_com wget; then
                WGET_CMD="wget -q -O - --no-check-certificate"
            else
                print "ERROR: neither wget nor curl is installed" >&2
                RC=$((RC+4))
                continue
            fi
            print "Downloading and Extracting '$ARCHIVE' ..."
            if $USES_STDIN; then
                if $USES_STDOUT; then
                    ${=WGET_CMD} "$ARCHIVE" | ${=DECOMP_CMD} > $GZTARGET
                    RC=$((RC+$?))
                else
                    ${=WGET_CMD} "$ARCHIVE" | ${=DECOMP_CMD}
                    RC=$((RC+$?))
                fi
            else
                if $USES_STDOUT; then
                    ${=DECOMP_CMD} =(${=WGET_CMD} "$ARCHIVE") > $GZTARGET
                else
                    ${=DECOMP_CMD} =(${=WGET_CMD} "$ARCHIVE")
                fi
            fi

        else
            print "ERROR: '$ARCHIVE' is neither a valid file nor a supported URI." >&2
            RC=$((RC+8))
        fi
    done
    return $RC
}

__archive_or_uri()
{
    _alternative \
        'files:Archives:_files -g "*.(#l)(tar.bz2|tbz2|tbz|tar.gz|tgz|tar.xz|txz|tar.lzma|tar|rar|lzh|7z|zip|jar|deb|bz2|gz|Z|xz|lzma)"' \
        '_urls:Remote Archives:_urls'
}

_simple_extract()
{
    _arguments \
        '-d[delete original archivefile after extraction]' \
        '*:Archive Or Uri:__archive_or_uri'
}
compdef _simple_extract unpack
alias unar=unpack

# Usage: smartcompress <file> (<type>)
#f5# Smart archive creator
pack() {
    emulate -L zsh
    if [[ -n $2 ]] ; then
        case $2 in
            tgz | tar.gz)   tar -zcvf$1.$2 $1 ;;
            tbz2 | tar.bz2) tar -jcvf$1.$2 $1 ;;
            tar.Z)          tar -Zcvf$1.$2 $1 ;;
            tar)            tar -cvf$1.$2  $1 ;;
            gz | gzip)      gzip           $1 ;;
            bz2 | bzip2)    bzip2          $1 ;;
            *)
                echo "Error: $2 is not a valid compression type"
                ;;
        esac
    else
        smartcompress $1 tar.gz
    fi
}

vman() {
# It's shameless stolen from <http://www.vim.org/tips/tip.php?tip_id=167>
#f5# Use \kbd{vim} as your manpage reader
    emulate -L zsh
    if (( ${#argv} == 0 )); then
        printf 'usage: vman <topic>\n'
        return 1
    fi
    man "$@" | col -b | vim -X -R -c 'set ft=man nomod nolist' -
}
compdef _man vman

limg() {
# list images only
    local -a images
    images=( *.{jpg,gif,png}(.N) )

    if [[ $#images -eq 0 ]] ; then
        print "No image files found"
    else
        ls "$images[@]"
    fi
}

lvid() {
# list video only
    local -a videos
    videos=( *.{mkv,mp4,avi}(.N) )

    if [[ $#videos -eq 0 ]] ; then
        print "No video files found"
    else
        ls "$videos[@]"
    fi
}

status() {
#f5# Show some status info
    print
    print "Date..: "$(date "+%Y-%m-%d %H:%M:%S")
    print "Shell.: Zsh $ZSH_VERSION (PID = $$, $SHLVL nests)"
    print "Term..: $TTY ($TERM), ${BAUD:+$BAUD bauds, }$COLUMNS x $LINES chars"
    print "Login.: $LOGNAME (UID = $EUID) on $HOST"
    print "System: $(uname)"
    print "Uptime:$(uptime)"
    print
}
# }}}

# Aliases {{{
alias chalice='vim -c Chalice'
alias pd=popd
alias cup="cpan-outdated && cpan-outdated | xargs cpanm -v"
#alias view="vim -X -R -"
alias scsh="rlwrap scsh"
alias goshrl="rlwrap -pBlue -b '(){}[],#;| ' gosh"
alias single="sudo shutdown now"
alias halt="sync;sync;sync;sudo shutdown -p now"
alias reboot="sync;sync;sync;sudo shutdown -r now"
alias sudo="sudo -E "
alias zln="noglob zmv -L -s -W"
alias zmv='noglob zmv -v -W'
alias mv='mv -iv'
alias cp='cp -iv'
alias rr='command rm -rfv'
if check_com -c cdf ; then
alias df='cdf -h'
fi
# listing stuff
alias dir="ls -lSrah"
alias lad='ls -d .*(/)'                # only show dot-directories
alias lsa='ls -a .*(.,@)'                # only show dot-files and symlinks
alias lss='ls -l *(s,S,t)'             # only files with setgid/setuid/sticky flag
alias lsl='ls -l *(@)'                 # only symlinks
alias lsx='ls -l *(*)'                 # only executables
alias lsw='ls -ld *(R,W,X.^ND/)'       # world-{readable,writable,executable} files
alias lsbig="ls -flh *(.OL[1,10])"     # display the biggest files
alias lsd='ls -d *(/)'                 # only show directories
alias lse='ls -d *(/^F)'               # only show empty directories
alias lsnew="ls -rtlh *(D.om[1,10])"   # display the newest files
alias lsold="ls -rtlh *(D.Om[1,10])"   # display the oldest files
alias lssmall="ls -Srl *(.oL[1,10])"   # display the smallest files
# chmod
alias rw-='chmod 600'
alias rwx='chmod 700'
alias r--='chmod 644'
alias r-x='chmod 755'
# some useful aliases
alias md='mkdir -p'
# network staff
alias starwars='telnet towel.blinkenlights.nl'
alias radio1='mplayer -playlist http://www.bbc.co.uk/radio/listen/live/r1.asx'
alias radio2='mplayer -playlist http://www.bbc.co.uk/radio/listen/live/r2.asx'
alias radio3='mplayer -playlist http://www.bbc.co.uk/radio/listen/live/r3.asx'
alias radio4='mplayer -playlist http://www.bbc.co.uk/radio/listen/live/r4.asx'
alias radio6='mplayer -playlist http://www.bbc.co.uk/radio/listen/live/r6.asx'
alias sumo='mplayer -playlist http://sumo.goo.ne.jp/hon_basho/torikumi/eizo_haishin/asx/sumolive.asx'
# suffix aliases
alias -s txt=cat
alias -s zip=zipinfo
alias -s {tgz,tbz}=gzcat
alias -s {gz,bz2}=tar -xzvf
alias -s {gif,jpg,jpeg,png}=xli
alias -s {m3u,mp3,flac}=audacious
alias -s {mp4,flv,mkv,mpg,mpeg,avi,mov}=mplayer
# }}}

# misc {{{

# set default browser
if [[ -z "$BROWSER" ]] ; then
    if [[ -n "$DISPLAY" ]] ; then
        #v# If X11 is running
        check_com -c firefox && export BROWSER=firefox
    else
        #v# If no X11 is running
        check_com -c w3m && export BROWSER=w3m
    fi
fi

xsource ~/perl5/perlbrew/etc/bashrc

xsource ~/.zsh/plugins/zaw/zaw.zsh

#[[ -s $home/.rvm/scripts/rvm ]] && source $home/.rvm/scripts/rvm

if [[ $TERM = cons25 && -e `which jfbterm` ]]; then
  jfbterm
fi

if check_com -c fortune; then
  if [ -f /usr/local/share/games/fortune/bible ]; then
    fortune /usr/local/share/games/fortune/bible
  else
    fortune
  fi
  echo "\n"
fi
# }}}

# Os detection {{{
case ${OSTYPE} in
  beos*|haiku*)
    path=( ~/config/bin \
      /boot/common/bin \
      /boot/apps \
      /boot/preferences \
      /boot/system/apps \
      /boot/system/preferences \
      /boot/develop/tools/gnupro/bin \
      ${path})
    alias la="ls -a"
    alias reboot="shutdown -r"
    alias halt="shutdown"
    chpwd_functions=(chpwd_ls dirs)
    chpwd_ls(){
      ls -F
    }
    TERMINFO=/boot/common/share/terminfo
    ;;
  solaris*)
    alias la="ls  -a"
    alias ll="ls  -hlA "
    alias ls="ls  -F"
    chpwd_functions=(chpwd_ls dirs)
    chpwd_ls() {
      ls -F
    }
    ;;
  darwin*)
    HOMEBREW_VERBOSE=true
    alias la="ls -G -a"
    alias ll="ls -G -hlA "
    alias ls="ls -G -F"
    alias mp2="/Applications/mplayer2.app/Contents/MacOS/mplayer-bin"
    chpwd_functions=(chpwd_ls dirs)
    chpwd_ls() {
      ls -G -F
    }
    squid_restart() {
      killall squid
      killall squid
      kill `cat ~/.squid/logs/squid.pid`
      kill `cat ~/.squid/logs/squid.pid`
      /bin/rm -rfv ~/.squid/cache/*
      squid -f ~/.squid/etc/squid.conf -z
      squid -f ~/.squid/etc/squid.conf
      mplayer() {
        if [ -e /Applications/mplayer2.app ]; then
          /Applications/mplayer2.app/Contents/MacOS/mplayer-bin $*
        else
          mplayer
        fi
      }
      export JAVA_HOME=~/Library/JAVA/JavaVirtualMachines/1.7.0.jdk/Contents/Home
    }
    ;;

  freebsd*)
    #http_proxy="http://192.168.1.3:3128"
    #ftp_proxy=""
    #FTP_TIMEOUT=30
    PACKAGESITE="ftp://ftp.jp.FreeBSD.org/pub/FreeBSD/ports/i386/packages/Latest/"
    alias la="ls -G -a"
    alias ll="ls -G -hlA "
    alias ls="ls -G -F"
    alias pup="sudo portsnap fetch update "
    alias pcheck="sudo portmaster -PBida && sudo portaudit -Fdav && sudo portmaster -y --clean-packages --clean-distfiles --check-depends "
    alias pfetch="sudo make  fetch-recursive"
    alias pinst=" HTTP_TIMEOUT=30 && sudo make  install distclean; rehash"
    alias pconf="sudo make config-recursive"
    alias pclean="sudo make  clean "
    alias pkg_add="pkg_add -v"
    alias pcreate="pkg_create -RJvnb"
    alias pcreateall="pkg_info -Ea |xargs -n 1 sudo pkg_create -Jnvb"
    alias fbgenmenu="fluxbox-generate_menu -g -k -ds -is"
    chpwd() {
      ls -G -F
    }
  beastie() {
print    "Shell.: Zsh $ZSH_VERSION (PID = $$, $SHLVL nests)"
print    "Term..: $TTY ($TERM), ${BAUD:+$BAUD bauds, }$COLUMNS x $LINES chars"
print    "Login.: $LOGNAME (UID = $EUID) on $HOST"
print    "System: $(uname)"
print    "Uptime:$(uptime)"                                           
print    "Date..: "$(date "+%Y-%m-%d %H:%M:%S")

    echo '
    
    
                \e[31m,        ,                              
               /(        )`                                   
               \ \___   / |                                   
               /- \e[37m_\e[31m  `-/  '\''                      
              (\e[37m/\/ \\\e[31m \   /\                       
              \e[37m/ /   |\e[31m `    \                      
              \e[34mO O   \e[37m) \e[31m/    |                
              \e[37m`-^--'\''\e[31m`<     '\''                      
             (_.)  _  )   /                                   
              `.___/`    /                                   
                `-----'\'' /                                     
   \e[33m<----.\e[31m     __ / __   \                         
   \e[33m<----|====\e[31mO)))\e[33m==\e[31m) \) /\e[33m====]  
   \e[33m<----'\''\e[31m    `--'\'' `.__,'\'' \                        
               |        |                                    
                \       /       /\                           
           \e[36m______\e[31m( (_  / \______/                
         \e[36m,'\''  ,-----'\''   |                               
         `--{__________)\e[37m                                 '



}

orb() {
  echo '
     \e[31m```                        \e[31;1m`\e[31m    
\e[31;1m    s` `.....---...\e[31;1m....--.```   -/\e[31m         
    +o   .--`         \e[31;1m/y:`      +.\e[31m         
     yo`:.            \e[31;1m:o      `+-\e[31m          
      y/               \e[31;1m-/`   -o/\e[31m           
     .-                  \e[31;1m::/sy+:.\e[31m          
\e[37m     /                     \e[31;1m`--  /\e[31m          
\e[37m    `\e[31m:                          \e[31;1m:`\e[31m         
\e[37m    `\e[31m:                          \e[31;1m:`\e[31m         
\e[37m     /                          \e[31;1m/\e[31m          
\e[37m     .\e[31m-                        \e[31;1m-.\e[31m          
      --                      \e[31;1m-.\e[31m           
       `:`                  \e[01;31m`:`                  
         \e[31;1m.--             \e[37m`-\e[33m-.                    
            .---...\e[33m...----                         '
}


;;
esac
#}}}

