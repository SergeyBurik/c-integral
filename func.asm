extern pow, exp

global func1
func1:
    push ebp
    mov ebp, esp
    finit
    fld qword [ebp + 8] ; load x
    sub esp, 16
    mov dword [esp], -1
    fild dword [esp]
    fmulp ; x = -x

    fstp qword [esp]

    mov dword [esp + 8], 2
    fild dword [esp + 8]
    
    call pow
    add esp, 16
    pop ebp
    ret