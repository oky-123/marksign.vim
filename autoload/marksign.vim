" Avoid conflicts with the 'compatible' option.
let s:save_cpo = &cpo
set cpo&vim

" Script variables
let s:enable_periodical_refresh = 0
let s:signs_defined = 0

" Define signs used in marksign.vim
function! s:define_signs()
    " White list letters
    let sign_list = []
    for i in range(len(g:marksign_marks_to_show))
        call add(sign_list, { "name": "Marksign_" . g:marksign_marks_to_show[i] . "_txt",
            \ "text": g:marksign_marks_to_show[i],
            \ "texthl": g:marksign_sign_texthl })
    endfor

    " Define signs
    call sign_define(sign_list)
endfunction

function! s:clear_signs()
    call sign_unplace('Marksign')
endfunction

" Place signs (Only marks defined in s:marksign_marks_to_show)
function! s:place_sign_from_existing_marks(current_buf, mark_list, lnum_sign_placed)
    let mark_list = deepcopy(a:mark_list)
    for i in range(len(g:marksign_marks_to_show))
        let mark = g:marksign_marks_to_show[i]
        " List of checked idx in mark_list
        let checked_idx = -1

        " Place sign if the mark in mark_list is included in g:marksign_marks_to_show
        for j in range(len(mark_list))
            let m = mark_list[j]
            if m['mark'][1] ==# mark
                let pos = m['pos'][1]
                if !has_key(a:lnum_sign_placed, pos)
                    let a:lnum_sign_placed[pos] = 1
                    call sign_place(0, 'Marksign', 'Marksign_' . mark . '_txt', a:current_buf,
                        \ {'lnum' : pos, 'priority': g:marksign_sign_priority})
                " 対応lineにsignがlimit分設定されていないことをチェック
                " Check if the count of placed sign at pos is not greater than g:marksign_sign_num
                elseif a:lnum_sign_placed[pos] < g:marksign_sign_num
                    let a:lnum_sign_placed[pos] += 1
                    call sign_place(0, 'Marksign', 'Marksign_' . mark . '_txt', a:current_buf,
                        \ {'lnum' : pos, 'priority': g:marksign_sign_priority})
                endif
                let checked_idx = j
                break
            endif
        endfor
    endfor
endfunction

" Refresh the display of signs
function! marksign#refresh_signs()
    if !s:signs_defined
        call s:define_signs()
        let s:signs_defined = 1
    endif

    " If current_buf is not writable, place no sign.
    let writable_current_buffer = &modifiable && !&readonly
    if !writable_current_buffer
        return
    endif

    " Get current buffer
    let current_buf = bufnr('%')

    " Dict for placed sign
    let lnum_sign_placed = {}

    " Get marks in this buffer
    let global_mark_list = filter(getmarklist(), {idx, val -> val['pos'][0] == current_buf})
    let local_mark_list = getmarklist(current_buf)

    call s:clear_signs()
    call s:place_sign_from_existing_marks(current_buf, global_mark_list + local_mark_list, lnum_sign_placed)
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

" for debug
function! marksign#print_mark_list()
    let current_buf = bufnr('%')
    echo current_buf

    let global_mark_list = filter(getmarklist(), {idx, val -> val['pos'][0] == current_buf})
    echo 'global_mark_list: '
    for m in global_mark_list
        echo m
    endfor

    let local_mark_list = getmarklist(current_buf)
    echo 'local_mark_list: '
    for m in local_mark_list
        echo m
    endfor
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
