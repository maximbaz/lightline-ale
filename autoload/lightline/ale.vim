let s:indicator_warnings = get(g:, 'lightline#ale#indicator_warnings', 'W:')
let s:indicator_errors = get(g:, 'lightline#ale#indicator_errors', 'E:')
let s:indicator_ok = get(g:, 'lightline#ale#indicator_ok', 'OK')

function! lightline#ale#warnings() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  return l:all_non_errors == 0 ? '' : printf(s:indicator_warnings . ' %d', all_non_errors)
endfunction

function! lightline#ale#errors() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  return l:all_errors == 0 ? '' : printf(s:indicator_errors . ' %d', all_errors)
endfunction

function! lightline#ale#ok() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  return l:counts.total == 0 ? s:indicator_ok : ''
endfunction
