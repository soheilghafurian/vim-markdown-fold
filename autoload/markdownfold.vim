" markdownfold.vim - Markdown folding by header, code block, and quote block
" Maintainer: Soheil Ghafurian
" License:    MIT

" Build a lookup of fence lines and code-block regions.
" Cached per buffer change via b:changedtick.
function! s:ensure_cache() abort
  if exists('b:_mkfold_tick') && b:_mkfold_tick == b:changedtick
    return
  endif
  let b:_mkfold_tick = b:changedtick
  let b:_mkfold_fence = {}
  let b:_mkfold_in_code = {}
  let in_code = 0
  let i = 1
  let last = line('$')
  while i <= last
    if getline(i) =~# '^\s*```'
      if in_code
        let b:_mkfold_fence[i] = 'close'
        let in_code = 0
      else
        let b:_mkfold_fence[i] = 'open'
        let in_code = 1
      endif
    elseif in_code
      let b:_mkfold_in_code[i] = 1
    endif
    let i += 1
  endwhile
endfunction

function! markdownfold#foldexpr() abort
  call s:ensure_cache()
  let lnum = v:lnum
  let line = getline(lnum)

  " --- Fenced code blocks ------------------------------------------------
  let fence = get(b:_mkfold_fence, lnum, '')
  if fence ==# 'open'
    return "a1"
  endif
  " Closing fence: fold ends after this line (line itself stays inside fold).
  if fence ==# 'close'
    return "s1"
  endif
  " Lines between fences inherit level; skip all other rules.
  if get(b:_mkfold_in_code, lnum, 0)
    return "="
  endif

  " --- Headers ------------------------------------------------------------
  let h = matchstr(line, '^#\+')
  if !empty(h)
    return ">" . len(h)
  endif

  " --- Quote blocks -------------------------------------------------------
  if line =~# '^>'
    let prev_is_q = lnum > 1 && getline(lnum - 1) =~# '^>'
    let next_is_q = lnum < line('$') && getline(lnum + 1) =~# '^>'
    if !prev_is_q && next_is_q
      " First line of a multi-line quote run: start a nested fold.
      return "a1"
    endif
    if prev_is_q && !next_is_q
      " Last line of a quote run: fold ends after this line.
      return "s1"
    endif
    " Single-line quote (no fold) or middle of a run.
    return "="
  endif

  return "="
endfunction
