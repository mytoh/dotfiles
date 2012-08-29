
set -l fish_base_dir ~/.config/fish
set -l fish_lib_dir $fish_base_dir/lib
set -l fish_plugins_dir $fish_base_dir/plugins
set -l fish_themes_dir $fish_base_dir/themes

# load library files
for config in $fish_lib_dir/*.fish
  . $config
end

# load plugins
for plugin in $plugins
  if test $fish_plugins_dir/$plugin/$plugin.plugin.fish
  . $fish_plugins_dir/$plugin/$plugin.plugin.fish
  end
end

# load theme
if test $FISH_THEME
. $fish_themes_dir/$FISH_THEME.fish-theme
else
. $fish_themes_dir/default.fish-theme
end



