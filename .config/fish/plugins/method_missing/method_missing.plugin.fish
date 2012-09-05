
# cmmand not found
# http://bjeanes.com/2009/10/using-fish-shells-event-system-to-behave-like-method-missing
function __fish_method_missing --on-event fish_command_not_found
   ~/.config/fish/plugins/method_missing/bin/method_missing $argv
end

