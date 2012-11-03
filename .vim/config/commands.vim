
" install popler-utils or xpdf
if executable('pdftotext')
  if executable('fmt')
  command! -complete=file -nargs=1 Rpdf :r !pdftotext -nopgbrk <q-args> -
else
  command! -complete=file -nargs=1 Rpdf :r !pdftotext -nopgbrk <q-args> - | fmt -csw78
endif
endif
