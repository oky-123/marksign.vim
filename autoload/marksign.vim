" Minimal vim plugin for visualize marks as sign.
" Last Change: 2022 Jan 08
" Maintainer: oky-123 <oky123.ia@gmail.com>

" Avoid conflicts with the 'compatible' option.
let s:save_cpo = &cpo
set cpo&vim

let s:enable_periodical_refresh = 0
let s:signs_defined = 0

" Define signs used in VisibleMark
function! s:define_signs()
    " White list letters
    let sign_list = []
    for i in range(len(g:marksign_signs_to_show))
        call add(sign_list, { "name": "Marksign_" . g:marksign_signs_to_show[i] . "_txt",
            \ "text": g:marksign_signs_to_show[i],
            \ "texthl": g:marksign_sign_texthl })
    endfor

    " Define signs
    call sign_define(sign_list)
endfunction

function! s:clear_signs()
    call sign_unplace('Marksign')
endfunction

" Refresh the display of signs
function! marksign#refresh_signs()
    " If current_buf is not writable, place no sign.
    let writable_current_buffer = &modifiable && !&readonly
    if !writable_current_buffer
        return
    endif

    " Get current buffer
    let current_buf = bufnr('%')

    " Dict for placed sign
    let lnum_sign_placed = {}

    " Get marks
    let global_mark_list = getmarklist()
    let local_mark_list = getmarklist(current_buf)

    call s:clear_signs()
    call s:place_sign_from_existing_marks(current_buf, global_mark_list + local_mark_list, lnum_sign_placed)
endfunction

" for debug
function! PrintMarkList()
    let current_buf = bufnr('%')
    let global_mark_list = getmarklist()
    echo "global_mark_list: "
    for m in global_mark_list
        echo m
    endfor

    let local_mark_list = getmarklist(current_buf)
    echo "local_mark_list: "
    for m in local_mark_list
        echo m
    endfor
endfunction

" Place signs (Only marks defined in s:marksigns_to_show)
function! s:place_sign_from_existing_marks(current_buf, mark_list, lnum_sign_placed)
    for m in a:mark_list
        let mark = m['mark'][1]
        let lnum = m['pos'][1]

        " Check if the mark is included in the white lists
        if matchstr(escape(g:marksign_signs_to_show, '.'), escape(mark, '.')) == ''
            continue
        endif

        " If no sign has placed at the lnum, place the sign
        if !has_key(a:lnum_sign_placed, lnum)
            call sign_place(0, 'Marksign', 'Marksign_' . mark . '_txt', a:current_buf,
                \ {'lnum' : lnum, 'priority': g:marksign_sign_priority})
            let a:lnum_sign_placed[lnum] = 1
        endif
    endfor

endfunction

" Enable periodical refresh
function! marksign#enable_periodical_refresh()
    if !s:signs_defined
        call s:define_signs()
        let s:signs_defined = 1
    endif

    if !s:enable_periodical_refresh
        augroup marksign
            autocmd CursorHold * call marksign#refresh_signs()
        augroup END
        let s:enable_periodical_refresh = 1
    endif
endfunction

" Disable priodical refresh
function! marksign#disable_periodical_refresh()
    if s:enable_periodical_refresh
        call s:clear_signs()
        autocmd! marksign
        let s:enable_periodical_refresh = 0
    endif
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
