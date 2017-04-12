" Change the 'cpoptions' option temporarily {{{
" Set to its Vim default value and restore it later.
" This is to enable line-continuation within this script.
" Refer to :help use-cpo-save.
let s:save_cpoptions = &cpoptions
set cpoptions&vim
" }}}

function! AutoCenter#On() "{{{
  if g:AutoCenter_On
    echohl Error
    echo 'AutoCenter is already on.'
    echohl NONE
    return
  endif
  augroup AutoCenter
    autocmd!
    " !!Note!! Undo and redo also change the text, triggering this autocmd,
    " which changes the effect of undo and BREAKS further REDO if making new
    " text changes. So we don't center text in these cases.
    autocmd TextChanged,TextChangedI *
    \ if !s:isUndoRedo() | call s:center() | endif
    autocmd BufEnter * call s:upMaxChangeNr()
  augroup END
  call s:upMaxChangeNr()
  call s:saveMapping() " Save mappings for later restoring.
  call s:addMapping()
  call s:markState(1)
endfunction "}}}

function! AutoCenter#Off() "{{{
  if !g:AutoCenter_On
    echohl Error
    echo 'AutoCenter is already off.'
    echohl NONE
    return
  endif
  augroup AutoCenter
    autocmd!
  augroup END
  call s:delMapping()
  call s:loadMapping() " Restore the mappings saved earlier.
  call s:markState(0)
endfunction "}}}

function! s:isUndoRedo() "{{{
  return changenr() <= b:AutoCenter_MaxChangeNr
endfunction "}}}

function! s:center() "{{{
  " Remember the cursor position relative to current indent for restoring after
  " centering the line.
  let l:curpos = col('.') - indent('.')
  center
  " Put cursor back on the same char it is on before centering.
  call cursor('.', l:curpos + indent('.'))
  " A change in Insert mode or Replace mode is in progress.
  " Only update the max change number when a change is done.
  if mode() !~ '^[iR]'
    call s:upMaxChangeNr()
  endif
endfunction "}}}

function! s:opCenter(type) "{{{
  '[,']center
endfunction "}}}

function! s:addMapping() "{{{
  " Ues '=' key to center lines in Normal and Visual mode.
  nnoremap <silent> = :set opfunc=<SID>opCenter<CR>g@
  nnoremap <silent> == :center<CR>
  xnoremap <silent> = :center<CR>
endfunction "}}}

function! s:delMapping() "{{{
  nunmap =
  nunmap ==
  xunmap =
endfunction "}}}

function! s:loadMapping() "{{{
  " This requires the 'SaveMapping' plugin
  " (https://github.com/Ace-Who/vim-MappingMem).
  if exists(':LoadMapping') == 2
    silent LoadMapping '=', 'n', 'global'
    silent LoadMapping '==', 'n', 'global'
    silent LoadMapping '=', 'x', 'global'
  endif
endfunction "}}}

function! s:saveMapping() "{{{
  " This requires the 'SaveMapping' plugin
  " (https://github.com/Ace-Who/vim-MappingMem).
  if exists(':SaveMapping') == 2
    silent SaveMapping '=', 'n', 'global'
    silent SaveMapping '==', 'n', 'global'
    silent SaveMapping '=', 'x', 'global'
  endif
endfunction "}}}

function! s:markState(state) "{{{
  unlockvar g:AutoCenter_On
  let g:AutoCenter_On = a:state
  lockvar g:AutoCenter_On
endfunction "}}}

function! s:upMaxChangeNr() "{{{
  unlockvar b:AutoCenter_MaxChangeNr
  let l:undolist = split(execute('undolist'), "\n")
  let b:AutoCenter_MaxChangeNr = split(l:undolist[-1], ' \+')[0]
  lockvar b:AutoCenter_MaxChangeNr
endfunction "}}}

if !exists('g:AutoCenter_On') | call s:markState(0) | endif

" Restore 'cpoptions' setting {{{
let &cpoptions = s:save_cpoptions
unlet s:save_cpoptions
" }}}
