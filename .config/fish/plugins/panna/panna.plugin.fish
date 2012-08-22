
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

