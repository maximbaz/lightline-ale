augroup lightline#ale
  autocmd!
  autocmd User ALELint call lightline#update()
  autocmd User ALEJobStarted call lightline#update()
augroup END
