global func1
func1:
    push ebp
    mov ebp, esp
    finit
    fld qword [ebp + 8]
    sub esp, 8
    mov dword [esp], -1
    fild dword [esp]
    fmulp
    fstp qword [esp]
    call exp
    add esp, 8
    pop ebp
    ret