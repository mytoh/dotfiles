
if neobundle#is_installed('tcomment_vim')
  call tcomment#DefineType('scheme','; %s')
  call tcomment#DefineType('scheme_inline','#| %s |#')
  " call tcomment#DefineType('scheme','; %s')

  call tcomment#DefineType('fish','# %s')
endif
