global func1
func1:
	push ebp
	mov ebp, esp
	finit
	fld qword[ebp + 8]
	fmul st0, st0
	fmul 
	fstp qword [ebp + 8]
	pop ebp
    ret