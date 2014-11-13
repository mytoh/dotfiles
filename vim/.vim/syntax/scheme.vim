
let s:save_cpo = &cpo
set cpo&vim

function! s:define_minikanren()
  " lisp keywords for minikanren

  " mk {{{
 syntax keyword schemeSyntax
        \ lambdag@
        \ lambdaf@
        \ size-s
        \ empty-s
        \ unify
        \ occurs-check
        \ unify-check
        \ reify-s
        \ reify-name
        \ reify
        \ run
        \ case-inf
        \ mzero
        \ unit
        \ choice
        \ fresh
        \ all
        \ conde
        \ bind
        \ mplus
        \ anye
        \ alli
        \ condi
        \ anyi
        \ bindi
        \ mplusi
        \ conda
        \ condu
        \ ifa
        \ ifu
  syntax keyword schemeFunc
        \ == ==-check
        \ rhs
        \ lhs
        \ var
        \ var?
        \ walk
        \ walk*
        \ ext-s-check
        \ ext-s
  syntax keyword schemeBoolean
        \ succeed fail

  setlocal lispwords+=
        \lambdag@,lambdaf@,size-s,empty-s
        \,unify,occurs-check,unify-check
        \,reify-s,reify-name,reify,run,case-inf,mzero
        \,unit,choice,fresh,all,conde,succeed,fail
        \,bind,mplus,anye,alli,condi,anyi,bindi,mplusi
        \,conda,condu,ifa,ifu
  "}}}

  " exstraforms {{{
  syntax keyword schemeSyntax
        \ run*
        \ lambda-limited
        \ ll
        \ project
  setlocal lispwords+=\
        \ run*,lambda-limited,ll,project
  " }}}

  " prelude {{{
  syntax keyword schemeFunc
        \ caro
        \ cdro
        \ conso
        \ nullo
        \ eqo
        \ eq-caro
        \ pairo
        \ listo
        \ membero
        \ rembero
        \ appendo
        \ anyo
        \ nevero
        \ alwayso
        \ poso
        \ addero
        \ pluso 
        \ minuso
        \ mulo 
        \ divo 
        \ +o
        \ -o
        \ *o
        \ /o
        \ splito
  " }}}

endfunction

call s:define_minikanren()


let &cpo = s:save_cpo
unlet s:save_cpo
