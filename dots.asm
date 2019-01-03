; dots.asm
; Author: Nathan Acosta

	.MODEL small

	.STACK 100h
	
	.DATA
	
Continue DB 10, 13, 'Press any key to continue ',13, 10, '$'
NewLn DB 10, 13, '$'

	.CODE
	
Dots PROC
		mov ax, @data
		mov ds, ax
		
		;initialize values
		mov cx, 0
		mov ax, 0
		mov dx, 0
		
dispdot:
	
		add cx, 1
		
		;check if adding produces carry
		jnc nocarry
		mov dx, 1
		
nocarry:
		
		push dx
			
		;move dot to character holder
		mov dl, '.'
		
		;display dot
		mov ah, 02h
		int 21h
		
		pop dx
		
		;setup division
		mov bx, 1000	

		push dx
		;divide
		mov ax, cx
		div bx
		
		;check to see if remainder is zero
		cmp dx, 0
		pop dx
		;if not, return to displaying dots
		jne dispdot

		mul bx ;convert number back from division
		
		;save number (lower bits)
		push ax
		push dx
		
		;save number to be displayed
		push ax
		push dx
		
		;Display new line
		mov dx, OFFSET NewLn
		mov ah, 09h
		int 21h

		;Display number
		call disp10

		
		;Display continue the message
		mov dx, OFFSET Continue
		mov ah, 09h
		int 21h
		
		mov ah,08h ;Checks keyboard input
		int 21h
		
		;unsave number
		pop dx
		pop ax
		
		mov bx, 1000
		div bx
		
		;Exit if number is 100,000
		cmp ax, 100
		JE exit
		
		
		mul bx
		mov cx,ax
		
		jmp dispdot

		
exit:
		;Exit to DOS
		mov al, 0
		mov ah, 4ch
		int 21h
		
Dots ENDP		


		
		
disp10 PROC

		;pop instruction pointer from stack
		pop bx
		;pop the number to be displayed
		pop dx
		pop ax
		
		;push the ip back on the stack
		push bx

		;set up counter and set it to zero
		mov cx, 0
		
		;set divisor to 10
		mov bx, 10

numdiv:  ;label to return to when ready to divide again
		;setup division
		
		 
		;divide
		div bx
		
		;save the remainder
		push dx

		;increment the counter
		add cx, 1
		
		mov dx, 0

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
	
	END Dots
