" vim-markdown-fold - Markdown folding by header, code block, and quote block
" Maintainer: Soheil Ghafurian
" License:    MIT

if exists('b:did_markdown_fold')
  finish
endif
let b:did_markdown_fold = 1

setlocal foldmethod=expr
setlocal foldexpr=markdownfold#foldexpr()

" foldmethod and foldexpr are window-local, so they must be reapplied
" whenever this buffer enters a window (e.g. :b switch, :split).
augroup markdown_fold_winlocal
  autocmd! * <buffer>
  autocmd BufEnter <buffer>
        \ if &foldmethod !=# 'expr' || &foldexpr !=# 'markdownfold#foldexpr()' |
        \   setlocal foldmethod=expr foldexpr=markdownfold#foldexpr() |
        \ endif
augroup END
