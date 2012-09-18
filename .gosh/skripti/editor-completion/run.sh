#!/usr/bin/env bash
MAKEDIR=$PWD
DIST=$1


# gauche_modules
# echo "gauche_modules"
# cd /usr/local/share/gauche-0.9/0.9.2/lib
# find .|grep '\.scm$' | perl -pe '$_ =~ s/^..//; $_ =~ s/\.scm$//; $_ =~ s#/#.#g;' > /tmp/g
# cd /tmp
# cat g | sort > $MAKEDIR/gauche_modules

gosh ./gen_gosh_modules.scm

# gosh_completions
# echo "gosh_completions"
# cd $MAKEDIR
# cat ./gauche_modules | gosh make_gosh_completions.scm | sort | uniq > gosh_completions

# gosh ./gen-gosh-completion.scm

# scheme.vim
cd $MAKEDIR
echo "scheme.vim"
if [ -f scheme.vim ]; then
mv -fv scheme.vim scheme.vim.old
fi
cat ./gosh_completions | gosh make_scheme_vim.scm ./gauche_modules ./scheme.vim.tmpl > scheme.vim


# move syntax file to $DIST
echo "moving file"
command mv -v -i scheme.vim $DIST
