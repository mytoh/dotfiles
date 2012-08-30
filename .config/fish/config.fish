

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



set fish_greeting ""

set fish_color_normal         normal
set fish_color_command        cyan
set fish_color_comment        yellow
set fish_color_cwd            blue
set fish_color_end            cyan
set fish_color_error          red
set fish_color_match          magenta
set fish_color_param          magenta
set fish_color_redirection    yellow
set fish_color_search_match   brown
set fish_color_substitution   green
set fish_color_operator       cyan
set fish_color_escape         purple
set fish_color_quote          purple
set fish_color_valid_path     brown

set fish_pager_color_completion  brown
set fish_pager_color_description yellow
set fish_pager_color_prefix      magenta
set fish_pager_color_progress    green


# plugins
set plugins gauche z-fish panna talikko lol
# theme
set FISH_THEME gauche

# source oh-my-fish
. ~/.config/fish/voi-minun-fish.fish


# os {{{
switch (uname)
  case FreeBSD
  xsource $fish_base_dir/freebsd.fish

# mac settings
  case Darwin
  xsource $fish_base_dir/mac.fish
end
#}}}


# memo
# redirect
#  func 2> /dev/null
#  func ^/dev/null
#  func ^&-

# vim: foldmethod=marker
