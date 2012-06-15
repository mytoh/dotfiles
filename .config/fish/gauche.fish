
# gauche {{{


set    GAUCHE_ARCH (gauche-config --arch)
set -x GAUCHE_LOAD_PATH "$HOME/.gosh:$HOME/.gosh/skripti:$HOME/local/share/gauche-0.9/site/lib:$HOME/local/lib/gauche-0.9/site/$GAUCHE_ARCH"


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
if test ! -L $OLUTPANIMO/bin/pan
  ln -sf $OLUTPANIMO/kirjasto/run-panna.scm $OLUTPANIMO/bin/pan
end

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

# gauche functions {{{
if which gosh >&-

        if test -n $GAUCHE_LOAD_PATH
                function cd
                        if test -d $argv[1]
                                builtin cd $argv
                                and command gosh ls.scm -d .
                        else
                                builtin cd (dirname $argv[1])
                                and command gosh ls.scm -d .
                        end
                end
        else
                function cd
                        builtin cd $argv
                end
        end

        function gi
                rlwrap -c -q '"' -b '(){}[].,#@;|`"' gosh repl.scm $argv
       end

       function tk
                command gosh talikko.scm $argv
       end

        function yotsuba
                command gosh yotsuba-get.scm $argv
        end
        function futaba
                command gosh futaba-get.scm $argv
        end

        function pahvi
                command gosh pahvi.scm $argv
        end

        function spc2ubar
                command gosh space2underbar.scm $argv
        end

        function ea
                command gosh extattr.scm $argv
        end

        function unpack
                command gosh unpack.scm $argv
        end


        function colour-numbers
                command gosh colour-numbers.scm
        end

        function colour-pacman
                command gosh colour-pacman.scm
        end

        function fi-en
                command gosh kääntää.scm fi en $argv[1]
        end

        function en-fi
                command gosh kääntää.scm en fi $argv[1]
        end

        function fi-ja
                command gosh kääntää.scm fi ja $argv[1]
        end

        function sanoa
                command gosh sanoa.scm $argv
        end

        function v
                command gosh v.scm $argv
        end

        function a
                command gosh launch-app.scm $argv
        end
        complete -c a -a "(complete -C(commandline -ct))" -x

        function nap
              command gosh napa.scm $argv
        end

        function tm
                command gosh tmux-start.scm
        end

        function urxvtcd
                command gosh urxvtcd.scm
        end

        function kuv
               command gosh kuva.scm
        end


        function la
                command gosh ls.scm -d -a
        end
        function ll
                command gosh ls.scm -d -psf
        end
        function lla
                command gosh ls.scm -d -psf -a
        end
        function l
                command gosh ls.scm -d
        end
end
#}}}

#}}}
