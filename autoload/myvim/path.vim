" Path helpers for this config

if exists('g:loaded_myvim_path')
  finish
endif
let g:loaded_myvim_path = 1

function! myvim#path#join(...) abort
  return simplify(join(a:000, '/'))
endfunction

function! myvim#path#ensure_dir(dir) abort
  if empty(a:dir)
    return
  endif
  if !isdirectory(a:dir)
    call mkdir(a:dir, 'p')
  endif
endfunction
