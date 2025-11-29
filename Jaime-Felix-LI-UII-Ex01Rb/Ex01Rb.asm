					TITLE	Programa para determinar si una cadena termina con un sufijo (Examen Unidad II Regularización Tipo b)

; Prototipos de llamadas al sistema operativo
GetStdHandle	PROTO	:QWORD
ReadConsoleW	PROTO	:QWORD,	:QWORD, :QWORD, :QWORD, :QWORD
WriteConsoleW	PROTO	:QWORD,	:QWORD, :QWORD, :QWORD, :QWORD

				.DATA
Cadena			WORD	80 DUP ( ? )
Sufijo			WORD	80 DUP ( ? )
LongCadena		QWORD	?
LongSufijo		QWORD	?
MenEnt01		WORD	'P', 'r', 'o', 'p', 'o', 'r', 'c', 'i', 'o', 'n', 'e', ' ', 'l', 'a', ' ', 'c', 'a', 'd', 'e', 'n', 'a', ':', ' '
MenEnt02		WORD	'P', 'r', 'o', 'p', 'o', 'r', 'c', 'i', 'o', 'n', 'e', ' ', 'e', 'l', ' ', 's', 'u', 'f', 'i', 'j', 'o', ':', ' '
; Definir los mensajes de salida correspondientes

; Variables utilizadas por las llamadas al sistema
ManejadorE		QWORD	?
ManejadorS		QWORD	?
Caracteres		QWORD	?
SaltoLinea		WORD	13, 10
STD_INPUT		EQU		-10
STD_OUTPUT		EQU		-11

				.CODE
Principal		PROC

				; Alinear espacio en la pila
				SUB		RSP, 40

				; Obtener manejador estándar del teclado
				MOV		RCX, STD_INPUT
				CALL	GetStdHandle
				MOV		ManejadorE, RAX

				; Obtener manejador estándar de la consola
				MOV		RCX, STD_OUTPUT
				CALL	GetStdHandle
				MOV		ManejadorS, RAX

				; Solicitar la cadena
				MOV		RCX, ManejadorS				; Manejador de la consola donde se escribe
				LEA		RDX, MenEnt01				; Dirección de la cadena a escribir
				MOV		R8, LENGTHOF MenEnt01		; Número de caracteres a escribir
				LEA		R9, Caracteres				; Dirección de la variable donde se guarda el total de caracteres escrito
				MOV		R10, 0						; Reservado para uso futuro
				PUSH	R10
				CALL	WriteConsoleW
				POP		R10

				MOV		RCX, ManejadorE				; Manejador del teclado donde se lee la cadena
				LEA		RDX, Cadena					; Dirección de la cadena a leer
				MOV		R8, LENGTHOF Cadena			; Número de caracteres máximo a leer
				LEA		R9, LongCadena				; Dirección de la variable donde se guarda el total de caracteres leídos
				MOV		R10, 0						; Reservado para uso futuro
				PUSH	R10
				CALL	ReadConsoleW
				POP		R10

				SUB		LongCadena, 2					; Para eliminar el <Enter>

				; Solicitar el sufijo

				; Debe comparar, de derecha a izquierda (del final al principio) la cadena y el sufijo hasta la longitud del sufijo.
				; Si son iguales entonces la cadena termina con el sufijo.

				; Mostrar el resultado correspondiente:
				; La cadena termina con el sufijo
				; La cadena no termina con el sufijo

				; Salto de línea
				MOV		RCX, ManejadorS				; Manejador de la consola donde se escribe
				LEA		RDX, SaltoLinea				; Dirección de la cadena a escribir
				MOV		R8, LENGTHOF SaltoLinea		; Número de caracteres a escribir
				LEA		R9, Caracteres				; Dirección de la variable donde se guarda el total de caracteres escrito
				MOV		R10, 0						; Reservado para uso futuro
				PUSH	R10
				CALL	WriteConsoleW
				POP		R10

				; Recuperar el espacio de la pila
				ADD		RSP, 40

				; Salir al S. O
				MOV		RAX, 0					; Código de salida 0
				RET								; Retornar al sistema operativo
Principal		ENDP
				END
