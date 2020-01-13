let s:indicator_warnings = get(g:, 'lightline#lsp#indicator_warnings', 'W: ')
let s:indicator_errors = get(g:, 'lightline#lsp#indicator_errors', 'E: ')
let s:indicator_ok = get(g:, 'lightline#lsp#indicator_ok', 'OK')
let s:indicator_checking = get(g:, 'lightline#lsp#indicator_checking', 'Linting...')


""""""""""""""""""""""
" Lightline components

" diagnostics status
function! lightline#lsp#warnings() abort
  if !lightline#lsp#linted()
    return ''
  endif
  let l:counts = lsp#get_buffer_diagnostics_counts()
  let l:all_errors = l:counts
  " currently diagnostics count type variant API nothing.
  let l:all_non_errors = 0
  return l:all_non_errors == 0 ? '' : printf(s:indicator_warnings . '%d', all_non_errors)
endfunction

function! lightline#lsp#errors() abort
  if !lightline#lsp#linted()
    return ''
  endif
  let l:counts = lsp#get_buffer_diagnostics_counts()
  let l:all_errors = l:counts
  return l:all_errors == 0 ? '' : printf(s:indicator_errors . '%d', all_errors)
endfunction

function! lightline#lsp#ok() abort
  if !lightline#lsp#linted()
    return ''
  endif
  let l:counts = lsp#get_buffer_diagnostics_counts()
  return l:counts.total == 0 ? s:indicator_ok : ''
endfunction

function! lightline#lsp#checking() abort
  " currently lsp server status API nothing.
  return v:false ? s:indicator_checking : ''
endfunction

" server(whitelist first item) status
" use undocumented API
let s:lightline#lsp#server_status = {
          \ "unknown server" : 'warning',
          \ "exited"         : 'error',
          \ "starting"       : 'warning',
          \ "failed"         : 'error',
          \ "running"        : 'ok',
          \ "not running"    : 'warning',
          \ }

function! lightline#lsp#status_ok() abort
  return s:lsp_status('ok')
endfunction

function! lightline#lsp#status_warning() abort
  return s:lsp_status('warning')
endfunction

function! lightline#lsp#status_error() abort
  return s:lsp_status('error')
endfunction

function! s:lsp_status(type) abort
  let servers = lsp#get_whitelisted_servers(bufnr(''))

  if empty(servers)
    return ''
  endif
  let server_name = servers[0]
  let status = lsp#get_server_status(server_name)

  if s:lightline#lsp#server_status[status] ==? a:type
    return server_name . ':' .  status
  endif
  return ''
endfunction

""""""""""""""""""
" Helper functions

function! lightline#lsp#linted() abort
  " currently vim-lsp enabled check API nothing.
  " currently lsp server status API nothing.
  return get(g:, 'lsp_diagnostics_enabled', 0) == 1
endfunction
