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
;Ponemos + 3 iteraciones (+8 / +16 / 24) porque si ejecutamos el rpogrqama sin 
;    loop unrolling veremos que hay 3 ciclos de parada. Asi ya no habrá miguno :)

    l.d f1, 0(r3) ; x
    l.d f3, 8(r3) ; x
    l.d f5, 16(r3) ; x
    l.d f7, 24(r3) ; x
    
    l.d f2, 0(r1) ; y
    l.d f4, 8(r1) ; y
    l.d f6, 16(r1) ; y
    l.d f8, 24(r1) ; y
   
    mul.d f10, f1, f0; x * a
    mul.d f12, f3, f0; x * a
    mul.d f14, f5, f0; x * a
    mul.d f16, f7, f0; x * a
    
    add.d f11, f2, f10 ; y + x*a
    add.d f13, f4, f12 ; y + x*a
    add.d f15, f6, f14 ; y + x*a
    add.d f17, f8, f16 ; y + x*a
    
    s.d f11,0(r2) ; z = y + x*a
    s.d f13,8(r2) ; z = y + x*a
    s.d f15,16(r2) ; z = y + x*a
    s.d f17,24(r2) ; z = y + x*a
    
    daddi r1, r1, #32 ; 4 veces 8 = 32
    daddi r2, r2, #32
    dsub r5, r4, r1
    daddi r3, r3, #32
    bnez r5, loop

    trap #0

