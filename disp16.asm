; Author: Nathan Acosta

	.MODEL small

	.STACK 100h
	
	.DATA

message DB  '7777 in hex is: $'

		
	.CODE
	
main PROC
		mov ax, @data
		mov ds, ax
		
start:

		;Print message
		mov dx, OFFSET message
		mov ah, 09h
		int 21h

		;move 7777 decimal to dx
		mov dx, 7777
		;put number on stack
		push dx
		
		;display number in hex
		call disphex
		
		;Exit to DOS
		mov al, 0
		mov ah, 4ch
		int 21h
		
main ENDP		


disphex PROC

		;pop instruction pointer from stack
		pop bx
		;pop the number to be displayed
		pop ax
		
		;push the ip back on the stack
		push bx

		;set up counter and set it to zero
		mov cx, 0
		
		;set divisor to 16
		mov bx, 16

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
		
		cmp dx, 10
		jge letter
		
		;change digit into character
		add dl, 30h
		
		;display the character
		mov ah, 02h
		int 21h
		
		;if more digits, make your way to numdisp
		LOOP numdisp

		ret
		
letter:
		
		;change digit into character
		add dl, 37h
		
		;display the character
		mov ah, 02h
		int 21h
		
		;if more digits, make your way to numdisp
		LOOP numdisp
		
		ret
		

disphex ENDP
	
	END main
