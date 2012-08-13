
  set -x LD_LIBRARY_PATH /usr/local/linux-sun-jdk1.6.0/jre/lib/i386
  set -x SDL_VIDEODRIVER vgl
  set -x XDG_DATA_DIRS /usr/local/kde4/share
  # PACKAGESITE="ftp://ftp.jp.FreeBSD.org/pub/FreeBSD/ports/i386/packages/Latest/"
  function pcheck
    sudo portmaster -PBidav $argv
    and sudo portaudit -Fdav
  end
  function pfetch
    sudo make fetch-recursive
  end
  function pinst
    sudo make clean
    sudo make install distclean
  end
  function pconf
    sudo make config-recursive
  end
  function pclean
    sudo make clean
  end
  function pkg_add
    pkg_add -v $argv
  end
  function pcreate
    pkg_create -RJvnb
  end
  function pcreateall
    pkg_info -Ea |    xargs -n 1 sudo pkg_create -Jnvb
  end


  #if test $TERM = "cons25"
  #if test -e (which jfbterm)
  #  jfbterm
  #end
  #end

  function beastie
    echo '


                [31m,        ,
               /(        )`
               \ \___   / |
               /- [37m_[31m  `-/  '\''
              ([37m/\/ \[31m \   /\
              [37m/ /   |[31m `    \
              [34mO O   [37m) [31m/    |
              [37m`-^--'\''[31m`<     '\''
             (_.)  _  )   /
              `.___/`    /
                `-----'\'' /
   [33m<----.[31m     __ / __   \
   [33m<----|====[31mO)))[33m==[31m) \) /[33m====]
   [33m<----'\''[31m    `--'\'' `.__,'\'' \
               |        |
                \       /       /\
           [36m______[31m( (_  / \______/
         [36m,'\''  ,-----'\''   |
         `--{__________)[37m                                 '

  end

  function orb
    echo '
     [31m```                        [31;1m`[31m
[31;1m    s` `.....---...[31;1m....--.```   -/[31m
    +o   .--`         [31;1m/y:`      +.[31m
     yo`:.            [31;1m:o      `+-[31m
      y/               [31;1m-/`   -o/[31m
     .-                  [31;1m::/sy+:.[31m
[37m     /                     [31;1m`--  /[31m
[37m    `[31m:                          [31;1m:`[31m
[37m    `[31m:                          [31;1m:`[31m
[37m     /                          [31;1m/[31m
[37m     .[31m-                        [31;1m-.[31m
      --                      [31;1m-.[31m
       `:`                  [01;31m`:`
         [31;1m.--             [37m`-[33m-.
            .---...[33m...----                         '

  end
