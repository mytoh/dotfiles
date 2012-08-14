
  push-to-path /opt/X11/bin /usr/x11/bin 
  set -x DYLD_FALLBACK_LIBRARY_PATH "$HOME/local/lib:$HOME/local/homebrew/lib:/usr/lib:/usr/local/lib:/Library/Frameworks/Mono.frameworks/Libraries"
  #set -x LD_LIBRARY_PATH /usr/local/linux-sun-jdk1.6.0/jre/lib/i386
  set PYTHONPATH "~/local/homebrew/lib/python:$PYTHONPATH"
  set -x TERM xterm-256color

  #function fish_prompt -d "fish prompt function"
  #  #printf '%s%s%s%s\n%s ' (prompt-up-right) (current-directory) (set_color normal) (git_prompt) (prompt-down-right)
  #  if test -d $PWD/.git
  #  printf '%s.%s :: %s:%s\n%s ' (prompt-face) (prompt-host) (current-directory) (git_prompt)  (prompt-arrow)
  #  else
  #  printf '%s.%s :: %s\n%s ' (prompt-face) (prompt-host) (current-directory) (prompt-arrow)
  #  end
  #end

  function fish_prompt -d "fish prompt with gauche script"
   gosh prompt.scm
  end

  xsource (brew --prefix)/Library/Contributions/brew_fish_completion.fish
  alias mp2 "/Applications/mplayer2.app/Contents/MacOS/mplayer-bin"
  alias bsearch "brew search "
  alias binst "brew install -v"
  function squid_restart
    killall squid
    killall squid
    kill (cat ~/.squid/logs/squid.pid)
    kill (cat ~/.squid/logs/squid.pid)
    /bin/rm -rfv ~/.squid/cache/*
    squid -f ~/.squid/etc/squid.conf -z
    squid -f ~/.squid/etc/squid.conf
  end
  set -x HOMEBREW_VERBOSE 1
  set -x HOMEBREW_USE_CLANG 1
  set -x JAVA_HOME ~/Library/JAVA/JavaVirtualMachines/1.7.0.jdk/Contents/Home
