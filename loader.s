section .data:									; DATA SECTION

    align 4                         			; the code must be 4 byte aligned
        dd 		MAGIC_NUMBER             		; write the magic number to the machine code,
        dd 		FLAGS                    		; the flags,
        dd 		CHECKSUM                 		; and the checksum

section .bss:									; start of the memory section
	align 4										; align at 4 bytes
	kernel_stack:								; label points to beginning of memory
		resb 	KERNEL_STACK_SIZE				; reserve stack for the kernel
		resb	BUF

	
section .text:                  				; TEXT SECTION (code)
    global loader                			   	; the entry symbol for ELF

		MAGIC_NUMBER 		equ 0x1BADB002     	; define the magic number constant
		FLAGS        		equ 0x0           	; multiboot flags
		CHECKSUM     		equ -MAGIC_NUMBER	; calculate the checksum
		                                		; (magic number + checksum + flags should equal 0)
		KERNEL_STACK_SIZE	equ	4096			; set stack size in bytes (4Mb)
		BUF					equ 1024

    loader:                         			; the loader label (defined as entry point in linker script)
		
        mov 	eax, 0xCAFEBABE         		; place the number 0xCAFEBABE in the register eax
		mov 	esp, kernel_stack + KERNEL_STACK_SIZE   ; point esp to the start of the
	                                            ; stack (end of memory area)

		extern 	multiply						; multiply C function
		push 	dword 10						; arg 2
		push 	dword 10						; arg 1
		call 	multiply						; call function -- result will be in eax

		extern 	fb_clear						; clear framebuffer
		call 	fb_clear

		extern 	fb_write_word					; write to FB word function
		call 	fb_write_word
		
		extern 	fb_move_cursor					; move cursor to position
		push 	word 240
		call 	fb_move_cursor

    loop:
        jmp 	loop                   ; loop forever










