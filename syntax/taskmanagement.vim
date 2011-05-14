" Vim syntax file
" Language:	Project
" Maintainer:	Abhijit Nadgouda (http://ifacethoughts.net/)

syntax clear

syn match projectTag            "\*[a-zA-z]*\*"
syn match projectJump           "|[a-zA-z]*|"

syn match projectDate           "=\d\d\d\d\d\d\d\d" contained
syn match projectDone           "=done" contained
syn match projectCancel         "=cancel" contained
syn match projectHigh           "=high" contained

syn match projectKeyword        ":phone" contained
syn match projectKeyword        ":email" contained
syn match projectKeyword        ":chat" contained
syn match projectKeyword        ":meet" contained
syn match projectKeyword        ":design" contained
syn match projectKeyword        ":code" contained
syn match projectKeyword        ":test" contained
syn match projectKeyword        ":doc" contained

syn match projectTask           "\-\s.*" contains=projectDate,projectDone,projectCancel,projectHigh,projectKeyword
syn match projectTaskH          "\-\s.*=high" contains=projectDate,projectHigh,projectKeyword
syn match projectTaskC          "\-\s.*=cancel" contains=projectCancel,projectKeyword
syn match projectTaskD          "\-\s.*=done$" contains=projectDate,projectDone,projectKeyword
syn region projectTaskDoc       matchgroup=Comment start=/\[/ end=/\]/

hi def link projectTag          String
hi def link projectJump         String

hi def link projectDate         Constant
hi def link projectDone         SpecialChar
hi def link projectCancel       SpecialChar
hi def link projectHigh         SpecialChar
hi def link projectKeyword      SpecialChar

hi def link projectTask         Statement
hi def link projectTaskDoc      Comment
hi def link projectTaskD        Comment
hi def link projectTaskH        Special
hi def link projectTaskCancel   Comment

