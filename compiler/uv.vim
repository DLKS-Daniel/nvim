if exists("current_compiler")
    finish
endif
let current_compiler = "uv"

CompilerSet makeprg=uv\ \run\ %
CompilerSet errorformat=%f:%l:%c:\ %m
