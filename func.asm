extern pow, exp

global func1
func1:
    push ebp            ; сохранение регистра базового указателя
    mov ebp, esp        ; установка базового указателя
    finit
	fld qword [ebp + 8] ; загрузка x в регистр ST0
	fld st0 ; загрузка x в регистр ST1

    fmul                ; x*x
    fmulp                ; (x*x)*x
	fstp qword [eax]
    mov esp, ebp        ; восстановление указателя стека
    pop ebp             ; восстановление базового указателя
    ret             