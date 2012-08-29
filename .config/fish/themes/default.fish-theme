
# prompt {{{
set open_paren "[30m([0m"
set close_paren "[30m)[0m"

#  arch wiki git status prompt {{{
set fish_git_dirty_colour red
function parse_git_dirty
  git diff --quiet HEAD 2>&-
  if test $status = 1
    echo (set_color $fish_git_dirty_colour)"÷"(set_color normal)
  end
end

function parse_git_branch
  # git branch outputs lines, the current branch is prefixed with a *
  set -l branch (git branch --color | awk '{print $2}')
  echo $branch (parse_git_dirty)
end

function git_prompt
  if test -z (git branch --quiet 2>| awk '/fatal:/ {print "no git"}')
    printf '%s%s' (parse_git_branch) (set_color $fish_color_normal)
  else
    echo ""
  end
end
#}}}

function prompt_pwd_mod -d 'prompt_pwd modification for /usr/home/${USER} on FreeBSD'
  switch "$PWD"
  case "/usr$HOME"
    echo '~'
  case "/usr$HOME/*"
    printf "%s" (echo $PWD|sed -e "s|^/usr$HOME|~|" -e 's-/\(\.\{0,1\}[^/]\)\([^/]*\)-/\1-g')
    echo $PWD | sed -n -e 's-.*/\.\{0,1\}.\([^/]*\)-\1-p'
  case '*'
    prompt_pwd
  end
end

function current-directory
  switch "$PWD"
  case "/usr$HOME"
    printf '%s%s%s' (set_color $fish_color_cwd) (echo '~') (set_color $fish_color_normal)
  case "/usr$HOME/*"
    printf '%s%s%s' (set_color $fish_color_cwd) (echo $PWD|sed -e "s|^/usr$HOME|~|") (set_color $fish_color_normal)
  case '*'
    printf '%s%s%s' (set_color $fish_color_cwd) (echo $PWD) (set_color $fish_color_normal)
  end

  #printf '%s%s%s' (set_color $fish_color_cwd) (prompt_pwd_mod) (set_color $fish_color_normal)
end

function prompt-up-right
  printf '%s%s' "[30m┌─[0m"
end

function prompt-down-right
  printf '%s%s' "[30m└┈╸[0m"
end

function prompt-host
  printf '%s%s%s' "[38;5;118m" (hostname -s) (set_color $fish_color_normal)
end

function prompt-face
#if test $status = 1
#  printf '%s%s%s' "[38;5;196m" "(・X・)" (set_color $fish_color_normal)
#else
  printf '%s%s%s' "[38;5;172m" "X / _ / X" (set_color $fish_color_normal)
#end
end

function prompt-arrow
printf '%s%s%s' "[38;5;235m>"  "[38;5;67m>"   "[38;5;117m>"
end

function fish_prompt
prompt-arrow
end


#}}}
