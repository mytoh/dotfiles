
set  tcsh_base_dir=~/.sheller/tcsh
set  tcsh_lib_dir=$tcsh_base_dir/lib
set  tcsh_plugins_dir=$tcsh_base_dir/plugins
set  tcsh_themes_dir=$tcsh_base_dir/themes


# load library files
foreach config ($tcsh_lib_dir/*.tcsh)
  source $config
end

# load plugins
foreach plugin ( $plugins )
  if (-f $tcsh_plugins_dir/$plugin/$plugin.plugin.tcsh) then
  source $tcsh_plugins_dir/$plugin/$plugin.plugin.tcsh
  endif
end

# load theme
if ( "$TCSH_THEME" != "" ) then
 source $tcsh_themes_dir/$TCSH_THEME/$TCSH_THEME.theme.tcsh
else
 source $tcsh_themes_dir/default/default.theme.tcsh
endif



