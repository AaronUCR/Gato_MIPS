.data
	tablero: .word 0, 0, 0, 0, 0, 0, 0, 0, 0
	mensajeInicial: .asciiz "Bienvenido al juego GATO, ganas haciendo una linea vertical, horizontal o diagonal.\n"
	
.text 
main:
	li $v0, 4
	la $a0, mensajeInicial
	syscall
	jal imprimir_tablero
	
	
imprimir_tablero:
# Dibujando linea horizontal 1
	# Cargando el color del tablero (rojo)
	li $t1, 0xFF0000
	# Se especifica la direccion donde se desplegara la fila 1 desde bitmap
	li $t0, 0x10010000
	# Se setean los pixeles
	li $t5, 1024
	li $t6, 80
	mult $t5, $t6
	mflo $t6
	add $t0, $t0, $t6
	addi $t0, $t0, 56
	# Contador en 0
	li $t2, 0
	linea_horizontal_1:
		beq $t2, 224, Fin_linHori_1
			sw $t1, 0($t0)
			addi $t0, $t0, 4
			addi $t2, $t2, 1
		j linea_horizontal_1
	Fin_linHori_1:
# Dibujando linea horizontal 2
	# Se especifica la direccion donde se desplegara la fila 2 desde bitmap
	li $t0, 0x10010000
	# Se setean los pixeles
	li $t5, 1024
	li $t6, 150
	mult $t5, $t6
	mflo $t6
	add $t0, $t0, $t6
	addi $t0, $t0, 56
	# Contador en 0
	li $t2, 0
	linea_horizontal_2:
		beq $t2, 224, Fin_linHori_2
			sw $t1, 0($t0)
			addi $t0, $t0, 4
			addi $t2, $t2, 1
		j linea_horizontal_2
	Fin_linHori_2:
# Dibujando linea vertical 1
	# Se especifica la direccion donde se desplegara la columna 1 desde bitmap
	li $t0, 0x10010000
	# Seteo de pixeles
	li $t6, 10
	mult $t5, $t6
	mflo $t6
	add $t0, $t0, $t6
	addi $t0, $t0, 320
	# Contador en 0
	li $t2, 0
	linea_vertical_1:
		beq $t2, 200, Fin_linVert_1
			addi $t0, $t0, 1024
			sw $t1, 0($t0)
			addi $t2, $t2, 1
		j linea_vertical_1
	Fin_linVert_1:
# Dibujando linea vertical 2
	# Se especifica la direccion donde se desplegara la columna 2 desde bitmap
	li $t0, 0x10010000
	# Seteo de pixeles
	li $t6, 10
	mult $t5, $t6
	mflo $t6
	add $t0, $t0, $t6
	addi $t0, $t0, 660
	# Contador en 0
	li $t2, 0
	linea_vertical_2:
		beq $t2, 200, Fin_linVert_2
			addi $t0, $t0, 1024
			sw $t1, 0($t0)
			addi $t2, $t2, 1
			j linea_vertical_2
		Fin_linVert_2:
jr $ra

checar_jugada_valida:
	# Checa si el número es >= 1
	move $t0, $a0
	bge $t0, 1, validez_1
	
	j jugada_invalida
	

	# Checa si el número es <= 9	
validez_1:
	ble $t0, 9, validez_2
	j jugada_invalida
	
	
validez_2:
	# Checa si el campo ya fue llenado
	subu $t1, $t0, 1
	li $t2, 4 
	mult $t1, $t2
	mflo $t3
	la $t4, tablero
	add $t4, $t4, $t3
	lw $t5, 0($t4) 
		beq $t5, $0, jugada_valida 
	
	
jugada_invalida:
	li $v0, 0
	jr $ra
	
	
jugada_valida:
	li $v0, 1
	jr $ra

