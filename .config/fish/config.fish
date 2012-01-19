# environment {{{
if status --is-login
  for i in ~/local/bin ~/local/sbin ~/local/homebrew/bin ~/local/homebrew/sbin
    if test -d $i
      if not contains $i $PATH
        set -x PATH $i $PATH
      end
    end
  end
end

set -x MANWIDTH 80
set -x GAUCHE_LOAD_PATH "$HOME/.gosh"
set -x DYLD_FALLBACK_LIBRARY_PATH $DYLD_FALLBACK_LIBRARY_PATH "$HOME/local/lib:$HOME/local/homebrew/lib"
if test -d $HOME/local/stow
  set -x STOW $HOME/local/stow
end

# pager
set -x LESS "-i  -w -z-4 -g -M -X -F -R -P%t?f%f :stdin .?pb%pb\%:?lbLine %lb:?bbByte %bb:-..."

set -x LESS_TERMCAP_md "[01;31m"
set -x LESS_TERMCAP_me "[0m"
set -x LESS_TERMCAP_se "[0m"
set -x LESS_TERMCAP_so "[01;44;33m"
set -x LESS_TERMCAP_ue "[0m"
set -x LESS_TERMCAP_us "[01;32m"
# set default browser
if which w3m > /dev/null
  set -x BROWSER w3m
end
#}}}


# complete {{{
function __gosh_completion
set -l load_path (echo $GAUCHE_LOAD_PATH | tr ':' '\n')
for i in $load_path
  for j in  $i/*.scm
    echo $j
    end
  end
end
complete -c gosh -f -a "(__gosh_completion)"
#}}}

# fish variables {{{
set fish_greeting ""
#}}}
set open_paren "[30m([0m"
set close_paren "[30m)[0m"

# prompt {{{
#  arch wiki git status prompt {{{
set fish_git_dirty_color red
function parse_git_dirty
  git diff --quiet HEAD 2>&-
  if test $status = 1
    echo (set_color $fish_git_dirty_color)"÷"(set_color normal)
  end
end

function parse_git_branch
  # git branch outputs lines, the current branch is prefixed with a *
  set -l branch (git branch --color ^&- | awk '/*/ {print $2}')
  echo $branch (parse_git_dirty)
end

function git_prompt
  if test -z (git branch --quiet 2>| awk '/fatal:/ {print "no git"}')
    printf '%s%s%s%s%s' "[30m─" $open_paren (parse_git_branch) (set_color $fish_color_normal) $close_paren
  else
    echo ""
  end
end
#}}}

function current-directory
  printf '%s%s%s%s%s' $open_paren (set_color $fish_color_cwd) (prompt_pwd) (set_color $fish_color_normal) $close_paren
end

function prompt-up-right
  printf '%s%s' "[30m┌─[0m"
end

function prompt-down-right
  printf '%s%s' "[30m└┈╸[0m"
end

function fish_prompt -d "fish prompt function"
  printf '%s%s%s%s\n%s ' (prompt-up-right) (current-directory) (set_color normal) (git_prompt) (prompt-down-right)

end

#}}}

# functions {{{
function xsource
  for i in $argv
    if test -r $i
      . $i
    end
  end
end

if which gosh > /dev/null
  if test -e $GAUCHE_LOAD_PATH/ls.scm
    function cd
      builtin cd $argv
      command gosh ls.scm -d .
    end
  else
    function cd
      builtin cd $argv
    end
  end
end

function ggr
# Search Google
    w3m "http://www.google.com/search?&num=100&q=$argv"
end
# }}}

# aliases {{{

# gauche alias {{{
if which gosh >&-
  alias yotsuba 'command gosh yotsuba-get.scm'
  alias futaba 'command gosh futaba-get.scm'
  alias spc2ubar 'command gosh space2underbar.scm'
  alias ea 'command gosh extattr.scm'
  alias unpack 'command gosh unpack.scm'
  if test -e $GAUCHE_LOAD_PATH/ls.scm
    alias ls 'command gosh ls.scm -d'
    alias la 'command gosh ls.scm -d -a'
    alias ll 'command gosh ls.scm -d -psf'
    alias lla 'command gosh ls.scm -d -psf -a'
    alias l 'command gosh ls.scm -d'
  end
end
#}}}

alias pd prevd
alias nd nextd

if which cdf >&-
  alias df 'cdf -h'
else
  alias df 'df -h'
end
alias single "sudo shutdown now"
alias halt "sync;sync;sync;sudo shutdown -p now"
alias reboot "sync;sync;sync;sudo shutdown -r now"
alias sudo "sudo -E "
alias xfont "xlsatoms | grep '-'"
alias rr 'command rm -rfv'
alias mkd 'command mkdir -p'
alias stow 'stow --verbose=3'
# net {{{
alias starwars 'telnet towel.blinkenlights.nl'
alias radio1 'mplayer -playlist http://www.bbc.co.uk/radio/listen/live/r1.asx'
alias radio2 'mplayer -playlist http://www.bbc.co.uk/radio/listen/live/r2.asx'
alias radio3 'mplayer -playlist http://www.bbc.co.uk/radio/listen/live/r3.asx'
alias radio4 'mplayer -playlist http://www.bbc.co.uk/radio/listen/live/r4.asx'
alias radio6 'mplayer -playlist http://www.bbc.co.uk/radio/listen/live/r6.asx'
alias jblive 'mplayer rtsp://videocdn-us.geocdn.scaleengine.net/jblive/jblive.stream'
alias sumo 'mplayer -playlist http://sumo.goo.ne.jp/hon_basho/torikumi/eizo_haishin/asx/sumolive.asx'
alias sumo 'mplayer -playlist http://sumo.goo.ne.jp/hon_basho/torikumi/eizo_haishin/asx/sumolive.asx'
alias sumo2 'mplayer mms://a776.l12513450775.c125134.a.lm.akamaistream.net/D/776/125134/v0001/reflector:50775'
alias sumo3 'mplayer mms://a792.l12513450791.c125134.a.lm.akamaistream.net/D/792/125134/v0001/reflector:50791'
#}}}
#}}}

# misc {{{
if xsource ~/local/git/z-fish/z.fish
function --on-event fish_prompt z-fish
    z --add "$PWD"
end
end
#}}}
