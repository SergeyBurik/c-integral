extern pow, exp

global func1
func1:
    push ebp            
    mov ebp, esp       
    finit
	fld qword [ebp + 8] 
	fld st0 ; загрузка x в регистр ST1

    fmul                ; x*x
    fmulp                ; (x*x)*x
	fstp qword[ebp]
    mov esp, ebp        
    pop ebp            
    ret             