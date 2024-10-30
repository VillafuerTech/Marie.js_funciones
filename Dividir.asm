ORG 100
/ Programa para calcular la división entera de 'num' por 'divisor'

/ Inicialización
LOAD ZERO
STORE result        / Inicializar el resultado (cociente) a 0

/ Ingresar el número a dividir (dividendo)
Input               / Leer el dividendo
STORE num           / Almacenar en 'num'

/ Ingresar el divisor
Input               / Leer el divisor
STORE divisor       / Almacenar en 'divisor'

/ Comenzar la división entera
DIVIDE, LOAD num    / Cargar 'num' en el AC
        Subt divisor / Restar el divisor del AC
        Skipcond 000 / Si AC == 0, significa que la división es exacta
        Jump AUX     / Saltar a AUX si la resta es mayor o igual a 0

        LOAD num     / Cargar 'num' en el AC nuevamente
        Skipcond 400 / Si AC < 0, manejar números negativos
        Jump AUX2    / Saltar a AUX2 para manejar el caso negativo

        Load result  / Cargar el cociente en el AC
        Store num    / Almacenar el cociente en 'num'
        Jump CONTINUE2 / Ir a CONTINUE2 para mostrar el resultado final

/ Subrutina para manejar números positivos
AUX,    STORE num   / Almacenar el nuevo 'num' después de restar el divisor
        LOAD result / Cargar el resultado actual en el AC
        ADD ONE     / Incrementar el resultado en 1
        STORE result / Almacenar el nuevo resultado
        Jump DIVIDE / Repetir el ciclo de división

/ Subrutina para manejar números negativos
AUX2,   LOAD result  / Cargar el cociente en el AC
        STORE num    / Almacenar el cociente en 'num'
        JUMP CONTINUE2 / Ir a CONTINUE2 para mostrar el resultado final

/ Imprimir el resultado final
CONTINUE2, LOAD num / Cargar el cociente final en el AC
           Output   / Imprimir el resultado
           HALT     / Detener el programa

/ Definición de variables
num, DEC 0
result, DEC 0
divisor, DEC 0
ONE, DEC 1
ZERO, DEC 0
