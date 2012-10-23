
bash_base_dir=~/.sheller/bash
bash_lib_dir=$bash_base_dir/lib
bash_plugins_dir=$bash_base_dir/plugins
bash_themes_dir=$bash_base_dir/themes


# load library files
for config in $bash_lib_dir/*.bash
do
  if [ -f $config ] 
  then
source $config
fi
done

# load plugins
for plugin in "${plugins[@]}"
do
if [ -f $bash_plugins_dir/$plugin/$plugin.plugin.bash ]
then
source $bash_plugins_dir/$plugin/$plugin.plugin.bash
fi
done

# load theme
if [ -n $bash_theme  ]
then
source $bash_themes_dir/$bash_theme.theme.bash
else
source $bash_themes_dir/default.theme.bash
fi



