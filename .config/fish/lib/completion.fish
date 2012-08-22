

# complete {{{
function push-to-comp-path
set -l comp-directory ~/local/git
  for p in $argv
    if test -d $comp-directory/$p
      if not contains $comp-directory/$p $fish_complete_path
        set fish_complete_path $comp-directory/$p $fish_complete_path
      end
    end
  end
end
push-to-comp-path fish-nuggets/completions fish_completions/ fishystuff/completions


# h function {{{
complete -x -c h -a "(__fish_complete_cd)"
complete -x -c h -a "(__fish_complete_directories $HOME)"
complete -c h -s h -l help --description 'Display help and exit'
# }}}

#}}}

