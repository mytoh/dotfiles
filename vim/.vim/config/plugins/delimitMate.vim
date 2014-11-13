
" delimitMate {{{
let delimitMate_matchpairs = "(:),[:],{:},<:>"
let delimitMate_excluded_regions = "Comment,String"

augroup delimitMateSettings
  autocmd FileType vim,html let b:delimitMate_matchpairs = "(:),[:],{:},<:>"
  autocmd FileType scheme let b:delimitMate_quotes = "\" ' *"
augroup end
" }}}
