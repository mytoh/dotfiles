
" Vim syntax file
" Language: jfb(1) configuration file
" Maintainer: Tiago Cunha <tcunha@users.sourceforge.net>
" Last Change: $Date: 2010-07-27 18:29:07 $
" License: This file is placed in the public domain.

if version < 600
	syntax clear
elseif exists("b:current_syntax")
	finish
endif

setlocal iskeyword+=-
syntax case match

syn keyword jfbFont	any current none
syn keyword jfbBoolean	Off On

syn keyword jfbOptions
      \ fontset keyboard mouse term history splash encoding
      \ screensaver cursor bell writecombine font video
      \ color1 color2 color3 color4 color5 color6 color7 color8 color9 

syn match jfbSubOptions /\.\w:/ display
syn match jfbKey		/\(C-\|M-\|\^\)\+\S\+/	display
syn match jfbNumber 		/\d\+/			display
syn match jfbOptions		/\s-\a\+/		display
syn match jfbVariable		/: \w\+/			display

syn region jfbComment	start=/#/ end=/$/ contains=tmuxTodo display oneline

hi def link jfbAction		  	Boolean
hi def link jfbBoolean			Boolean
hi def link jfbCmds			    Keyword
hi def link jfbComment	 		Comment
hi def link jfbKey			    Special
hi def link jfbNumber		  	Number
hi def link jfbOptions			Identifier
hi def link jfbSubOptionst 	Function
hi def link jfbOptsSetw	    Function
hi def link jfbVariable		Constant

let b:current_syntax = "jfbterm"
