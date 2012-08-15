
# Colors!
set     red="%{\033[1;31m%}"
set   green="%{\033[0;32m%}"
set  yellow="%{\033[1;33m%}"
set    blue="%{\033[1;34m%}"
set magenta="%{\033[1;35m%}"
set    cyan="%{\033[1;36m%}"
set   white="%{\033[0;37m%}"
set     end="%{\033[0m%}" # This is needed at the end... :(
set      c1="%{\033[38;5;235m%}"
set      c2="%{\033[38;5;238m%}"
set      c3="%{\033[38;5;60m%}"
set      c4="%{\033[38;5;118m%}"
set      c5="%{\033[38;5;103m%}"

set promptchars=">,#"
#set prompt='%{[0000mk\\%}[%{[34m%n[37m@[32m%m[m%}] %c2 > '
set prompt="%{[0000mk\\%}${c4}%m ${c5}:: ${cyan}%c2 \n${c1}>${c2}>${c3}>${end} "
