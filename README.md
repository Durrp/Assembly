# Assembly x86
8-bit Assembly projects source files 

To be able to compile and exectue these files, the Turbo Assembler tool from the techapple website is needed:
http://techapple.net/2013/01/tasm-windows-7-windows-8-full-screen-64bit-version-single-installer/

After the program the program is opened DOS screen will pop-up, make sure you are in the same directory where you stored the source files in. (Usually in C:\Tasm 1.4\Tasm )

To properly execute the assembly programs it is necessary to compile and link the source files.

Compile : tasm “filename.asm” [no quotes]

Link : tlink “filename.obj” [no quotes]

To execute the file : filename.exe [the .exe can be excluded]
