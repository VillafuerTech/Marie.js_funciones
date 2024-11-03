            ORG 100

            /***********************
             * Programa para imprimir cualquier número en MARIE
             * Este programa lee un número entero ingresado por el usuario
             * y lo imprime dígito por dígito utilizando llamadas a subrutinas.
             * Soporta números de hasta 5 dígitos.
             ***********************/

            / Leer el número de entrada y preparar variables
            Input                   
            Store num               / Almacenar en 'num'
            Store t                 / Almacenar en 't' (copia del número original)
            Load ONE
            Store digit_counter     / Inicializar el contador de dígitos a 1

/ Inicio del proceso de inversión y almacenamiento de dígitos
INVERSE,    Load num                / Cargar 'num' en el acumulador (AC)
            Store t                 / Actualizar 't' con el valor de 'num'
            Skipcond 400            / Si AC == 0, saltar a 'PRINT'
            Jump MODULE             / Si AC != 0, saltar a 'MODULE' para obtener el módulo
            Jump PRINT              / Si AC == 0, ir a imprimir (el número es cero)

/ Almacenar el dígito obtenido en las variables N1 a N5
RETURN_MODULE, Load num             / Cargar 'num' en AC

            / Almacenar 'num' en N1-N5 basado en 'digit_counter'
            Load digit_counter
            Subt ONE
            Skipcond 800            / Si digit_counter - 1 < 0, continuar
            Jump StoreInN1

            Load digit_counter
            Subt TWO
            Skipcond 800            / Si digit_counter - 2 < 0, continuar
            Jump StoreInN2

            Load digit_counter
            Subt Three
            Skipcond 800            / Si digit_counter - 3 < 0, continuar
            Jump StoreInN3

            Load digit_counter
            Subt Four
            Skipcond 800            / Si digit_counter - 4 < 0, continuar
            Jump StoreInN4

            Load digit_counter
            Subt Five
            Skipcond 800            / Si digit_counter - 5 < 0, continuar
            Jump StoreInN5

            Jump OverFlow           / Si digit_counter > 5, desbordamiento

/ Almacenar el dígito en la variable correspondiente
StoreInN1,  Load num
            Store N1
            Jump AfterStore

StoreInN2,  Load num
            Store N2
            Jump AfterStore

StoreInN3,  Load num
            Store N3
            Jump AfterStore

StoreInN4,  Load num
            Store N4
            Jump AfterStore

StoreInN5,  Load num
            Store N5
            Jump AfterStore

OverFlow,   Halt                    / Detener el programa si hay desbordamiento

/ Preparar para el siguiente dígito
AfterStore, Load digit_counter
            Add ONE
            Store digit_counter

            / Continuar con el resto del programa
            Load t                  / Cargar 't' (número original)
            Store num               / Restaurar 'num' con el valor original
            Load ZERO               / Cargar 0 en AC
            Store result            / Inicializar 'result' a 0
            Jump DIVIDE             / Saltar a 'DIVIDE' para obtener el siguiente dígito

/ Verificar si se ha terminado el proceso
ISFINAL,    Skipcond 400            / Si AC == 0, saltar a 'PRINT'
            Jump INVERSE            / Si AC != 0, repetir el proceso
            Jump PRINT              / Si AC == 0, saltar a imprimir

/ Obtener el módulo del número (dígito menos significativo)
MODULE,     Load num                / Cargar 'num' en AC
            Skipcond 400            / Si AC == 0, saltar a 'RETURN_MODULE'
            Jump MODULE_ALGORITHM   / Si AC != 0, calcular el módulo
            Jump RETURN_MODULE      / Si AC == 0, almacenar el dígito obtenido

