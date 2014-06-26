# List of plugins
# Supports `github_username/repo` or full git URLs
set -g @tpm_plugins "              \
  bruno-/tpm                       \
  bruno-/tmux_pain_control         \
  bruno-/tmux_online_status         \
"
# Other examples:
# github_username/plugin_name    \
# git@github.com/user/plugin     \
# git@bitbucket.com/user/plugin  \

# initializes TMUX plugin manager
if-shell "test -f ${HOME}/.tmux/plugins/tpm" "run-shell ~/.tmux/plugins/tpm/tpm"
#run-shell ~/.tmux/plugins/tpm/tpm
