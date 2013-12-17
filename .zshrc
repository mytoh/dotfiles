
# Options {{{
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
#setopt all_export
unsetopt bg_nice appendhistory beep nomatch
limit coredumpsize 0

umask 022
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
home=$HOME

#export UNAME_r=9.9-CURRENT

export LANG=fi_FI.UTF-8
# REPORTTIME=3

export FTP_PASSIVE_MODE=true
export G_FILENAME_ENCODING=@locale
export RLWRAP_HOME=~/.rlwrap
export LISTMAX=0
export WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'
if [[ -d $HOME/local/stow ]]; then
  export STOW=$HOME/local/stow
fi

# history
HISTFILE=~/.zsh-history
HISTSIZE=50000
SAVEHIST=$HISTSIZE

# vim
if check_com -c vim; then
  export EDITOR=vim
else
  export EDITOR=vi
fi

vim() {
  if [ -n $DISPLAY ]; then
    command vim $*
  else
    command vim -X $*
  fi
}
export MYVIMRC=~/.vimrc
#export VIMRUNTIME="~/.vim/vundle:"


# ls
export LSCOLORS=exFxCxdxBxegedabagacad
if check_com -c gdircolors ; then
  if [[ -e $home/.dir_colors ]]; then
  eval $(gdircolors $home/.dir_colors -b)
  export ZLS_COLORS=$LS_COLORS
else
  eval $(gdircolors)
  export ZLS_COLORS=$LS_COLORS
fi
fi

# less
if check_com -c vimpager; then
  export PAGER="vimpager"
  alias less="vimpager"
  alias more="vimpager"
else
export PAGER="less"
fi
export LESS='-i  -w -z-4 -g -M -X -F -R -P%t?f%f \
  :stdin .?pb%pb\%:?lbLine %lb:?bbByte %bb:-...'
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

# remove duplicates
typeset -U path cdpath  infopath
typeset -U  fpath 

# paths
path=(
~/local/bin(N-/)
~/local/*/{sbin,bin}(N-/)
/opt/X11/bin(N-/)
/usr/X11/bin(N-/)
/usr/games(N-/)
/usr/local/{sbin,bin}(N-/)
/usr/local/kde4/{sbin,bin}(N-/)
/usr/{sbin,bin}(N-/)
/{sbin,bin}(N-/))

if [ -d /usr/local/lib/cw ]; then
  path=( ~/.cw(N-/) $path )
fi
## zsh functions directory
fpath=(~/.zsh.d/functions/completion ${fpath})


unset INFOPATH
typeset -xT INFOPATH infopath
typeset -U infopath
infopath=(~/.info(N-/)
~/local/share/info(N-/)
/usr/local/*/info(N-/)
$infopath)

cdpath=(~/local ~/local/var)
# }}}

# named directories {{{
# $ cd ~dir
hash -d quatre=~/local/mnt/quatre
hash -d desk=~/local/mnt/deskstar
hash -d mypass=~/local/mnt/mypassport
hash -d git=~/local/git
hash -d ports=/usr/ports
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
zstyle ':completion:*' completer _oldlist _complete _match _ignored _approximate _prefix
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:default' menu select=2
# zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}'  '+m:[-._]=[-._] r:|[-._]=** r:|=*' '+l:|=*' '+m:{A-Z}={a-z}'
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'  '+m:[-._]=[-._] r:|[-._]=** r:|=*' '+l:|=*' '+m:{A-Z}={a-z}'
zstyle ':completion:*' format 'Completing %F{blue}%d%F{white}'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh.d/cache
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*:functions' ignore-patterns '_*'
# complete $cdpath directories when no candidates in local directory
zstyle ':completion:*:cd:*' tag-order local-directories path-directories
# }}}

# Prompts {{{

# git {{{
autoload -Uz add-zsh-hook
autoload -Uz vcs_info

zstyle ':vcs_info:*' enable git svn hg bzr
zstyle ':vcs_info:*' formats '(%s)-[%b]'
zstyle ':vcs_info:*' actionformats '(%s)-[%b|%a]'
zstyle ':vcs_info:(svn|bzr):*' branchformat '%b:r%r'
zstyle ':vcs_info:bzr:*' use-simple true

zstyle ':vcs_info:git:*' check_for-changes true
zstyle ':vcs_info:git:*' stagedstr "+"
zstyle ':vcs_info:git:*' unstagedstr "-"
zstyle ':vcs_info:git:*' formats '(%s)-[%b] %c%u'
zstyle ':vcs_info:git:*' actionformats '(%s)-[%b|%a] %c%u'

