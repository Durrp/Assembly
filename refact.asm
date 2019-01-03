; factcal.asm
; Author: Nathan Acosta

	.MODEL small

	.STACK 100h
	
	.DATA
	
Welcome DB 10, 13, 'Welcome to the Factorial Calculator'
	DB 10, 13, 'Enter a number between 1 and 8', 10, 13, '$'

Facto	DB ' factorial is $'

	.CODE
	
factcal PROC
		mov ax, @data
		mov ds, ax
userin:		
		;Display Welcome message and instructions
		mov dx, OFFSET Welcome
		mov ah, 09h
		int 21h

		
		;Recive user input
		mov ah, 01h
		int 21h
	
		
		;Check if the number is less than 1 (char)
		cmp al, 31h
		jl userin

		;Check if the number is greater than 8 (char)
		cmp al, 38h
		jg userin

		;Else display input and factorial message
		
		;Clean ah and convert input (char) to numerical value
		mov ah, 0
		sub al, 30h
		push ax
		
		
		
		;Display factorial message
		mov dx, OFFSET Facto
		mov ah, 09h
		int 21h



		
		
		
		;Exit to DOS
		mov al, 0
		mov ah, 4ch
		int 21h
		
factcal ENDP	


refact PROC
		;pop the offset into bx
		pop bx
		;move the number to be calculated into ax 
		pop ax
		;move the offset back in to the stack
		push bx
		
		cmp ax, 1
		je factret
		
		; not at 1 yet
		; save ax
		
		push ax
		
		;move down one value
		sub ax, 1
		
		;save new value into ax
		push ax
		
		; ready to do next value
		call refact
		
		pop bx
		mul bx
		
factret:
		ret

refact ENDP	


		
		
		
		
disp10 PROC
		;pop the offset into bx
		pop bx
		;move the number to be displayed into ax - dividend
		pop ax
		;move the offset back in to the stack
		push bx

		;set up counter and set it to zero
		mov cx, 0
		
		;set divisor to 10
		mov bx, 10

numdiv:  ;label to return to when ready to divide again
		;setup division
		mov dx, 0
		 
		;divide
		div bx
		
		;save the remainder
		push dx

		;increment the counter
		add cx, 1

		;check to see if quotient is zero
		cmp ax, 0

		;if not, make your way to numdiv
		jne numdiv

numdisp:
		; retrieve a digit from storage - into dx
		pop dx
		
		;change digit into character
		add dl, 30h
		
		;display the character
		mov ah, 02h
		int 21h
		
		;if more digits, make your way to numdisp
		LOOP numdisp

		ret

disp10 ENDP
	
	END Refact
