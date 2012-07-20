
if version < 600
	syntax clear
elseif exists("b:current_syntax")
	finish
endif

setlocal iskeyword+=-
syntax case match


syn keyword jfbOption
      \ fontset keyboard mouse term history splash encoding
      \ screensaver cursor bell writecombine font video
      \ color1 color2 color3 color4 color5 color6 color7 color8 color9 
syn match jfbOptionSub /\.(\w):/ contained display

syn keyword jfbValue
      \ None Normal Middle High
      \ SysMouse
      \ Shadow

syn match jfbNumber 		'/\d\+/' contained display
syn keyword jfbFont	any current none
syn keyword jfbBoolean	Off On


syn region jfbComment	start=/#/ end=/$/ contains=tmuxTodo display oneline










hi def link jfbOption	    	Identifier
hi def link jfbOptionSub   	Function
hi def link jfbValue      	Keyword

hi def link jfbBoolean			Boolean
hi def link jfbComment	 		Comment
hi def link jfbNumber		  	Number

" 	*Constant	any constant
" 	 String		a string constant: "this is a string"
" 	 Character	a character constant: 'c', '\n'
" 	 Number		a number constant: 234, 0xff
" 	 Boolean	a boolean constant: TRUE, false
" 	 Float		a floating point constant: 2.3e10
" 
" 	*Identifier	any variable name
" 	 Function	function name (also: methods for classes)
" 
" 	*Statement	any statement
" 	 Conditional	if, then, else, endif, switch, etc.
" 	 Repeat		for, do, while, etc.
" 	 Label		case, default, etc.
" 	 Operator	"sizeof", "+", "*", etc.
" 	 Keyword	any other keyword
" 	 Exception	try, catch, throw
" 
" 	*PreProc	generic Preprocessor
" 	 Include	preprocessor #include
" 	 Define		preprocessor #define
" 	 Macro		same as Define
" 	 PreCondit	preprocessor #if, #else, #endif, etc.
" 
" 	*Type		int, long, char, etc.
" 	 StorageClass	static, register, volatile, etc.
" 	 Structure	struct, union, enum, etc.
" 	 Typedef	A typedef
" 
" 	*Special	any special symbol
" 	 SpecialChar	special character in a constant
" 	 Tag		you can use CTRL-] on this
" 	 Delimiter	character that needs attention
" 	 SpecialComment	special things inside a comment
" 	 Debug		debugging statements
" 
" 	*Underlined	text that stands out, HTML links
" 
" 	*Ignore		left blank, hidden  |hl-Ignore|
" 
" 	*Error		any erroneous construct
" 
" 	*Todo		anything that needs extra attention; mostly the
" 			keywords TODO FIXME and XXX

let b:current_syntax = "jfbterm"
