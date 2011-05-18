" File: taskmanagement.vim
" Author: Abhijit Nadgouda (abhijit@ifacethoughts.net)
" Version: 1
" Last Modified: May 14, 2011
" Copyright: Copyright (C) 2011 Abhijit Nadgouda
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

    if !exists('$VIMTASKMANAGEMENTDIR')
    	let $VIMTASKMANAGEMENTDIR = '~/wiki/'
    endif

    command! Today :call Todo(0)
    command! Tomorrow :call Todo(1)
    command! Dayafter :call Todo(2)
    command! Week :call Todo(0, 7)
    command! LastWeek :call Todo(-7, 0)
    command! Yesterday :call Todo(-1, 0)
    command! Pending :call PendingTodo(7)

    autocmd BufWrite $VIMTASKMANAGEMENTDIR/*.txt :helptags $VIMTASKMANAGEMENTDIR
    autocmd BufRead,BufNewFile $VIMTASKMANAGEMENTDIR/*.txt :set filetype=taskmanagement
endif

function! Todo(day, ...)
    " Doing the first separately to clear the location list.
    let _date = strftime("%d%m%Y", localtime()+a:day*86400)
    try
        exec "lvimgrep /=" . _date . "/j " . $VIMTASKMANAGEMENTDIR . "/*.txt"
    catch /^Vim(\a\+):E480:/
    endtry

    if a:0 > 0
        " These commands will add results to the location list.
        for offset in range(a:day+1, a:1)
            let _date = strftime("%d%m%Y", localtime()+offset*86400)
            try
                exec "lvimgrepadd /=" . _date . "/j " . $VIMTASKMANAGEMENTDIR . "/*.txt"
            catch /^Vim(\a\+):E480:/
            endtry
        endfor
    endif

    exec "lw"
endfunction

function! PendingTodo(days)
    let _date = strftime("%d%m%Y", localtime()-86400)
    try
        exec "lvimgrep /.*=" . _date . "\\(.*=done\\)\\@!.*$/j ". $VIMTASKMANAGEMENTDIR . "/*.txt"
    catch /^Vim(\a\+):E480:/
    endtry

    if a:days > 1
        for offset in range(2, a:days)
            let _date = strftime("%d%m%Y", localtime()-offset*86400)
            try
                exec "lvimgrepadd /.*=" . _date . "\\(.*=done\\)\\@!.*$/j " . $VIMTASKMANAGEMENTDIR . "/*.txt"
            catch /^Vim(\a\+):E480:/
            endtry
        endfor
    endif

    exec "lw"
endfunction