function _precmd_update_vcs_info_msg() {
  psvar=()
  LANG=en_US.UTF-8 vcs_info
  [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}
add-zsh-hook precmd _precmd_update_vcs_info_msg
# }}}

# prompt vi mode {{{
# http://chocokanpan.net/archives/224
accept_line() {
  VIMODE="ins"
  setup_vi_prompt
  builtin zle .accept-line
}
zle -N accept_line
bindkey -M vicmd "^M" accept_line

zle-keymap-select() {
  VIMODE="${${KEYMAP/vicmd/nor}/(main|viins)/ins}"
  _precmd_setup_vi_prompt
  zle reset-prompt
}
zle -N zle-keymap-select

# set vi prompt
_precmd_setup_vi_prompt(){
  if [ ! $VIMODE ]; then
    VIMODE="ins"
  fi
  if [ $VIMODE == "ins" ]; then
  viprompt="%F{238}(%{[38;5;67m%}${VIMODE}%F{238})"
else
  viprompt="%F{238}[%{[38;5;182m%}${VIMODE}%F{238}]"
  fi
  RPROMPT=$viprompt
}

# add-zsh-hook precmd _precmd_setup_vi_prompt
# }}}

setup_prompt(){ #{{{
  PROMPT=''
  if [[ -n $DISPLAY ]];then
    PROMPT+="%F{8}┌─%{$reset_color%}"
  else
    PROMPT+="%F{8}--%{$reset_color%}"
  fi
  # current directory
  PROMPT+="%F{8}(%F{blue}%(5~,%-2~/../%2~,%~)%F{8})%{$reset_color%}"
  # git status
  PROMPT+="%1(v|%F{8}─%F{green}%1v%f|)"
  # remote host
  [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] &&
    PROMPT+="%F{8}─(%{$fg[red]%}$(echo ${HOST%%.*} | tr '[a-z]' '[A-Z]')%F{8})"
  PROMPT+=$'\n'
  if [[ -n $DISPLAY ]];then
    PROMPT+="%F{8}└┈╸%F{100} "
  else
    PROMPT+="%F{8}->%{$reset_color%} "
  fi
  PROMPT2="%{$fg[cyan]%}%_%%%{$reset_color%} "
  SPROMPT="%{$fg[cyan]%}%r is correct? [n,y,a,e]:%{^[[m%} "
  if [[ $TERM != cons25 && $TERM != xterm ]]; then
    local muridana="%{$fg[cyan]%}(・x・) %{$reset_color%}"
    #RPROMPT=$muridana
  fi
}
# setup_prompt
PROMPT="$(gosh ~/.gosh/skripti/prompt.scm)"
#}}}

#unicode characters {{{
#
# ─ ━ │ ┃ ┄ ┅ ┆ ┇ ┈ ┉ ┊ ┋ ┌ ┍ ┎ ┏
#
# ▀ ▁ ▂ ▃ ▄ ▅ ▆ ▇ █ ▉ ▊ ▋ ▌ ▍ ▎ ▏
#
# ▐ ░ ▒ ▓ ▔▕ ▖ ▗ ▘ ▙ ▚ ▛ ▜ ▝ ▞ ▟
#
# ┐ ┑ ┒ ┓ └ ┕ ┖ ┗ ┘ ┙ ┚ ┛ ├ ┝ ┞ ┟ 
#
# ┠ ┡ ┢ ┣ ┤ ┥│┦│┧│┨│┩│┪│┫│┬│┭│┮│┯│
#
# ┰ ┱ ┲ ┳ ┴ ┵ ┶ ┷ ┸ ┹ ┺ ┻ ┼ ┽ ┾ ┿ 
#                           
# ╀ ╁ ╂ ╃ ╄ ╅ ╆ ╇ ╈ ╉ ╊ ╋ ╌ ╍ ╎ ╏
#                           
# ═ ║ ╒ ╓ ╔ ╕ ╖ ╗ ╘ ╙ ╚ ╛ ╜ ╝ ╞ ╟ 
#                           
# ╠ ╡ ╢ ╣ ╤ ╥ ╦ ╧ ╨ ╩ ╪ ╫ ╬ ╭ ╮ ╯ 
#
# ╰ ╱ ╲ ╳ ╴  ╵  ╶  ╷  ╸  ╹  ╺  ╻  ╼  ╽  ╾  ╿  
#
# }}}
#
# }}}

# bindkeys {{{
bindkey -v
# History search keymap {{{
autoload -Uz history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P"   history-beginning-search-backward-end
bindkey "^N"   history-beginning-search-forward-end
bindkey "^R"   history-incremental-pattern-search-backward
bindkey "^S"   history-incremental-pattern-search-forward
# }}}

# vi mode keys {{{
# -v -> viins
# -a -> vicmd
bindkey -v "^A" vi-beginning-of-line
bindkey -v "^B" vi-backward-char
bindkey -v "^E" vi-end-of-line
bindkey -v "^F" vi-forward-char
bindkey -v "^K" vi-kill-eol
bindkey -v "^H" backward-delete-char # changing default
#}}}
# }}}

# Functions {{{

# _preexec_update_title {{{
if [[ "$TERM" == screen* ]]; then
  add-zsh-hook preexec _preexec_update_title
  _preexec_update_title() {
    # see [zsh-workers:13180]
    # http://www.zsh.org/mla/workers/2000/msg03993.html
    emulate -L zsh
    local -a cmd; cmd=(${(z)2})
    case $cmd[1] in
      fg)
        if (( $#cmd == 1 )); then
          cmd=(builtin jobs -l %+)
        else
          cmd=(builtin jobs -l $cmd[2])
        fi
        ;;
      %*)
        cmd=(builtin jobs -l $cmd[1])
        ;;
      cd)
        if (( $#cmd == 2)); then
          cmd[1]=$cmd[2]
        fi
        ;;
      sudo)
          cmd[1]=$cmd[2]
        ;;
      *)
        echo -n "k$cmd[1]:t\\"
        return
        ;;
    esac

    local -A jt; jt=(${(kv)jobtexts})

    $cmd >>(read num rest
    cmd=(${(z)${(e):-\$jt$num}})
    echo -n "k$cmd[1]:t\\") 2>/dev/null
  }
