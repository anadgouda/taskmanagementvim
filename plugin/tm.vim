" File: tm.vim
" Author: Abhijit Nadgouda (anadgouda@gmail.com)
" Version: 1
" Last Modified: May 05, 2011
" Copyright: Copyright (C) 2011 Abhijit nadgouda
"            Permission is hereby granted to use and distribute this code,
"            with or without modifications, provided that this copyright
"            notice is copied with it. Like anything else that's free, tm.vim
"            is provided *as is* and comes with no warranty of kind, either
"            expressed or implied. In no event will the copyright holder be
"            liable for any damages resulting from the use of the software.
"
" The "Task Management" plugin enables vim users to manage their daily tasks
" using the GTD (Getting Things Done) mechanisms through vim. You can get more
" information about it at:
"

let s:keepcpo = &cpo
set cpo&vim

if !exists('g:loaded_taskmanagement') || &cp
    if !exists('*strftime')
    	echomsg 'TaskManagement: Vim strftime() built-in function is not available. '
                \ 'Plugin is not loaded.'
        let loaded_taskmanagement = 'no'
        let &cpo = s:cpo_save
        finish
    endif

    if !exists('Taskmanagement_Dir')
    	let Taskmanagement_Dir = '~/wiki/'
    endif

    command! Today :call Todo(0)
    command! Tomorrow :call Todo(1)
    command! Dayafter :call Todo(2)
    command! Week :call Todo(0, 7)
    command! LastWeek :call Todo(-7, 0)
    command! Yesterday :call Todo(-1, 0)

    autocmd BufWritePost g:TaskManagement_Dir/*.txt :helptags g:TaskManagement_Dir
endif

function! Todo(day, ...)
    " Doing the first separately to clear the location list.
    let _date = strftime("%d%m%Y", localtime()+a:day*86400)
    try
        exec "lvimgrep /=" . _date . "/j ~/wiki/*.txt"
    catch /^Vim(\a\+):E480:/
    endtry

    if a:0 > 0
        " These commands will add results to the location list.
        for offset in range(a:day+1, a:1)
            let _date = strftime("%d%m%Y", localtime()+offset*86400)
            try
                exec "lvimgrepadd /=" . _date . "/j ~/wiki/*.txt"
            catch /^Vim(\a\+):E480:/
            endtry
        endfor
    endif

    exec "lw"
endfunction
