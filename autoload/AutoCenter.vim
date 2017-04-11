" Change the 'cpoptions' option temporarily {{{
" Set to its Vim default value and restore it later.
" This is to enable line-continuation within this script.
" Refer to :help use-cpo-save.
let s:save_cpoptions = &cpoptions
set cpoptions&vim
" }}}

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
  augroup AutoCenter
    autocmd!
    " !!Warning!! Undo and redo also change the text, triggering the AutoCenter
    " autocmd, which changes the effect of undo and BREAKS REDO if this command
    " changes the text. So we don't center text in this case.
    autocmd TextChanged,TextChangedI *
    \ if !s:isUndoRedo() | call s:center() | endif
  augroup END
  " Ues '=' key to center lines in Normal and Visual mode.
  nnoremap <silent> = :set opfunc=<SID>opCenter<CR>g@
  nnoremap <silent> == :center<CR>
  xnoremap <silent> = :center<CR>
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
  augroup AutoCenter
    autocmd!
  augroup END
  nunmap =
  nunmap ==
  xunmap =
  unlockvar g:AutoCenter_On
  let g:AutoCenter_On = 0
  lockvar g:AutoCenter_On
endfunction

function! s:center()
  " Remember the cursor position relative to current indent for restoring after
  " centering the line.
  let l:curpos = col('.') - indent('.')
  center
  " Put cursor back on the same char it is on before centering.
  call cursor('.', l:curpos + indent('.'))
endfunction

function! s:isUndoRedo()
  let l:maxChangeNr = split(split(execute('undolist'), "\n")[-1], ' \+')[0]
  return changenr() < l:maxChangeNr
endfunction

function! s:opCenter(type)
  '[,']center
endfunction

" Restore 'cpoptions' setting {{{
let &cpoptions = s:save_cpoptions
unlet s:save_cpoptions
" }}}
