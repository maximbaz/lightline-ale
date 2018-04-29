augroup lightline#ale
  autocmd!
  autocmd User ALELintPre  call lightline#ale#mark_lint_started() | call lightline#update()
  autocmd User ALELintPost call lightline#ale#mark_lint_stopped() | call lightline#update()
augroup END
