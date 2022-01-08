" Minimal vim plugin for visualize marks as sign.
" Last Change: 2022 Jan 08
" Maintainer: oky-123 <oky123.ia@gmail.com>

" Check if your vim supports signs
if !has('signs') || &cp
  finish
endif

" if exists('g:loaded_marksign')
"   finish
" endif
" let g:loaded_marksign_plugin = 1

" variables
let s:marksign_signs_to_show = "abcdefghijklmnopqrstuvwxyz.'^ABCDEFGHIJKLMNOPQRSTUVWXYZ"
let s:marksign_sign_texthl = 'Label'
let s:marksign_refresh_signs_periodically = 1
let s:marksign_sign_priority = 0


" Set autocmd to refresh sign when cursor holding
augroup marksign_autocmds
    autocmd CursorHold * call marksign#refresh_signs()
augroup END
