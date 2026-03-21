" vim-markdown-fold - Stateless markdown folding by header level
" Maintainer: Soheil Ghafurian
" License:    MIT

if exists('b:did_markdown_fold')
  finish
endif
let b:did_markdown_fold = 1

setlocal foldmethod=expr
setlocal foldexpr=markdownfold#foldexpr()
