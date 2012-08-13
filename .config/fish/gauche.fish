
# gauche {{{


set    GAUCHE_ARCH (gauche-config --arch)
set -x GAUCHE_LOAD_PATH "$HOME/.gosh/skripti:$HOME/.gosh:$HOME/.gosh/kirjasto:$HOME/local/share/gauche-0.9/site/lib:$HOME/local/lib/gauche-0.9/site/$GAUCHE_ARCH"


# gauche completions {{{

# gosh {{{
function __gosh_completion_load_path
  set -l load_path (echo $GAUCHE_LOAD_PATH | tr ':' '\n')
  for i in $load_path
    for j in $i/*.scm
      echo (basename $j)
    end
  end
end

function __gosh_completion_current_directory
  command ls *.scm
end

complete -c gosh -f -a "(__gosh_completion_load_path)" -d "files in GAUCHE_LOAD_PATH"
complete -c gosh -f -a "(__gosh_completion_current_directory)" -d "files in CWD"
#}}}

# panna {{{
# add panna to PATH
set -x OLUTPANIMO "$HOME/.panna"
set -x GAUCHE_LOAD_PATH $OLUTPANIMO/kirjasto:$GAUCHE_LOAD_PATH
push-to-path $OLUTPANIMO/bin

function __fish_complete_panna_kaava
  set arguments (commandline -opc)
  set path (echo $OLUTPANIMO | tr ':' '\n')

  for cmd in $arguments

    if contains -- $cmd edit install homepage home up update
      ls $OLUTPANIMO/kirjasto/kaava | sed s/\.scm//
      return 0
    end

    if contains -- $cmd abv info list ls rm remove unlink uninstall
      ls $OLUTPANIMO/kellari
      return 0
    end
  end
end

complete -c panna -n '__fish_use_subcommand' -xa 'build install up edit info
uninstall  unlink rm remove ls list homepage home up update'
complete -c panna -f -a "(__fish_complete_panna_kaava)"
# }}}

# lehti {{{


# }}}

# talikko {{{
function __fish_complete_talikko_ports_tree
  set arguments (commandline -opc)
  set path (echo $OLUTPANIMO | tr ':' '\n')

  for cmd in $arguments
    if contains -- $cmd install
      set -l path /usr/ports/*
      for i in $path
        if test -d $i
        echo (basename $i)
        end
      end
      return 0
    end
  end
end

complete -c talikko -n '__fish_use_subcommand' -xa 'install reinstall update up search'
complete -c talikko -f -a "(__fish_complete_talikko_ports_tree)"
complete -c tl -n '__fish_use_subcommand' -xa 'install reinstall update up search'
complete -c tl -f -a "(__fish_complete_talikko_ports_tree)"
#}}}

#}}}


if which gosh 1>  /dev/null
  alias spc2ubar='command gosh space2underbar.scm'
  alias ea='command gosh extattr.scm'
  alias tm='gosh tmux-start.scm'
  alias gsp='command gosh -ptime'

  alias pikkukivi='gosh run-pikkukivi.scm'
  alias rr='pikkukivi rm'
  alias nap='pikkukivi napa'
  alias tk='pikkukivi talikko'
  alias pahvi='pikkukivi pahvi'
  alias unpack='pikkukivi unpack'
  alias futaba='pikkukivi futaba'
  alias yotsuba='pikkukivi yotsuba'
  alias gsi='rlwrap gosh pikkukivi.scm repl'
  alias ls='pikkukivi ls -d'
  alias la='pikkukivi ls -d -a'
  alias ll='pikkukivi ls -d -ptsf'
  alias lla='pikkukivi ls -d -ptsf -a'
  alias l='pikkukivi ls -d'
  alias emma='pikkukivi emma'
  alias sgit='pikkukivi ääliö'
  alias colour-numbers='pikkukivi colour numbers'
  alias colour-pacman='pikkukivi colour pacman'
  alias colour-spect='pikkukivi colour spect'
  alias colour-square='pikkukivi colour square'
  alias topless='pikkukivi topless'
end

#}}}
