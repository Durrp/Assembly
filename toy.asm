; toy.asm
; Author: Nathan Acosta

	.MODEL small

	.STACK 100h
	
	.DATA
	
welcome DB 'Welcome to the Toy!', 13, 10, '$'
		
gboard  DB  13, 10,'A		B		C', 13, 10, '$'
row1	DB  13, 10,'0		0		0', 13, 10, '$'
row2	DB  13, 10,'	0		0	 ', 13, 10, '$'
row3	DB  13, 10,'0		0		0', 13, 10, '$'
		

prompt DB 10, 13, 'Press A, B, or C or Q to quit. ',13, 10, '$'

		
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
		mov dx, OFFSET welcome
		mov ah, 09h
		int 21h

		
		;Print message
		mov dx, OFFSET gboard
		mov ah, 09h
		int 21h
		
		;Print message
		mov dx, OFFSET row1
		mov ah, 09h
		int 21h
		
		;Print message
		mov dx, OFFSET row2
		mov ah, 09h
		int 21h
		
		;Print message
		mov dx, OFFSET row3
		mov ah, 09h
		int 21h

getin:
		;Print message
		mov dx, OFFSET prompt
		mov ah, 09h
		int 21h


		;Recive user input
		mov ah, 08h
		int 21h
		
		;Check if the number is less than 1 (char)
		cmp al, 'a'
		je holeA
		
		;Check if the number is less than 1 (char)
		cmp al, 'b'
		je holeB
		
		cmp al, 'c'
		je holeC
		
		;Check if the number is less than 1 (char)
		cmp al, 'q'
		jne skipq
		jmp quit

skipq:
		jmp start
		
holeA:

		cmp row1+2, '0'
		jne Ain
		
		;add marble
		mov row1+2, '1'
		jmp switch6
		
	Ain:
	
		;push marble
		mov row1+2, '0'
		jmp switch4
		

holeB:

		cmp row1+5, '0'
		jne Bin
		
		;add marble
		mov row1+5, '1'
		jmp switch5
		
	Bin:
	
		;push marble
		mov row1+5, '0'
		jmp switch4

holeC:

		cmp row1+8, '0'
		jne Cin
		
		;add marble
		mov row1+8, '1'
		jmp switch5
		
	Cin:
	
		;push marble
		mov row1+8, '0'
		jmp switch8
		
		
switch4:

		cmp row2+3, '0'
		jne s4in
		
		;add marble
		mov row2+3, '1'
		jmp switch7
		
	s4in:
	
		;push marble
		mov row2+3, '0'
		jmp switch6
		
		
switch5:


		cmp row2+6, '0'
		jne s5in
		
		;add marble
		mov row2+6, '1'
		jmp switch8
		
	s5in:
	
		;push marble
		mov row2+6, '0'
		jmp switch7
		
		
switch6:

		cmp row3+2, '0'
		jne s6in
		
		;add marble
		mov row3+2, '1'
		jmp start
		
	s6in:
	
		
		mov row3+2, '0'
		jmp start

		
switch7:

		cmp row3+5, '0'
		jne s7in
		
		;add marble
		mov row3+5, '1'
		jmp start
		
	s7in:
	
		
		mov row3+5, '0'
		jmp start

switch8:

		cmp row3+8, '0'
		jne s8in
		
		;add marble
		mov row3+8, '1'
		jmp start
		
	s8in:
	
		
		mov row3+8, '0'
		
		jmp start
		


quit:
		;Exit to DOS
		mov al, 0
		mov ah, 4ch
		int 21h
main ENDP		
	
	END main
