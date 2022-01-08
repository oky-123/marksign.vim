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
let g:marksign_signs_to_show = "0123456789abcdefghijklmnopqrstuvwxyz.'^[]{}()ABCDEFGHIJKLMNOPQRSTUVWXYZ"
let g:marksign_enable_periodical_refresh = 0
let g:marksign_sign_texthl = 'Label'
let g:marksign_sign_priority = 0

" Set enable periodical refresh
command! MarksignEnablePeriodicalRefresh call marksign#enable_periodical_refresh()
command! MarksignDisablePeriodicalRefresh call marksign#disable_periodical_refresh()
command! MarksignRefreshSigns call marksign#refresh_signs()

if g:marksign_enable_periodical_refresh
    call marksign#enable_periodical_refresh()
endif
