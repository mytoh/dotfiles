
alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'
alias tar='gnutar'
alias sc='screen -U -D -RR'
alias portsup=" sudo port -v selfupdate && sudo port -v sync && sudo port -vRu upgrade installed "
alias cpanup="cpanm -Sv --self-upgrade;cpan-outdated | xargs cpanm -Sv"
alias mp='mplayer'
export PERL_CPANM_DEV=1
export PATH=$HOME/local/homebrew/bin/:$HOME/local/bin:$HOME/local/ports/bin:$PATH

#complete -C perldoc-complete -o nospace -o default perldoc

#bash share history
function share_history {  # 以下の内容を関数として定義
history -a  # .bash_historyに前回コマンドを1行追記
history -c  # 端末ローカルの履歴を一旦消去
history -r  # .bash_historyから履歴を読み込み直す
 }
 PROMPT_COMMAND='share_history'  # 上記関数をプロンプト毎に自動実施
 shopt -u histappend   # .bash_history追記モードは不要なのでOFFに

  if [ -f /Users/kazuki/local/ports/etc/bash_completion ]; then
                . /Users/kazuki/local/ports/etc/bash_completion
  fi


 #coreutils alias
 alias base64='gbase64'
 alias basename='gbasename'
 alias cat='gcat'
 alias chgrp='gchgrp'
 alias chmod='gchmod'
 alias chown='gchown'
 alias chroot='gchroot'
 alias cksum='gcksum'
 alias comm='gcomm'
 alias cp='gcp'
 alias csplit='gcsplit'
 alias cut='gcut'
 alias date='gdate'
 alias dd='gdd'
 alias df='gdf'
 alias dir='gdir'
 alias dircolors='gdircolors'
 alias dirname='gdirname'
 alias du='gdu'
 alias echo='gecho'
 alias env='genv'
 alias expand='gexpand'
 alias expr='gexpr'
 alias factor='gfactor'
 alias false='gfalse'
 alias fmt='gfmt'
 alias fold='gfold'
 alias groups='ggroups'
 alias head='ghead'
 alias hostid='ghostid'
 alias hostname='ghostname'
 alias id='gid'
 alias install='ginstall'
 alias join='gjoin'
 alias kill='gkill'
 alias link='glink'
 alias ln='gln'
 alias logname='glogname'
 alias ls='gls -F --color'
 alias md5sum='gmd5sum'
 alias mkdir='gmkdir'
 alias mkfifo='gmkfifo'
 alias mknod='gmknod'
 alias mv='gmv'
 alias nice='gnice'
 alias nl='gnl'
 alias nohup='gnohup'
 alias od='god'
 alias paste='gpaste'
 alias pathchk='gpathchk'
 alias pinky='gpinky'
 alias pr='gpr'
 alias printenv='gprintenv'
 alias printf='gprintf'
 alias ptx='gptx'
 alias pwd='gpwd'
 alias readlink='greadlink'
 alias rm='grm'
 alias rmdir='grmdir'
 alias seq='gseq'
 alias sha1sum='gsha1sum'
 alias sha224sum='gsha224sum'
 alias sha256sum='gsha256sum'
 alias sha384sum='gsha384sum'
 alias sha512sum='gsha512sum'
 alias shred='gshred'
 alias shuf='gshuf'
 alias sleep='gsleep'
 alias sort='gsort'
 alias split='gsplit'
 alias stat='gstat'
 alias stty='gstty'
 alias su='gsu'
 alias sum='gsum'
 alias sync='gsync'
 alias tac='gtac'
 alias tail='gtail'
 alias tee='gtee'
 alias test='gtest'
 alias touch='gtouch'
 alias tr='gtr'
 alias true='gtrue'
 alias tsort='gtsort'
 alias tty='gtty'
 alias uname='guname'
 alias unexpand='gunexpand'
 alias uniq='guniq'
 alias unlink='gunlink'
 alias uptime='guptime'
 alias users='gusers'
 alias vdir='gvdir'
 alias wc='gwc'
 alias who='gwho'
 alias whoami='gwhoami'
 alias yes='gyes'

 #findutils
 alias find='gfind'
 alias locate='glocate'
 alias oldfind='goldfind'
 alias updatedb='gupdatedb'
 alias xargs='gxargs'

 #diffutils
 alias cmp='gcmp'
 alias diff='gdiff'
 alias diff3='gdiff3'
 alias sdiff='gsdiff'

 alias make='gmake'



 #if [ -z $SCREEN_STARTED ]; then
 #         export SCREEN_STARTED=true
 #           screen -R && exit
 #    fi

