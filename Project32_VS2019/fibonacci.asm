TITLE reorder.asm

;Description:Extra credit OCT 1st.
;Author: Nathaniel Dore
;Creation Date:10/1/2020


INCLUDE irvine32.inc

move textequ <mov>

ClearEAX textequ <mov eax, 0d>
ClearEBX textequ <mov ebx, 0d>
ClearECX textequ <mov ecx, 0d>
ClearEDX textequ <mov edx, 0d>

.data

operandArray byte 23d, 47d , 52d, 31d, 34d, 87d, 89d, 67d, 0d, 13d		
resultsArray byte 5 DUP (?)			;array to store the difference of the elements in the array above
.data?
;{used as necessary}


.code
main PROC

									;clearing the registers before we get started
ClearEAX
ClearEBX
ClearECX
ClearEDX

mov edi, OFFSET operandArray		;address of operands array
mov esi, 0d ;OFFSET resultsArray		;address of array for the results
mov ecx, LENGTHOF resultsArray		;loop itterator

mov al, 0d							;stores the first operand from the array
mov bh, 0d							;stores the second operand from the array
mov bl, 0d							;i in the logic below

;loop logic: result[i] = (operands[(i * 2) + 1] - operands[i * 2])

L1:
	
	mov al, operandArray[esi + 1]
	

	call WRITEINT

loop L1


CALL DumpRegs

exit
main ENDP ; end of main procedure
END main ; end of source code