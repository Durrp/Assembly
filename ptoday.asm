; ptoday.asm
; Author: Nathan Acosta
; Date: February 22 2018
	.MODEL small

	.STACK 100h
	
	.DATA
	
Today1 DB 10, 13, 'Today is $'

	.CODE
	
Today PROC
		mov ax, @data
		mov ds, ax
		
		;First display the message
		mov dx, OFFSET Today1
		mov ah, 09h
		int 21h
		
		;Get system date
		mov ah, 02ah
		int 21h

		;al contains day of week
		;cx contains the year
		;dh contains the month
		;dl contains the day
		
		;save the year
		push cx

		;save the day
		mov cl, dl
		mov ch, 0
		push cx

		;save the month
		mov dl, dh
		mov dh, 0
		push dx
		

		;display month digits
		call disp10

		;move / to character holder
		mov dl, '/'
		
		; display the character
		mov ah, 02h
		int 21h
		
		;display day digits
		call disp10

		;move / to character holder
		mov dl, '/'
		
		; display the character
		mov ah, 02h
		int 21h
		
		;display year digits
		call disp10


		
		;Exit to DOS
		mov al, 0
		mov ah, 4ch
		int 21h
		
Today ENDP		


		
		
disp10 PROC

		;pop instruction pointer from stack
		pop bx
		;pop the number to be displayed
		pop ax
		;push the ip back on the stack
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
	
	END Today
