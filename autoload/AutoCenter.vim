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
    autocmd TextChanged,TextChangedI * call s:center()
  augroup END
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
  unlockvar g:AutoCenter_On
  let g:AutoCenter_On = 0
  lockvar g:AutoCenter_On
endfunction

function! s:isUndoRedo()
  let l:maxChangeNr = split(split(execute('undolist'), "\n")[-1], ' \+')[0]
  return changenr() < l:maxChangeNr
endfunction

function! s:center()
  " !!Warning!! Undo and redo also change the text, triggering the AutoCenter
  " autocmd, which changes the effect of undo and BREAKS REDO if this function
  " changes the text. So return early in this case.
  if s:isUndoRedo() | return | endif
  " Remember the cursor position relative to current indent for restoring after
  " center the line.
  let l:curpos = col('.') - indent('.')
  center
  " Put cursor back on the same char on which it is before centering.
  call cursor('.', l:curpos + indent('.'))
endfunction

" Todo: ues '=' to center lines in normal and visual mode.
