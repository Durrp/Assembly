; hello.asm
; Author: Nathan Acosta
; Date: January 30 2018

	.MODEL small

	.STACK 100h
	
	.DATA
	
message DB '1. Dec to Hex', 13, 10
		DB '2. Hex to Dec', 13, 10
		DB '3. Quit', 13, 10, '$'
		
decmsg  DB  13, 10,'Please enter a decmial number: $', 13, 10

continue DB 10, 13, 'Press any key to continue... ',13, 10, '$'

		
	.CODE
	
main PROC
		mov ax, @data
		mov ds, ax
		
start:

		;Clear screen
		mov ah, 0FH
		int 10h
		mov ah, 00h
		int 10h

		;Print message
		mov dx, OFFSET message
		mov ah, 09h
		int 21h
		
		;Recive user input
		mov ah, 08h
		int 21h
		
		;Check if the number is less than 1 (char)
		cmp al, 31h
		je dechex
		
		;Check if the number is less than 1 (char)
		cmp al, 32h
		je charhex
		
		;Check if the number is less than 1 (char)
		cmp al, 33h
		je quit
		
		jmp start
		
	
dechex:
		;Print message
		mov dx, OFFSET decmsg
		mov ah, 09h
		int 21h
		
		;Recive user input
		mov ah, 01h
		int 21h
		
		mov dx, 7Ah	
		push dx
		call disphex
		
		;Display the message
		mov dx, OFFSET continue
		mov ah, 09h
		int 21h
		
		;input factorial
		mov ah,08h ;Checks keyboard input
		int 21h
		
		jmp start
		
charhex:
		

		
		jmp start
quit:
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
