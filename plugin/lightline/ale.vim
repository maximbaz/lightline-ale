augroup lightline#ale
  autocmd!
  autocmd User ALEJobStarted call lightline#update()
  autocmd User ALELintPost call lightline#update()
augroup END
