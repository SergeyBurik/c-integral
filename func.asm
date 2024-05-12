extern pow, exp

global func1
func1:
    push ebp
    mov ebp, esp
    finit
    fld qword [esp + 8]
    fld qword [esp + 8]
    fld qword [esp + 8]
    fmulp
    fmulp
    leave
    ret            

global func2
func2:
    push ebp
    mov ebp, esp

    ; Загрузка аргумента x в стек сопроцессора
    fld qword [ebp+8]

    ; Загрузка 2 в стек сопроцессора
    fld1
    fld1
    faddp st1

    ; Вызов pow(2, -x)
    fchs ; Изменение знака x
    fstp qword [esp] ; Сохранение -x на стек
    call pow
    add esp, 8

    ; Возврат результата
    mov esp, ebp
    pop ebp
    ret

global func3
func3:
    push ebp
    mov ebp, esp

    fld qword [ebp+8]     ; Загружаем x в ST(0)
    fmul st0              ; ST(0) = x * x
    fld1                  ; Загружаем 1 в ST(0)
    faddp                 ; ST(0) = x * x + 1
    fld1                  ; Загружаем 1 в ST(0)
    fld qword [four]     ; Загружаем 4 в ST(0)
    fdivp                 ; ST(0) = 4 / (x * x + 1)
    faddp                 ; ST(0) = 1 + 4 / (x * x + 1)

    mov esp, ebp
    pop ebp
    ret

section .data
four: dq 4.0