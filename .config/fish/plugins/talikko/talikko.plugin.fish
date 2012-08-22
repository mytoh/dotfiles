
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

