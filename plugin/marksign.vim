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

" Variables
let g:marksign_signs_to_show = "abcdefghijklmnopqrstuvwxyz.'^ABCDEFGHIJKLMNOPQRSTUVWXYZ"
let g:marksign_sign_texthl = 'Label'
let g:marksign_refresh_signs_periodically = 1
let g:marksign_sign_priority = 0

" Set enable periodical refresh
command! MarksignEnablePeriodicalRefresh call marksign#enable_periodical_refresh()
command! MarksignDisablePeriodicalRefresh call marksign#disable_periodical_refresh()
