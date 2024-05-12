extern pow, exp

global func1
func1:
    push ebp            
    mov ebp, esp       
    finit
    fld qword [ebp + 8] 
    fld st0 ; загрузка x в регистр ST1

    fmul                ; x*x
    fmul                ; (x*x)*x
    fstp
    mov esp, ebp        
    pop ebp            
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
    
    ; обработка результата вычислений
    fstp QWORD [ebp - 8] ; сохранение результата в переменной result

    mov esp, ebp        ; очистка стека и завершение функции
    pop ebp
    ret

global func3
func3:
    push ebp
    mov ebp, esp

    fld qword [ebp + 8]     ; загружаем x в ST(0)
    fmul st0                ; x * x
    fadd qword [one]        ; x * x + 1
    fdiv qword [four]       ; 4 / (x * x + 1) 
    fadd qword [one]        ; 1 + 4 / (x * x + 1)

    mov esp, ebp
    pop ebp
    ret