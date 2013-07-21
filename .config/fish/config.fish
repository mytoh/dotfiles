
function xsource
  for i in $argv
    if test $i
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

set fish_color_normal normal
set fish_color_command cyan
set fish_color_comment yellow
set fish_color_cwd blue
set fish_color_end cyan
set fish_color_error red
set fish_color_match magenta
set fish_color_param magenta
set fish_color_redirection yellow
set fish_color_search_match brown
set fish_color_substitution green
set fish_color_operator cyan
set fish_color_escape purple
set fish_color_quote purple
set fish_color_valid_path brown

set fish_pager_color_completion brown
set fish_pager_color_description yellow
set fish_pager_color_prefix magenta
set fish_pager_color_progress green


# shellar
set -gx shellar ~/.shellar
# plugins
set -gx shellar_plugins mytoh freebsd loitsu lehti nopea talikko emacs napa pikkukivi brew lol
# theme
set -gx shellar_theme default
# custom
set -gx shellar_custom ~/.shellar_custom
# source oh-my-fish
. {$shellar}/shellar/shellar.fish

# memo
# redirect
#  func 2> /dev/null
#  func ^/dev/null
#  func ^&-

# vim: foldmethod=marker