fi
#}}}

_chpwd_title() { printf "_`echo $PWD|awk '{print $1;exit}'`\\" }
_chpwd_ls(){
  emulate -L zsh
  ls -F
}

add-zsh-hook chpwd _chpwd_title
add-zsh-hook chpwd _chpwd_ls

_precmd_rehash(){
  rehash
}
add-zsh-hook precmd _precmd_rehash

tm() {
    tmux attach
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

#cd() {
## smart cd function, allows switching to /etc when running 'cd /etc/fstab'
    #if (( ${#argv} == 1 )) && [[ -f $<1:> ]]; then
        #[[ ! -e ${1:h} ]] && return 1
        #print "Correcting ${1} to ${1:h}"
        #builtin cd ${1:h}
    #else
        #builtin cd "$@"
    #fi
#}

unpack() { # {{{
# Usage: unpack <file>
# Using option -d deletes the original archive file.
#f5# Smart archive extractor
    emulate -L zsh
    setopt extended_glob noclobber
    local DELETE_ORIGINAL DECOMP_CMD USES_STDIN USES_STDOUT GZTARGET WGET_CMD
    local RC=0
    usage() {
      print "Usage: unpack <file>"
    }
    if [[ ${#argv} == 0 ]]; then
      usage
      fi
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
                DECOMP_CMD="unrar x -ad"
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
# }}}

__archive_or_uri()
{
    _alternative \
        'files:Archives:_files -g "*.(#l)(tar.bz2|tbz2|tbz|tar.gz|tgz|tar.xz|txz|tar.lzma|tar|rar|lzh|7z|zip|jar|deb|bz2|gz|Z|xz|lzma)"' \
        '_urls:Remote Archives:_urls'
}

_unpack()
{
    _arguments \
        '-d[delete original archivefile after extraction]' \
        '*:Archive Or Uri:__archive_or_uri'
}
compdef _unpack unpack

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
        pack $1 tar.xz
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
    man "$@" | col -b | vim -X -R -c "set ft=man nomod nolist" -
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

ggr()  {
# Search Google
    emulate -L zsh
    ${=BROWSER} "http://www.google.com/search?&num=100&q=$*"
}

cfg() {
  case $1 in
     rc) $EDITOR /etc/rc.conf.local ;;
 loader) $EDITOR /boot/loader.conf.local ;;
    zsh) $EDITOR $HOME/.zshrc ;;
      *) $EDITOR $*
  esac
}

trl() { aria2c -S "$@" |grep "./" }


4ch() {
  w3m http://boards.4chan.org/$1/
}

v2jp() {
  mkdir -p tmp
  ffmpeg -i $1 -t $2 -ss 00:00:00:00 ./tmp/vid-%d.jpg
}

aaa() {
  for f in ./*.jpg 
  do
    jp2a --colors $f
    tput cup 0 0
    #sleep 0.001
  done
  echo -ne '[55E'
}

exif-remove(){
  mogrify -strip -verbose $*
}

# color functions {{{
# functions from
# http://crunchbanglinux.org/forums/post/126921/#p126921

colorspacman() #{{{
{
# ANSI Color -- use these variables to easily have different color
#    and format output. Make sure to output the reset sequence after
#    colors (f = foreground, b = background), and use the 'off'
#    feature for anything you turn on.

initializeANSI()
{
 esc=""

  blackf="${esc}[30m";   redf="${esc}[31m";    greenf="${esc}[32m"
  yellowf="${esc}[33m"   bluef="${esc}[34m";   purplef="${esc}[35m"
  cyanf="${esc}[36m";    whitef="${esc}[37m"

  blackb="${esc}[40m";   redb="${esc}[41m";    greenb="${esc}[42m"
  yellowb="${esc}[43m"   blueb="${esc}[44m";   purpleb="${esc}[45m"
  cyanb="${esc}[46m";    whiteb="${esc}[47m"

  boldon="${esc}[1m";    boldoff="${esc}[22m"
  italicson="${esc}[3m"; italicsoff="${esc}[23m"
  ulon="${esc}[4m";      uloff="${esc}[24m"
  invon="${esc}[7m";     invoff="${esc}[27m"

  reset="${esc}[0m"
}

# note in this first use that switching colors doesn't require a reset
# first - the new color overrides the old one.

clear

initializeANSI

cat << EOF

 ${yellowf}  ▄███████▄${reset}   ${redf}  ▄██████▄${reset}    ${greenf}  ▄██████▄${reset}    ${bluef}  ▄██████▄${reset}    ${purplef}  ▄██████▄${reset}    ${cyanf}  ▄██████▄${reset}
 ${yellowf}▄█████████▀▀${reset}  ${redf}▄${whitef}█▀█${redf}██${whitef}█▀█${redf}██▄${reset}  ${greenf}▄${whitef}█▀█${greenf}██${whitef}█▀█${greenf}██▄${reset}  ${bluef}▄${whitef}█▀█${bluef}██${whitef}█▀█${bluef}██▄${reset}  ${purplef}▄${whitef}█▀█${purplef}██${whitef}█▀█${purplef}██▄${reset}  ${cyanf}▄${whitef}█▀█${cyanf}██${whitef}█▀█${cyanf}██▄${reset}
 ${yellowf}███████▀${reset}      ${redf}█${whitef}▄▄█${redf}██${whitef}▄▄█${redf}███${reset}  ${greenf}█${whitef}▄▄█${greenf}██${whitef}▄▄█${greenf}███${reset}  ${bluef}█${whitef}▄▄█${bluef}██${whitef}▄▄█${bluef}███${reset}  ${purplef}█${whitef}▄▄█${purplef}██${whitef}▄▄█${purplef}███${reset}  ${cyanf}█${whitef}▄▄█${cyanf}██${whitef}▄▄█${cyanf}███${reset}
 ${yellowf}███████▄${reset}      ${redf}████████████${reset}  ${greenf}████████████${reset}  ${bluef}████████████${reset}  ${purplef}████████████${reset}  ${cyanf}████████████${reset}
 ${yellowf}▀█████████▄▄${reset}  ${redf}██▀██▀▀██▀██${reset}  ${greenf}██▀██▀▀██▀██${reset}  ${bluef}██▀██▀▀██▀██${reset}  ${purplef}██▀██▀▀██▀██${reset}  ${cyanf}██▀██▀▀██▀██${reset}
 ${yellowf}  ▀███████▀${reset}   ${redf}▀   ▀  ▀   ▀${reset}  ${greenf}▀   ▀  ▀   ▀${reset}  ${bluef}▀   ▀  ▀   ▀${reset}  ${purplef}▀   ▀  ▀   ▀${reset}  ${cyanf}▀   ▀  ▀   ▀${reset}

 ${boldon}${yellowf}  ▄███████▄   ${redf}  ▄██████▄    ${greenf}  ▄██████▄    ${bluef}  ▄██████▄    ${purplef}  ▄██████▄    ${cyanf}  ▄██████▄${reset}
 ${boldon}${yellowf}▄█████████▀▀  ${redf}▄${whitef}█▀█${redf}██${whitef}█▀█${redf}██▄  ${greenf}▄${whitef}█▀█${greenf}██${whitef}█▀█${greenf}██▄  ${bluef}▄${whitef}█▀█${bluef}██${whitef}█▀█${bluef}██▄  ${purplef}▄${whitef}█▀█${purplef}██${whitef}█▀█${purplef}██▄  ${cyanf}▄${whitef}█▀█${cyanf}██${whitef}█▀█${cyanf}██▄${reset}
 ${boldon}${yellowf}███████▀      ${redf}█${whitef}▄▄█${redf}██${whitef}▄▄█${redf}███  ${greenf}█${whitef}▄▄█${greenf}██${whitef}▄▄█${greenf}███  ${bluef}█${whitef}▄▄█${bluef}██${whitef}▄▄█${bluef}███  ${purplef}█${whitef}▄▄█${purplef}██${whitef}▄▄█${purplef}███  ${cyanf}█${whitef}▄▄█${cyanf}██${whitef}▄▄█${cyanf}███${reset}
 ${boldon}${yellowf}███████▄      ${redf}████████████  ${greenf}████████████  ${bluef}████████████  ${purplef}████████████  ${cyanf}████████████${reset}
 ${boldon}${yellowf}▀█████████▄▄  ${redf}██▀██▀▀██▀██  ${greenf}██▀██▀▀██▀██  ${bluef}██▀██▀▀██▀██  ${purplef}██▀██▀▀██▀██  ${cyanf}██▀██▀▀██▀██${reset}
 ${boldon}${yellowf}  ▀███████▀   ${redf}▀   ▀  ▀   ▀  ${greenf}▀   ▀  ▀   ▀  ${bluef}▀   ▀  ▀   ▀  ${purplef}▀   ▀  ▀   ▀  ${cyanf}▀   ▀  ▀   ▀${reset}

EOF
}
#}}}

colorsinvader(){ #{{{
# ANSI Color -- use these variables to easily have different color
#    and format output. Make sure to output the reset sequence after
#    colors (f = foreground, b = background), and use the 'off'
#    feature for anything you turn on.

initializeANSI()
{
  esc=""

  blackf="${esc}[30m";   redf="${esc}[31m";    greenf="${esc}[32m"
  yellowf="${esc}[33m"   bluef="${esc}[34m";   purplef="${esc}[35m"
  cyanf="${esc}[36m";    whitef="${esc}[37m"

  blackb="${esc}[40m";   redb="${esc}[41m";    greenb="${esc}[42m"
  yellowb="${esc}[43m"   blueb="${esc}[44m";   purpleb="${esc}[45m"
  cyanb="${esc}[46m";    whiteb="${esc}[47m"

  boldon="${esc}[1m";    boldoff="${esc}[22m"
  italicson="${esc}[3m"; italicsoff="${esc}[23m"
  ulon="${esc}[4m";      uloff="${esc}[24m"
  invon="${esc}[7m";     invoff="${esc}[27m"

  reset="${esc}[0m"
}

# note in this first use that switching colors doesn't require a reset
# first - the new color overrides the old one.

initializeANSI

cat << EOF

   ${boldon}${redf}▀▄   ▄▀  ${reset}    ${boldon}${greenf}▄▄▄████▄▄▄ ${reset}   ${boldon}${yellowf}  ▄██▄  ${reset}     ${boldon}${bluef}▀▄   ▄▀  ${reset}    ${boldon}${purplef}▄▄▄████▄▄▄ ${reset}   ${boldon}${cyanf}  ▄██▄  ${reset}
  ${boldon}${redf}▄█▀███▀█▄ ${reset}   ${boldon}${greenf}███▀▀██▀▀███${reset}   ${boldon}${yellowf}▄█▀██▀█▄${reset}    ${boldon}${bluef}▄█▀███▀█▄ ${reset}   ${boldon}${purplef}███▀▀██▀▀███${reset}   ${boldon}${cyanf}▄█▀██▀█▄${reset}
 ${boldon}${redf}█▀███████▀█${reset}   ${boldon}${greenf}▀▀▀██▀▀██▀▀▀${reset}   ${boldon}${yellowf}▀▀█▀▀█▀▀${reset}   ${boldon}${bluef}█▀███████▀█${reset}   ${boldon}${purplef}▀▀▀██▀▀██▀▀▀${reset}   ${boldon}${cyanf}▀▀█▀▀█▀▀${reset}
 ${boldon}${redf}▀ ▀▄▄ ▄▄▀ ▀${reset}   ${boldon}${greenf}▄▄▀▀ ▀▀ ▀▀▄▄${reset}   ${boldon}${yellowf}▄▀▄▀▀▄▀▄${reset}   ${boldon}${bluef}▀ ▀▄▄ ▄▄▀ ▀${reset}   ${boldon}${purplef}▄▄▀▀ ▀▀ ▀▀▄▄${reset}   ${boldon}${cyanf}▄▀▄▀▀▄▀▄${reset}

   ${redf}▀▄   ▄▀  ${reset}    ${greenf}▄▄▄████▄▄▄ ${reset}   ${yellowf}  ▄██▄  ${reset}     ${bluef}▀▄   ▄▀  ${reset}    ${purplef}▄▄▄████▄▄▄ ${reset}   ${cyanf}  ▄██▄  ${reset}
  ${redf}▄█▀███▀█▄ ${reset}   ${greenf}███▀▀██▀▀███${reset}   ${yellowf}▄█▀██▀█▄${reset}    ${bluef}▄█▀███▀█▄ ${reset}   ${purplef}███▀▀██▀▀███${reset}   ${cyanf}▄█▀██▀█▄${reset}
 ${redf}█▀███████▀█${reset}   ${greenf}▀▀▀██▀▀██▀▀▀${reset}   ${yellowf}▀▀█▀▀█▀▀${reset}   ${bluef}█▀███████▀█${reset}   ${purplef}▀▀▀██▀▀██▀▀▀${reset}   ${cyanf}▀▀█▀▀█▀▀${reset}
 ${redf}▀ ▀▄▄ ▄▄▀ ▀${reset}   ${greenf}▄▄▀▀ ▀▀ ▀▀▄▄${reset}   ${yellowf}▄▀▄▀▀▄▀▄${reset}   ${bluef}▀ ▀▄▄ ▄▄▀ ▀${reset}   ${purplef}▄▄▀▀ ▀▀ ▀▀▄▄${reset}   ${cyanf}▄▀▄▀▀▄▀▄${reset}


                                     ${whitef}▌${reset}

                                   ${whitef}▌${reset}
                                   ${whitef}${reset}
                                  ${whitef}▄█▄${reset}
                              ${whitef}▄█████████▄${reset}
                              ${whitef}▀▀▀▀▀▀▀▀▀▀▀${reset}

EOF
} #}}}

dump-colours(){ #{{{
  if [[ -n $1 ]]; then
    xdef="$HOME/.xcolours/$1"
  else
    if [[ -f $HOME/.Xresources ]]; then
      xdef="$HOME/.Xresources"
    else
      xdef="$HOME/.Xdefaults"
    fi
  fi
  colors=( $( sed -re '/^!/d; /^$/d; /^#/d; s/(\*color)([0-9]):/\10\2:/g;' $xdef | grep 'color[01][0-9]:' | sort |sed 's/^.*: *//g' ) )
  echo -e "\e[37m
  Black   Red      Green   Yellow    Blue    Magenta   Cyan    White
  -------------------------------------------------------------------\e[0m"
  for i in {0..7}; echo -en "\e[$((30+$i))m $colors[i+1] \e[0m"
    echo
    for i in {8..15}; echo -en "\e[1;$((22+$i))m $colors[i+1] \e[0m"
      echo -e "\n"
}
#}}}

color-blocks () { #{{{
    echo
    local width=$(( ($COLUMNS / 16) -1 ))
    local chars
    local pre=$(( ( $COLUMNS - ($width+1)*16)/2 ))
    for ((i=0; i<$width; i++)); chars+="░"
    for ((i=0; i<$pre; i++)); echo -n " "
    for ((i=0; i<=7; i++)); echo -en "\e[3${i}m${chars} \e[1;3${i}m${chars}\e[m "; echo; echo
    unset i
}
#}}}

color-numbers() #{{{
{
 for i in {000..255..16}; do 
   for j in {$i..$((i+15))}; do 
     echo -en "\e[38;5;${j}m $j \e[0m"; 
   done; 
   echo; 
 done
 }
#}}}

colorguns()  #{{{
{
#
# ANSI color scheme script by pfh
#
# Initializing mod by lolilolicon from Archlinux
#
# this is modified version
for i in {1..6}; do
  eval f$i=$(echo -en "\e[3${i}m")
done
bld=$'\e[1m'
rst=$'\e[0m'
inv=$'\e[7m'
cat << EOF

$f1  ▀▄▄███ ██████   $f2 ▀▄▄███████████  $f3 ▀▄▄███████████  $f4 ▀▄▄███████████  $f5 ▀▄▄███████████  $f6 ▀▄▄███████████
$f1  ▄███▀█▀▀▀        $f2 ▄███▀█▀▀▀       $f3 ▄███▀█▀▀▀       $f4 ▄███▀█▀▀▀       $f5 ▄███▀█▀▀▀       $f6 ▄███▀█▀▀▀
$f1 ▐███▄▀            $f2▐███▄▀           $f3▐███▄▀           $f4▐███▄▀           $f5▐███▄▀           $f6▐███▄▀
$f1 ▐███              $f2▐███             $f3▐███             $f4▐███             $f5▐███             $f6▐███
$f1  ▀▀▀              $f2 ▀▀▀             $f3 ▀▀▀             $f4 ▀▀▀             $f5 ▀▀▀             $f6 ▀▀▀
$bld
$f1   ▀▄▄███████████  $f2 ▀▄▄███████████  $f3 ▀▄▄███████████  $f4 ▀▄▄███████████  $f5 ▀▄▄███████████  $f6 ▀▄▄███████████
$f1  ▄███▀█▀▀▀        $f2 ▄███▀█▀▀▀       $f3 ▄███▀█▀▀▀       $f4 ▄███▀█▀▀▀       $f5 ▄███▀█▀▀▀       $f6 ▄███▀█▀▀▀
$f1 ▐███▄▀            $f2▐███▄▀           $f3▐███▄▀           $f4▐███▄▀           $f5▐███▄▀           $f6▐███▄▀
$f1 ▐███              $f2▐███             $f3▐███             $f4▐███             $f5▐███             $f6▐███
$f1  ▀▀▀              $f2 ▀▀▀             $f3 ▀▀▀             $f4 ▀▀▀             $f5 ▀▀▀             $f6 ▀▀▀
$rst
EOF
} #}}}

colorm1934() { #{{{
cat << EOF
'
           ,____________                  __.
          /  ||||||     ^----------------~  ||
      (~)/___LLLLLL_____________________|-==||
        /   ,------,  ()                |___|
       <,  /      //  ,-,------/'~~~~~~~
         )/      //  /(/     \(
        //      //   | \\\\    /
       //()    //.-=----'==-'
      //  :po ///
     //      ///
    ( '------'/
    "~~~~~~~\(
             '
'
EOF
} #}}}

function banner() {
    echo
    echo "[0;1;35;95m╺━[0;1;31;91m┓┏[0;1;33;93m━┓[0;1;32;92m╻[0m [0;1;36;96m╻[0m   [0;1;35;95m╺┳[0;1;31;91m╸╻[0m [0;1;33;93m╻[0;1;32;92m┏━[0;1;36;96m╸┏[0;1;34;94m┳┓[0;1;35;95m┏━[0;1;31;91m╸[0m   [0;1;32;92m┏━[0;1;36;96m╸╻[0m [0;1;34;94m╻[0;1;35;95m┏━[0;1;31;91m┓┏[0;1;33;93m━┓[0;1;32;92m┏━[0;1;36;96m┓┏[0;1;34;94m━╸[0;1;35;95m┏━[0;1;31;91m┓[0m"
    echo "[0;1;31;91m┏━[0;1;33;93m┛┗[0;1;32;92m━┓[0;1;36;96m┣━[0;1;34;94m┫[0m    [0;1;31;91m┃[0m [0;1;33;93m┣[0;1;32;92m━┫[0;1;36;96m┣╸[0m [0;1;34;94m┃[0;1;35;95m┃┃[0;1;31;91m┣╸[0m    [0;1;36;96m┃[0m  [0;1;34;94m┣[0;1;35;95m━┫[0;1;31;91m┃[0m [0;1;33;93m┃┃[0m [0;1;32;92m┃[0;1;36;96m┗━[0;1;34;94m┓┣[0;1;35;95m╸[0m [0;1;31;91m┣┳[0;1;33;93m┛[0m"
    echo "[0;1;33;93m┗━[0;1;32;92m╸┗[0;1;36;96m━┛[0;1;34;94m╹[0m [0;1;35;95m╹[0m    [0;1;33;93m╹[0m [0;1;32;92m╹[0m [0;1;36;96m╹[0;1;34;94m┗━[0;1;35;95m╸╹[0m [0;1;31;91m╹[0;1;33;93m┗━[0;1;32;92m╸[0m   [0;1;34;94m┗━[0;1;35;95m╸╹[0m [0;1;31;91m╹[0;1;33;93m┗━[0;1;32;92m┛┗[0;1;36;96m━┛[0;1;34;94m┗━[0;1;35;95m┛┗[0;1;31;91m━╸[0;1;33;93m╹┗[0;1;32;92m╸[0m"
    echo
}

#}}}

s() {
  case $1 in
    g|gauche|gosh)
      print "gauche"
      if [[ -e $home/.goshrc ]]; then
      rlwrap -pBlue -b '(){}[].,#@;|' -c gosh -l $home/.goshrc 
      else
      rlwrap -pBlue -b '(){}[],#;| ' -c gosh 
    fi

      ;;
    sc|scsh)
      print "scsh"
      rlwrap -pBlue -b '(){}[],#;| ' -c scsh   
      ;;
    s4|scheme48)
      print "scheme48"
      rlwrap -pBlue -b '(){}[],#;| ' -c scheme48
      ;;
    e|elk)
      print "elk"
      rlwrap -pBlue -b '(){}[],#;| ' -c elk 
      ;;
    *)
      print "  g  gauche"
      print "  sc scsh"
      print "  s4 scheme48"
      print "  e elk"
      ;;
  esac
}


