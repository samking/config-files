" Vim syntax file
" Language: Jack (From NAND to Tetris educational language)
" Maintainer: Sam King <samking@cs.stanford.edu>
" Latest Revision: 5/21/2012

if exists("b:current_syntax")
  finish
endif

" Jack is case sensitive
syn case match

syn keyword jackClassesAndMethods class constructor method function this
syn keyword jackVariableModifiers let var static field int boolean char void
syn keyword jackControl do if while return
syn keyword jackConstants true false null

syn region jackBlock start="{" end="}" fold transparent

" Single line comments are //.  Multiline are /** */.  Comments can contain
" TODOs.
syn match jackSingleComment "//.*$" contains=jackComment
syn region jackMultiComment keepend start="/\*\*" end="\*/" contains=jackComment fold
syn match jackComment "." contains=jackTodo contained
syn keyword jackTodo contained TODO FIXME NOTE

let b:current_syntex = "jack"

hi def link jackConstants Constant
hi def link jackControl Statement
hi def link jackVariableModifiers Type
hi def link jackClassesAndMethods Type
hi def link jackComment Comment
hi def link jackTodo Todo
