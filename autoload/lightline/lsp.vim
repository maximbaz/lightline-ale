let s:indicator_error       = get(g:, 'lightline#lsp#indicator_error',       'E:')
let s:indicator_warning     = get(g:, 'lightline#lsp#indicator_warning',     'W:')
let s:indicator_information = get(g:, 'lightline#lsp#indicator_information', 'I:')
let s:indicator_hint        = get(g:, 'lightline#lsp#indicator_hint',        'H:')
let s:indicator_ok          = get(g:, 'lightline#lsp#indicator_ok',          'OK')
let s:indicator_checking    = get(g:, 'lightline#lsp#indicator_checking', 'Linting...')

""""""""""""""""""""""
" Lightline components

" diagnostics status
function! s:status_print(type, indicator) abort
  if !lightline#lsp#linted()
    return ''
  endif
  " { 'error': 1, 'warning': 0, 'information': 0, 'hint': 0 }
  let l:counts = lsp#get_buffer_diagnostics_counts()
  let l:count = l:counts[a:type]
  return l:count == 0 ? '' : printf(a:indicator . '%d', l:count)
endfunction

function! lightline#lsp#error() abort
  return s:status_print('error', s:indicator_error)
endfunction

function! lightline#lsp#warning() abort
  return s:status_print('warning', s:indicator_warning)
endfunction

function! lightline#lsp#information() abort
  return s:status_print('information', s:indicator_information)
endfunction

function! lightline#lsp#hint() abort
  return s:status_print('hint', s:indicator_hint)
endfunction

function! lightline#lsp#count() abort
  if !lightline#lsp#linted()
    return ''
  endif
  " { 'error': 1, 'warning': 0, 'information': 0, 'hint': 0 }
  let l:counts = lsp#get_buffer_diagnostics_counts()
  let l:total_count = l:counts.error + l:counts.warning + l:counts.information + l:counts.hint
  return l:total_count == 0 ? '' : printf('%s %s %s %s',
    \ printf(s:indicator_error       . '%d', l:counts['error']),
    \ printf(s:indicator_warning     . '%d', l:counts['warning']),
    \ printf(s:indicator_information . '%d', l:counts['information']),
    \ printf(s:indicator_hint        . '%d', l:counts['hint']))
endfunction

function! lightline#lsp#ok() abort
  if !lightline#lsp#linted()
    return ''
  endif
  " { 'error': 1, 'warning': 0, 'information': 0, 'hint': 0 }
  let l:counts = lsp#get_buffer_diagnostics_counts()
  let l:total_count = l:counts.error + l:counts.warning + l:counts.information + l:counts.hint
  return l:total_count == 0 ? s:indicator_ok : ''
endfunction

function! lightline#lsp#checking() abort
  " currently lsp server status API nothing.
  return v:false ? s:indicator_checking : ''
endfunction

" server(whitelist first item) status
" use undocumented API
let s:server_status = {
          \ 'unknown server' : 'warning',
          \ 'exited'         : 'error',
          \ 'starting'       : 'warning',
          \ 'failed'         : 'error',
          \ 'running'        : 'ok',
          \ 'not running'    : 'warning',
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
  let servers = lsp#get_allowed_servers()

  if empty(servers)
    return ''
  endif

  let now = localtime()
  let l:count = len(servers)
  let index = 0
  if l:count > 1
    let interval = get(g:, 'lightline#lsp#server_interval', 30)
    let index = ((now % (l:count * interval)) / interval) % l:count
  endif

  let server_name = servers[index]
  let status = lsp#get_server_status(server_name)

  if get(s:server_status, status, '') ==? a:type
    return server_name . ':' .  status
  endif
  return ''
endfunction

""""""""""""""""""
" Helper functions

function! lightline#lsp#linted() abort
  " currently vim-lsp enabled check API nothing.
  " currently lsp server status API nothing.
  return get(g:, 'lsp_diagnostics_enabled', 0)
endfunction
