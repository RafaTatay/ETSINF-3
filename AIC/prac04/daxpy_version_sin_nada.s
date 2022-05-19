        ; z = a*x + y
        ; Tamaño de los vectores: 64 palabras
        ; Vector x
	.data
x:      .double 0,1,2,3,4,5,6,7,8,9
        .double 10,11,12,13,14,15,16,17,18,19
        .double 20,21,22,23,24,25,26,27,28,29
        .double 30,31,32,33,34,35,36,37,38,39
        .double 40,41,42,43,44,45,46,47,48,49
        .double 50,51,52,53,54,55,56,57,58,59

	; Vector y
y:      .double 100,100,100,100,100,100,100,100,100,100
	.double 100,100,100,100,100,100,100,100,100,100
	.double 100,100,100,100,100,100,100,100,100,100
	.double 100,100,100,100,100,100,100,100,100,100
	.double 100,100,100,100,100,100,100,100,100,100
	.double 100,100,100,100,100,100,100,100,100,100

        ; Vector z
	; 60 elementos son 480 bytes
z:      .space 480

        ; Escalar a
a:      .double 1

        ; El código
	.text

start:

    daddi r1, r0, y ; r1 = direcci ?on de y
    daddi r2, r0, z ; r2 = direcci ?on de z
    daddi r3, r0, x ; r3 = direccion de x
    l.d f0, a(r0) ; f0 = a
    daddi r4, r1, #480 ; 60 elem. son 480 bytes
    
loop:
    l.d f3, 0(r3) ; x cargo primero x asi me quito 1 ciclo de parada
    l.d f1, 0(r1) ; y
    mul.d f4, f3, f0; x * a
    add.d f5, f4, f1 ; y + x*a
    s.d f5,0(r2) ; z = y + x*a
    
    daddi r1, r1, 8 
    daddi r2, r2, 8 
    dsub r5, r4, r1
    daddi r3, r3, 8 
    bnez r5, loop

    trap #0 ; fin programa


