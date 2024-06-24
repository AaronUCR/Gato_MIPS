Juego GATO o 3 en línea

Integrantes:
Aarón Arce Alfaro C30601
Javier Chacón Rosales C32052

Link del repositorio en github:
https://github.com/AaronUCR/Gato_MIPS.git

Descripción del proyecto:
El proyecto está basado en el juego GATO o tambiém llamado 3 en línea, en el cual consiste en un juego de dos jugadores, con un tablero de 3 filas y 3 columnas (9 celdas). El juego consiste en que alguno de los dos jugadores haga una línea de 3 fichas de forma vertical, horizontal o diagonal dentro del tablero, donde los jugadores se van turnando para colocar dichas fichas. Cabe recalcar que si el tablero se llena y ninguno de los dos jugadores ha hecho una línea de tres fichas, se considera un empate. Así mismo, el jugador 1 es representado con la ficha 'X', mientras que el jugador 2 se representa con la ficha 'O', pero por temas del proyecto y el dibujo de las fichas, el jugador 2 se representará con la ficha 'l'.

Instrucciones para ejecutar el programa:
Para ejecutar el programa hay que seguir los siguientes pasos, no sin antes saber como funciona.
Como anteriormente se dijo, el jugador 1 será identificado con la ficha 'X', mientras que el jugador 2 se indentificará con la ficha 'l'.
Las posiciones del tablero van de la siguiente forma:

_1_|_2_|_3_
_4_|_5_|_6_
 7 | 8 | 9

 Pasos para ejecutar un nuevo juego:
 1- Abra el archivo en el IDE MARS.
 2- Presione en "Run" y presione en "Assemble".
 3- Presione en tools y presione en "Bitmap Display".
 4- Setee el "Display Width in Pixels" a 256.
 5- Confirmar que el "Base adress for display" este en 0x10010000 (static data).
 6- Presionar el boton "Connect to MIPS" en el Bitmap Display.
 7- Presione en "Run" y presione en "Go".
 8- Luego de esto comenzara un nuevo juego, donde siempre va a empezar el jugador 1 por defecto.
 9- Cabe recalcar que todos los mensajes del juego y el ingreso de datos del mismo, se hacen desde la consola.
 10- Mantener el Bitmap Display abierto para ver el tablero y como se van colovando las fichas.