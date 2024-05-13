extern pow, exp

global f2
f2:
    push ebp
    mov ebp, esp
    finit
    fld qword [esp + 8]
    fld qword [esp + 8]
    fld qword [esp + 8]
    fmulp
    fmulp
    mov esp, ebp
    pop ebp
    ret            

global f3
f3:
    push ebp
    mov ebp, esp

	; Вызов pow(2, -x)
    fld qword [ebp+8]
    fchs ; Изменение знака x
	sub esp, 16
    fstp qword [esp + 8] ; Сохранение -x на стек

 	; Загрузка 2 в стек сопроцессора
    fld1
    fld1
    faddp st1
	fstp qword [esp]

	call pow
    add esp, 16

    mov esp, ebp
    pop ebp
    ret

global f1
f1:
    push ebp
    mov ebp, esp

    fld qword [ebp+8]     ; Загружаем x в ST(0)
    fld qword [ebp+8]     ; Загружаем x в ST(0)
    fmulp                 ; ST(0) = x * x
    fld1                  ; Загружаем 1 в ST(0)
    faddp                 ; ST(0) = x * x + 1

	sub esp, 8
	mov dword [esp], 4
    fild dword [esp]
	fxch ; обмен st0 и st1
    fdivp  st1               ; ST(0) = 4 / (x * x + 1)

	fld1
	faddp

	add esp, 8	
    mov esp, ebp
    pop ebp
    ret
