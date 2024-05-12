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
    push ebp            ; сохранение значения базового указателя
    mov ebp, esp        ; установка нового базового указателя
    
    fld1                ; загрузка значения 1 в регистр FPU ST0
    fld dword [ebp + 8] ; загрузка значения x из стека в регистр FPU ST0
    fchs                ; инверсия знака x (теперь -x)
    fstp st1            ; перемещение -x из ST0 в ST1 для pow
    mov eax, 1          ; передача 1 в eax для использования в функции pow
    call pow            ; вызов функции pow для вычисления 2^(-x)
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