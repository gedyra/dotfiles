setlocal smarttab
setlocal expandtab
setlocal tabstop=8
setlocal shiftwidth=4
setlocal softtabstop=4
setlocal foldmethod=indent
setlocal commentstring=#%s

if version < 600
  syntax clear
elseif exists('b:current_after_syntax')
  finish
endif

let s:cpo_save = &cpo
set cpo&vim

syn match pythonOperator "\(+\|=\|-\|\^\|\*\)"
syn match pythonDelimiter "\(,\|\.\|:\)"
syn keyword pythonSpecialWord self

hi link pythonSpecialWord    Special
hi link pythonDelimiter      Special

let b:current_after_syntax = 'python'

let &cpo = s:cpo_save
unlet s:cpo_save

setlocal smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
