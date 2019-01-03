; conv.asm
; Author: Nathan Acosta

	.MODEL small

	.STACK 100h
	
	.DATA
	
message DB '  1. Decimal to Hexadecimal', 13, 10
		DB '  2. Character to ASCII Hex', 13, 10
		DB '  3. Quit', 13, 10, '$'

decmsg  DB  13, 10,'Please enter a decmial number: $', 13, 10

charmsg  DB  13, 10,'Please press a key to get the ASCII value: $', 13, 10

continue DB 10, 13, 'Press any key to continue... ', '$'

newln DB 13, 10, '$'
		
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
		
		;Check if the number is 1 (char)
		cmp al, 31h
		je dechex
		
		;Check if the number is 2 (char)
		cmp al, 32h
		je charhex
		
		;Check if the number is 3 (char)
		cmp al, 33h
		je quit
		
		jmp start
		
	
dechex:

		;Recive user input
		call get10
		;Display number
		call disphex
		
		;Display the message
		mov dx, OFFSET continue
		mov ah, 09h
		int 21h
		
		mov ah,08h ;Checks keyboard input
		int 21h
		
		jmp start
		
charhex:

		;Display the message
		mov dx, OFFSET charmsg
		mov ah, 09h
		int 21h
		
		;Recive user input
		mov ah, 01h
		int 21h
		
		;save input
		mov ah, 0h
		push ax
		
		;Print message
		mov dx, OFFSET newln
		mov ah, 09h
		int 21h
		
		call disphex

		
		;Display the message
		mov dx, OFFSET continue
		mov ah, 09h
		int 21h
		
		mov ah,08h ;Checks keyboard input
		int 21h
		
		jmp start
quit:
		;Exit to DOS
		mov al, 0
		mov ah, 4ch
		int 21h
main ENDP	

		
		
		

get10 PROC

		;initialize first value to 0 and save it
		mov ax, 0h
		push ax
		
		;Print message
		mov dx, OFFSET decmsg
		mov ah, 09h
		int 21h
		
getin:		
		;Recive user input
		mov ah, 01h
		int 21h
				
		;Check if user pressed enter
		cmp al, 0Dh
		je end10
		
		;Check if number(char value) is less than 0
		cmp al, 30h
		jl getin
		;Check if number(char value) is greater than 9
		cmp al, 39h
		jg getin
		
		;Convert char into digit
		mov ah, 0
		sub al, 30h
		
		;Save valid number to cx
		mov cx, ax
		
		;Unsave previous number (0 if first number)
		pop ax
		
		;Set up multiplication
		mov bx, 10
		
		;multiply value by 10
		mul bx
		
		;add cx to product
		add ax, cx
		
		;save answer
		push ax
		
		jmp getin
		
end10:
	  pop ax
	  pop bx
	  push ax
	  push bx
	  
	  ret
		
		
get10 ENDP	


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

		jmp endhexd
		
letter:
		
		;change digit into character
		add dl, 37h
		
		;display the character
		mov ah, 02h
		int 21h
		
		;if more digits, make your way to numdisp
		LOOP numdisp
		
		jmp endhexd
		
endhexd:
		ret
		
disphex ENDP
	
	END main