/ Algoritmo para calcular el módulo (num % 10)
MODULE_ALGORITHM, Subt TEN          / AC = AC - 10
            Store TEMP1             / Almacenar el resultado en 'TEMP1'
            Skipcond 000            / Si AC == 0, saltar
            Store num               / Actualizar 'num' con el valor actual de AC
            Load num                / Cargar 'num' en AC
            Skipcond 800            / Si AC < 0, saltar
            Jump MODULE             / Si AC >= 0, repetir el proceso
            Load TEMP1              / Cargar 'TEMP1' en AC
            Skipcond 000            / Si AC == 0, saltar
            Jump MODULE             / Repetir el proceso
            Add TEN                 / AC = AC + 10 (ajustar si nos pasamos)
            Store num               / Almacenar el dígito obtenido en 'num'
            Jump RETURN_MODULE      / Volver a 'RETURN_MODULE' para almacenar el dígito

/ División entera del número entre 10 (num = num / 10)
DIVIDE,     Load num                / Cargar 'num' en AC
            Subt TEN                / AC = AC - 10
            Skipcond 000            / Si AC == 0, saltar
            Jump AUX                / Si AC != 0, continuar restando
            Load num                / Cargar 'num' en AC
            Skipcond 400            / Si AC == 0, saltar
            Jump AUX2               / Si AC != 0, almacenar el resultado
            Load result             / Cargar 'result' en AC
            Store num               / 'num' ahora es el resultado de la división
            Jump ISFINAL            / Verificar si se ha terminado

/ Subrutina para restar 10 repetidamente
AUX,        Store num               / Actualizar 'num' con el valor actual de AC
            Load result             / Cargar 'result' en AC
            Add ONE                 / Incrementar 'result' en 1
            Store result            / Almacenar el nuevo 'result'
            Jump DIVIDE             / Repetir el proceso de división

/ Finalizar la división y actualizar 'num'
AUX2,       Load result             / Cargar 'result' en AC
            Store num               / Actualizar 'num' con el resultado de la división
            Jump ISFINAL            / Verificar si se ha terminado

/ Imprimir los dígitos almacenados en orden correcto
PRINT,      Load N5                 / Comenzar con el dígito más significativo
            Skipcond 400            / Si N5 == 0, saltar
            JnS PRINTUNICODE        / Imprimir N5 si existe

            Load N4
            Skipcond 400            / Si N4 == 0, saltar
            JnS PRINTUNICODE        / Imprimir N4 si existe

            Load N3
            Skipcond 400            / Si N3 == 0, saltar
            JnS PRINTUNICODE        / Imprimir N3 si existe

            Load N2
            Skipcond 400            / Si N2 == 0, saltar
            JnS PRINTUNICODE        / Imprimir N2 si existe

            Load N1
            Skipcond 400            / Si N1 == 0, saltar
            JnS PRINTUNICODE        / Imprimir N1 si existe

            Halt                    / Finalizar el programa

/ Subrutina para imprimir un dígito en formato Unicode
PRINTUNICODE, Hex 0000              / Dirección de retorno de la subrutina
            Add ZERO_UNICODE        / Convertir el dígito al carácter ASCII correspondiente
            Output                  / Imprimir el dígito
            JumpI PRINTUNICODE      / Retornar al punto de llamada

/ Declaración de variables y constantes
TEMP1,          Dec 0               / Variable temporal para cálculos
num,            Dec 0               / Almacena el número en proceso
t,              Dec 0               / Copia del número original
result,         Dec 0               / Almacena el resultado de la división
digit_counter,  Dec 1               / Contador para almacenar dígitos en N1-N5
ONE,            Dec 1               / Constante 1
TWO,            Dec 2               / Constante 2
Three,          Dec 3               / Constante 3
Four,           Dec 4               / Constante 4
Five,           Dec 5               / Constante 5
TEN,            Dec 10              / Constante 10
ZERO,           Dec 0               / Constante 0
ZERO_UNICODE,   Hex 0030            / Código ASCII del carácter '0'

/ Variables para almacenar los dígitos
N1,             Dec 0
N2,             Dec 0
N3,             Dec 0
N4,             Dec 0
N5,             Dec 0