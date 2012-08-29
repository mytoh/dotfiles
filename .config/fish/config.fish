
function xsource
  for i in $argv
    if test  $i
      . $i
    end
  end
end

function push-to-path
    for p in $argv
      if test -d $p
        if not contains $p $PATH
          set -gx PATH $p $PATH
        end
      end
    end
end


# load fish files {{{



# plugins
set plugins gauche z-fish panna talikko
# theme
set FISH_THEME gauche

# source oh-my-fish
. ~/.config/fish/oh-my-fish.fish


# }}}

#}}}






# misc {{{


#}}}

# os {{{
switch (uname)
  case FreeBSD
  xsource $fish_base_dir/freebsd.fish

# mac settings
  case Darwin
  xsource $fish_base_dir/mac.fish
end
#}}}


# }}}

# memo
# redirect
#  func 2> /dev/null
#  func ^/dev/null
#  func ^&-

# vim: foldmethod=marker
