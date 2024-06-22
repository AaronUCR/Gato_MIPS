.data
	tablero: .word 0, 0, 0, 0, 0, 0, 0, 0, 0
	mensajeInicial: .asciiz "Bienvenido al juego GATO, ganas haciendo una linea vertical, horizontal o diagonal.\n"
	mensajeJugador1: .asciiz "Turno del jugador 1 (X), realice el movimiento...\n"
	mensajeJugador2: .asciiz "Turno del jugador 2 (l), realice el movimiento...\n"
	jugadaInvalida: .asciiz "Jugada invalida, intente de nuevo...\n"
	ganadorJugador1: .asciiz "Jugador 1 (X) ha ganado...\n"
	ganadorJugador2: .asciiz "Jugador 2 (l) ha ganado...\n"
.text 
Comienzo:
	la $s0, tablero
	li $s1, 1
	li $v0, 4
	la $a0, mensajeInicial
	syscall
	jal imprimir_tablero
	
# Llamada a las funciones para que el jugador 1 realice el movimiento o gane (X)
jugador_1:
	# Mensaje para que el jugador 1 realice un movimiento
	li $v0, 4
	la $a0, mensajeJugador1
	syscall
	
	# Se ingresa la posicion donde el jugador quiere jugar
	li $v0, 5
	syscall
	move $a0, $v0
	move $s2, $v0
	
	#Se verifica que la jugada sea valida
	jal verificar_jugada
	beq $v0, 1, jugada_validada1
		li $v0, 4
		la $a0, jugadaInvalida
		syscall
		j jugador_1
	jugada_validada1:
	jal jugada_jugador1
	
# Llamada a las funciones correspondientes de jugador 2 (l)
jugador_2:
	# Mensaje para que el jugador 1 realice un movimiento
	li $v0, 4
	la $a0, mensajeJugador2
	syscall
	
	# Se ingresa la posicion donde el jugador quiere jugar
	li $v0, 5
	syscall
	move $a0, $v0
	move $s2, $v0
	
	#Se verifica que la jugada sea valida
	jal verificar_jugada
	beq $v0, 1, jugada_validada2
		li $v0, 4
		la $a0, jugadaInvalida
		syscall
		j jugador_2
	jugada_validada2:
	jal jugada_jugador2
Fin:
	li $v0, 10
	syscall

# Funcion que imprime el tablero en bitmap
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

# Funcion que ejecuta la jugada para el jugador 1 y la guarda dentro de tablero
jugada_jugador1:
	addi $s1, $s1, 1
	la $t0, tablero
	li $t1, 1
	li $t2, 4
	move $t3, $s2
	sub $t3, $t3, 1
	mult $t3, $t2
	mflo $t3
	add $t0, $t0, $t3
	sw $t1, 0($t0)
jr $ra
	
# Funcion que ejecuta la jugada para el jugador 2 y la guarda dentro de tablero
jugada_jugador2:
	addi $s1, $s1, 1
	la $t0, tablero
	li $t1, 2
	li $t2, 4
	move $t3, $s2
	sub $t3, $t3, 1
	mult $t3, $t2
	mflo $t3
	add $t0, $t0, $t3
	sw $t1, 0($t0)
jr $ra

# Funcion que verifica si las jugadas son correctas
verificar_jugada:
	# Checa si el número es >= 1
	move $t0, $a0
	bge $t0, 1, validez_1
	j jugada_invalida
	
	# Checa si el número es <= 9	
validez_1:
	ble $t0, 9, validez_2
	j jugada_invalida
	
validez_2:
	# Checa si el campo ya fue llenado (Arreglar)
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

# TO DO: Verificar empate y gane, dibujar en mips X y l
