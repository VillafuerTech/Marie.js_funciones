ORG 100
/ Programa para calcular el módulo (dividend % divisor)

/ Leer el dividendo y el divisor desde la entrada del usuario
Input                  / Leer el dividendo
STORE DIVIDEND         / Almacenar en DIVIDEND
Input                  / Leer el divisor
STORE DIVISOR          / Almacenar en DIVISOR

/ Inicializar el resto a cero
LOAD ZERO
STORE REMAINDER

/ Comenzar la operación de módulo
MODULO, LOAD DIVIDEND     / Cargar el dividendo en el AC
SUBT DIVISOR              / Restar el divisor del AC
STORE TEMP1               / Almacenar el resultado en TEMP1
SKIPCOND 800              / Si el resultado es >= 0, continuar
JUMP FINISH               / Si el resultado es negativo, finalizar

STORE DIVIDEND            / Almacenar el nuevo valor del dividendo
JUMP MODULO               / Repetir el ciclo

FINISH, LOAD DIVIDEND     / Cargar el valor final del dividendo (resto)
STORE REMAINDER           / Almacenar en REMAINDER
OUTPUT                    / Imprimir el resultado del módulo
HALT                      / Detener el programa

/ Definición de variables
ZERO, DEC 0
DIVIDEND, DEC 0
DIVISOR, DEC 0
REMAINDER, DEC 0
TEMP1, DEC 0
