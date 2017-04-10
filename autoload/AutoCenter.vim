" Set the 'cpoptions' option to its Vim default value and restore it later.
" This is to enable line-continuation within this script.
" Refer to :help use-cpo-save.
let s:save_cpoptions = &cpoptions
set cpoptions&vim

if !exists('g:AutoCenter_On')
  let g:AutoCenter_On = 0
endif
lockvar g:AutoCenter_On

function! AutoCenter#On()
  if g:AutoCenter_On
    echohl Error
    echo 'AutoCenter is already on.'
    echohl NONE
    return
  endif
  silent SaveMapping '<Esc>', 'i', 'global'
  silent SaveMapping '<CR>', 'i', 'global'
  inoremap <Esc> <Esc>:center<CR>
  inoremap <CR> <CR><C-\><C-O>:-1center<CR>
  unlockvar g:AutoCenter_On
  let g:AutoCenter_On = 1
  lockvar g:AutoCenter_On
endfunction

function! AutoCenter#Off()
  if !g:AutoCenter_On
    echohl Error
    echo 'AutoCenter is already off.'
    echohl NONE
    return
  endif
  iunmap <Esc>
  iunmap <CR>
  unlockvar g:AutoCenter_On
  let g:AutoCenter_On = 0
  lockvar g:AutoCenter_On
  silent LoadMapping '<Esc>', 'i', 'global'
  silent LoadMapping '<CR>', 'i', 'global'
endfunction

let &cpoptions = s:save_cpoptions
unlet s:save_cpoptions