#}}}

# Aliases {{{
alias chalice='vim -c Chalice'
alias pd=popd
alias cup="cpan-outdated && cpan-outdated | xargs cpanm -v"
#alias view="vim -X -R -"
alias single="sudo shutdown now"
alias halt="sync;sync;sync;sudo shutdown -p now"
alias reboot="sync;sync;sync;sudo shutdown -r now"
alias sudo="sudo -E "
alias zln="noglob zmv -L -s -W"
alias zmv='noglob zmv -v -W'
alias cp='cp -iv'
alias rr='command rm -rfv'
if check_com -c cdf ; then
alias df='cdf -h'
fi
alias uzbl='uzbl-tabbed'
alias unar=unpack
alias vba="VisualBoyAdvance"
alias mcomix="~/local/git/mcomix/mcomix/mcomixstarter.py"
alias md='mkdir -p'
alias xfont="xlsatoms | grep '-'"
if check_com -c hub; then
  eval $(hub alias -s zsh)
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
# network staff
alias starwars='telnet towel.blinkenlights.nl'
alias radio1='mplayer -playlist http://www.bbc.co.uk/radio/listen/live/r1.asx'
alias radio2='mplayer -playlist http://www.bbc.co.uk/radio/listen/live/r2.asx'
alias radio3='mplayer -playlist http://www.bbc.co.uk/radio/listen/live/r3.asx'
alias radio4='mplayer -playlist http://www.bbc.co.uk/radio/listen/live/r4.asx'
alias radio6='mplayer -playlist http://www.bbc.co.uk/radio/listen/live/r6.asx'
alias sumo='mplayer -playlist http://sumo.goo.ne.jp/hon_basho/torikumi/eizo_haishin/asx/sumolive.asx'
alias jblive='mplayer rtsp://videocdn-us.geocdn.scaleengine.net/jblive/jblive.stream'
alias destep="figlet -w 80 -nkf rowancap DESTEP TRED | tr 'd' '▟' | tr 'P' '▛' | tr 'M' '█' | tr 'V' '▜' | tr '\"' ' ' | tr '.' ' ' | tr 'a' '▟' | tr 'b' '▙' | tr 'K' '█' | tr 'A' '▟' | tr 'F' '▛' | tr 'Y' '▜' | tr 'v' '█' | tr 'm' '█' | tr 'r' '▛' | toilet -w 80 --gay -f term"

