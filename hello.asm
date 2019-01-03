; hello.asm
; Author: Nathan Acosta
; Date: January 31 2018

	.MODEL small

	.STACK 100h
	
	.DATA
	
message DB 'Name: Nathan Acosta', 13, 10
	DB 'Source File: hello.asm', 13, 10
	DB 'Completed on January 31', 13, 10,'$'

	.CODE
	
main PROC
		mov ax, @data
		mov ds, ax
		
		mov dx, OFFSET message
		mov ah, 09h
		int 21h
		
		mov al, 0
		mov ah, 4ch
		int 21h
main ENDP		
	
	END main
