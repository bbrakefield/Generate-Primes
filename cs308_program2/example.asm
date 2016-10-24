; Example assembly language program -- adds two numbers
; Author:  R. Detmer
; Date:    1/2008

.586
.MODEL FLAT

INCLUDE io.h            ; header file for input/output

.STACK 4096

.DATA
number1		DWORD	?
number2		DWORD	10
prompt1		BYTE    "Enter number of primes to generate: ", 0
errorLbl	BYTE	"Number above 100 or below 1. Please try again ", 0
primesLbl	BYTE	"The primes are ", 0
emptyLbl	BYTE	" ",0
string		BYTE	40 DUP(0)
primes		BYTE	20 DUP(?), 0
array		BYTE	10000	DUP(0)

.CODE
_MainProc PROC
startCheck:
    input   prompt1, string, 40     ; read ASCII characters
    atod    string					; convert to integer
    mov     number1, eax			; store in memory
	cmp		number1, 100			; compare number to the limit 100
	jg		greaterThan				; if greater than 100 jump to error message
	cmp		number1, 1
	jl		greaterThan
	jmp		endCheck				; otherwise continue with procedure

; error procedure
greaterThan:
	output	errorLbl, emptyLbl				; display error message (i think?)
	jmp		startCheck					; loop back to start and try again

; continue 
endCheck:
	call	GenPrimes					; GenPrimes(int number1)

	lea		edx, array					; load the array address into EDX
	inc		edx    					    ; move EDX to the third index of the array
	mov		ebx, 0						; counter for total primes
	mov		ecx, 1						; counter for total number
	output	primesLbl, emptyLbl			; print the initial message

	whileLoop:
	inc ecx								; ++i
	inc edx
	cmp ebx, number1 					; while (i < number)
	jge endPrintLoop					; if (i>= number) break

	primeCheck:
	cmp BYTE PTR [edx], 0
	je  printPrimes

	jmp whileLoop
	
	printPrimes:
	inc ebx
	dtoa string, ecx
	output  emptyLbl, string			; output label and sum

	jmp whileLoop

	endPrintLoop:

    mov     eax, 0						; exit with return code 0
    ret
_MainProc ENDP







                       
GenPrimes PROC
	; move starting values into counters
    mov     ebx, 2						; move 2 into 1st counter
    mov     ecx, 2						; move 2 into 2nd counter

loop1:
    ; outer loop
    cmp     ebx, 10000					; number1
    jge     quit						; if greater than or equal to 10,000 quit the program

	loop2:
    ; calculate index product 
   mov     eax, ebx				    ; move counter 1 into register
    mul     ecx						    ; multiply by value in 2nd counter and store in eax
    cmp     eax, 10000				    ; compare product to 10000
    jg      loop2Done					; jump to label2Done if product is greater than 10,000
    cmp     [array + eax], 0		    ; comapare the value at the current array index to zero
    jnz     increment_index			    ; if it does not equal zero do nothing and jump to increment index
    mov     [array + eax], 1			; otherwise place 1 in the index because the number is composite

increment_index:
    ; counter logic
    inc     ecx							; increment 2nd counter
    jmp     loop2						; loop back to beginning of loop

loop2Done:
    inc     ebx                         ; increment outer loop
    mov     ecx, 2                      ; reset 2nd counter to 2
    jmp     loop1			            ; jump to the begining of first loop

quit:
    ret			
GenPrimes ENDP
END 