# gauche
  xsource ~/.zsh.d/gauche.zsh
# suffix aliases
alias -s txt=cat
alias -s {zip,rar,tgb,tgz,tar,xz,gz,bz2}=unpack
alias -s {gif,jpg,jpeg,png}=xli
alias -s {m3u,mp3,flac}=audacious
alias -s {mp4,flv,mkv,mpg,mpeg,avi,mov}=mplayer

# global aliases
alias -g ND='*(/om[1])'
alias -g NF='*(.om[1])'
# cd upper directory or mv file .../.
alias '..'='cd ..'
alias -g '...'='../..'
alias -g '....'='../../..'
alias -g '....'='../../../..'
# }}}

# plugins {{{
_set-zsh-plugins() {
  emulate -L zsh
  ZSH="$HOME/.zsh.d"
  ZSH_PLUGINS="$ZSH/plugins"
  plugins=(zsh-syntax-highlighting)
  for plugin ($plugins); do
    xsource $ZSH_PLUGINS/$plugin/$plugin.plugin.zsh
  done
  xsource $ZSH_PLUGINS/zsh-syntax-highlighting-filetypes/zsh-syntax-highlighting-filetypes.zsh
  xsource $ZSH_PLUGINS/z/z.sh
  if [[ -e $ZSH_PLUGINS/z ]]; then
    _precmd_z() {
      _z --add "$(pwd -P)"
    }
    add-zsh-hook precmd _precmd_z
  fi
  if [[ -e $ZSH_PLUGINS/zsh-completions ]]; then
    fpath=($ZSH_PLUGINS/zsh-completions $fpath)
  fi

  # auto-fu.zsh
  _auto-fu-set-up(){
    if [[ ! -e $ZSH_PLUGINS/auto-fu.zsh/auto-fu.zwc ]]; then
      A=$ZSH_PLUGINS/auto-fu.zsh/auto-fu.zsh
      (zsh -c "source $A; auto-fu-zcompile $A $ZSH_PLUGINS/auto-fu.zsh")
    fi
    source $ZSH_PLUGINS/auto-fu.zsh/auto-fu; auto-fu-install
    zstyle ':auto-fu:highlight' input bold
    zstyle ':auto-fu:highlight' completion fg=black,bold
    zstyle ':auto-fu:highlight' completion/one fg=white,bold,underline
    zstyle ':auto-fu:var' track-keymap-skip opp
    #zstyle ':auto-fu:var' disable magic-space
    zle-line-init () {auto-fu-init;}; zle -N zle-line-init
      zle -N zle-keymap-select auto-fu-zle-keymap-select
    }
    # if [[ -e $ZSH_PLUGINS/auto-fu.zsh ]]; then
    #   _auto-fu-set-up
    # fi
  }
