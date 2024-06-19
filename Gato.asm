.data
	miMensaje: .asciiz "Proyecto Gato en MIPS"
.text 
	li $v0, 4
	la $a0, miMensaje
	syscall
