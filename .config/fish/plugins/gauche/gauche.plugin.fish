
# gauche {{{


set    GAUCHE_ARCH (gauche-config --arch)
set    GAUCHE_BASE_DIR "$HOME/.kirjasto"
set -x GAUCHE_SKRIPTI_DIR "$GAUCHE_BASE_DIR/skripti"
set -x GAUCHE_LOAD_PATH "$GAUCHE_BASE_DIR/lib"

function gosh-skripti
  gosh -I$GAUCHE_SKRIPTI_DIR $argv
end


# gauche completions {{{

# gosh {{{
function __gosh_completion_load_path
  set -l load_path (echo $GAUCHE_LOAD_PATH | tr ':' '\n')
  for i in $load_path
    for j in $i/*.scm
      echo (basename $j)
    end
  end
end

function __gosh_completion_current_directory
  command ls *.scm
end

complete -c gosh -f -a "(__gosh_completion_load_path)" -d "files in GAUCHE_LOAD_PATH"
complete -c gosh -f -a "(__gosh_completion_current_directory)" -d "files in CWD"
#}}}


#}}}


#}}}