_set-zsh-plugins
# }}}

# misc {{{

# set default browser
if [[ -z "$BROWSER" ]] ; then
        check_com -c w3m && export BROWSER=w3m
fi

xsource ~/perl5/perlbrew/etc/bashrc

if check_com fasd ;then
eval "$(fasd --init auto)"
fi


#[[ -s $home/.rvm/scripts/rvm ]] && source $home/.rvm/scripts/rvm

if [[ $TERM = cons25 && -e `which jfbterm` ]]; then
  jfbterm
fi

if [[ -n $DISPLAY ]];then
  if [[ -e ~/.fonts ]]; then
    for d in ~/.fonts/*(/); do
      if [[ -e $d/fonts.dir ]]; then
      xset +fp $d
    fi
      xset fp rehash
    done
  fi
fi

#if check_com -c fortune; then
  #if [ -f /usr/local/share/games/fortune/bible ]; then
    #fortune /usr/local/share/games/fortune/bible
  #else
    #fortune
  #fi
  #echo "\n"
#fi
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
    TERMINFO=/boot/common/share/terminfo
    ;;
  solaris*)
    alias la="ls  -a"
    alias ll="ls  -hlA "
    alias ls="ls  -F"
    ;;
  darwin*)
    # manpath
  typeset -U manpath
  MANPATH="`manpath`"
  manpath=(
  ~/local/*/man(N-/)
  ~/local/*/share/man(N-/)
  /usr/local/man(N-/)
  /usr/local/*/man(N-/)
  /usr/share/man(N-/)
  $manpath)
  export MANPATH

    alias mp2="/Applications/mplayer2.app/Contents/MacOS/mplayer-bin"
    alias bsearch="brew search "
    alias binst="brew install -v"
    squid_restart() {
      killall squid
      killall squid
      kill $(cat ~/.squid/logs/squid.pid)
      kill $(cat ~/.squid/logs/squid.pid)
      /bin/rm -rfv ~/.squid/cache/*
      squid -f ~/.squid/etc/squid.conf -z
      squid -f ~/.squid/etc/squid.conf
    }
    export HOMEBREW_VERBOSE
    export JAVA_HOME=~/Library/JAVA/JavaVirtualMachines/1.7.0.jdk/Contents/Home
     xsource `brew --prefix`/etc/autojump
     xsource `brew --prefix`/etc/bash_completion.d/git-completion.bash
    ;;

  linux*)
    export LANG=en_US.UTF-8
    if check_com -c ls++; then
      alias ls='ls++'
    fi
   alias pacman='sudo clyde'
    alias halt='sudo shutdown -P -h now'
   ;;

  freebsd*)
    #http_proxy="http://192.168.1.3:3128"
    #ftp_proxy=""
    #FTP_TIMEOUT=30
    PACKAGESITE="ftp://ftp.jp.FreeBSD.org/pub/FreeBSD/ports/i386/packages/Latest/"
    alias pup="sudo portsnap fetch update "
    alias pcheck='sudo portmaster -PBidav && sudo portaudit -Fdav && sudo portmaster -y --clean-packages --clean-distfiles --check-depends'
    alias pfetch="sudo make  fetch-recursive"
    alias pinst="sudo make  install distclean; rehash"
    alias pconf="sudo make config-recursive"
    alias pclean="sudo make  clean "
    alias pkg_add="pkg_add -v"
    alias pcreate="pkg_create -RJvnb"
    alias pcreateall="pkg_info -Ea |xargs -n 1 sudo pkg_create -Jnvb"
    alias fbgenmenu="fluxbox-generate_menu -g -k -ds -is"
    fbgenmmaker() {
      mmaker -f fluxbox
      echo "[include] (~/.fluxbox/usermenu)" >> ~/.fluxbox/menu 
    }
  beastie() {
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

# vim:foldmethod=marker

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
