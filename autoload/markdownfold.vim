" markdownfold.vim - Stateless markdown folding by header level
" Maintainer: Soheil Ghafurian
" License:    MIT

function! markdownfold#foldexpr()
  let h = matchstr(getline(v:lnum), '^#\+')
  if empty(h)
    return "="
  else
    return ">" . len(h)
  endif
endfunction
