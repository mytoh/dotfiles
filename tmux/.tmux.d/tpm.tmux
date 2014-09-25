
# List of plugins
# Supports `github_username/repo` or full git URLs
set -g @tpm_plugins "              \
  tmux-plugins/tpm                 \
  tmux-plugins/tmux-sensible       \
  tmux-plugins/tmux-resurrect      \
"
# Other examples:
# github_username/plugin_name    \
# git@github.com/user/plugin     \
# git@bitbucket.com/user/plugin  \

# initializes TMUX plugin manager
#if-shell "test -d ${HOME}/.tmux/plugins/tpm" "run-shell ~/.tmux/plugins/tpm/tpm"
#run-shell ~/.tmux/plugins/tpm/tpm
