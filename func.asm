extern pow, exp

global func1
func1:
    push ebp            ; сохранение регистра базового указателя
    mov ebp, esp        ; установка базового указателя
    finit
	fld qword [ebp + 8] ; загрузка x в регистр ST0
	fld qword [ebp + 8] ; загрузка x в регистр ST0

    ; fld st1             ; копирование x из ST0 в ST1
    fmul                ; x*x
    fmul                ; (x*x)*x
    mov esp, ebp        ; восстановление указателя стека
    pop ebp             ; восстановление базового указателя
    ret             