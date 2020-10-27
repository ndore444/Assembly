TITLE inclassMENU.asm
; Author:  Diane Yoha
; Date:    October 2020
; Description: This program presents a menu allowing the user to pick a menu option
;              which then performs a given task.
;              1.  The user enters a string of no more than 100 characters.
;              2.  The entered string is converted to lower case.
;              3.  The entered string has all non - letter elements removed.
;              4.  Is the entered string a palindrome?
;              5.  Print the string.
;              6.  Exit
; ====================================================================================

Include Irvine32.inc 

;//Macros
ClearEAX textequ <mov eax, 0>
ClearEBX textequ <mov ebx, 0>
ClearECX textequ <mov ecx, 0>
ClearEDX textequ <mov edx, 0>
ClearESI textequ <mov esi, 0>
ClearEDI textequ <mov edi, 0>
Newline  textequ <0ah, 0dh>
maxLength = 101d

.data
UserOption byte 0h
theString byte maxLength dup(0)	;// declare the array
theStringLen byte 0

.code
main PROC

call ClearRegisters          ;// clears registers

startHere:                   ;// starting point to redisplay menu

mov ebx, OFFSET UserOption   ;// Passing address of UserOption in ebx to display Menu Proc
call displayMenu

;// setting up for future procedure calls
mov edx, offset theString    ;// edx holds the offset of the string
mov ecx, lengthof theString  ;// holds the length of the string

;// find procedure to call
opt1:
cmp useroption, 1             ;// useroption = 1
jne opt2
call clrscr
mov ebx, offset thestringlen  ;// will hold the length of the entered string
call option1
jmp starthere

opt2:
cmp useroption, 2             ;// useroption = 2
jne opt3
call clrscr
movzx ecx, thestringlen       ;// sets the loop count for option 2 since a string has been entered
call option2                  ;// underdevelopment
jmp starthere

opt3:
cmp useroption, 3             ;// useroption = 3    
jne opt4
call clrscr
movzx ecx, thestringlen       ;// sets the loop count
;// call option3   - Under development
jmp starthere

opt4:
;// awaiting development

opt5:                         
cmp useroption, 5             ;// useroption = 5  
jne opt6
call clrscr
call option5
call crlf
call waitmsg
jmp starthere


opt6:
cmp useroption, 6             ;// useroption = 5  
jne oops                      ;// invalid entry
jmp quitit

oops:                         ;// invalid option entered
call errorMsg
jmp starthere  

quitit:
exit
main ENDP

;// Procedures
;// ===============================================================
DisplayMenu Proc
;// Description:  Displays the Main Menu to the screen and gets user input
;// Receives:  Offset of UserOption variable in ebx
;// Returns:  User input will be saved to UserOption variable

.data
MainMenu byte 'MAIN MENU', 0Ah, 0Dh,
              '==========', 0Ah, 0Dh,
              '1. Enter a String:', 0Ah, 0Dh,
              '2. Convert all elements to lower case: ',0Ah, 0Dh,
              '3. Remove all non-letter elements: ',0Ah, 0Dh,
              '4. Determine if the string is a palindrome: ',0Ah, 0Dh,
              '5. Display the string: ',0Ah, 0Dh,
              '6. Exit: ',0Ah, 0Dh, 0Ah, 0Dh,
              'Please enter a number between 1 and 6 -->  ', 0h

.code
push edx  				      ;// preserves current value of edx - the strings offset
call clrscr
mov edx, offset MainMenu   ;// required by WriteString
call WriteString
call readhex			      ;// get user input
mov byte ptr [ebx], al	   ;// save user input to UserOption
pop edx    				      ;// restores current value of edx

ret
DisplayMenu ENDP

;//--------------------------------------------------------------------------

ClearRegisters Proc
;// Description:  Clears the registers EAX, EBX, ECX, EDX, ESI, EDI
;// Requires:  Nothing
;// Returns:  Nothing, but all registers will be cleared.

cleareax
clearebx
clearecx
clearedx
clearesi
clearedi

ret
ClearRegisters ENDP

;// ---------------------------------------------------------------

option1 proc uses edx ecx
;// Description: Gets string from user.
;// Receives:  Address of string
;// Returns:   String is modified and length of entered string is in saved in theStringLen

.data
option1prompt byte 'Please enter a string of characters (', 0h
option1prompt2 byte ' or less): ', newline, '--->   ', 0h

.code
push edx       ;//saving the address of the string pass in.

mov edx, offset option1prompt
call writestring
mov eax, maxlength
call writedec
mov edx, offset option1prompt2
call writeString

pop edx
;// add procedure to clear string
call readstring
mov byte ptr [ebx], al     ;//length of user entered string, now in thestringlen

ret
option1 endp

;// ------------------------------------------------------------------------------------

option2 proc 
;// Description:  Converts all elements to lower case
;// Receives:  address of string in edx, esi = 0h
;// Returns:  noting, but string is now lower case. esi - original value

push esi
call option5

;// Underdevelopment - converts all upper case letters to lower case.

keepgoing:  ;// if already lower case or not a letter, no need to change it, keep going.
inc esi
loop L2

pop esi
call option5
call waitmsg
ret
option2 endp

;// ------------------------------------------------------------------------------
option3 PROC
;// Description:  removes all non-letter elements.  There is no requirement for 
;//               option2 to have been executed.
;// Receives:  ecx - length of string
;//            edx - offset of string
;//            ebx - offset of string length variable
;//            esi preserved
;// Returns:   nothing, but the string will have all non-letter elements removed

.data


.code

;// underdevelopment
ret
option3 ENDP

;// ------------------------------------------------------------------------

option4 Proc
;// Description:
;// Receives:
;// Returns:
;// Requires: 
.data

.code
;// underdevelopment


ret
option4 ENDP

option5 proc 
;// Description:  Displays the string.
;// Receives: address of string in edx
;// Returns:  nothing

.data
option5prompt byte 'The current value of the string is: ', 0h

.code
;// call clrscr
push edx	;// save the address of the string to write prompt
mov edx, offset option5prompt
call writestring
pop edx
call writestring ;// write the string
call crlf

ret
option5 endp

;// -------------------------------------------------------------
errorMsg PROC
;// Description:  Displays Error Message on invalid entry
;// Receives :    Nothing
;// Returns :     Nothing

.data
errormessage byte 'You have entered an invalid option. Please try again.', Newline, 0h

.code
push edx                      ;// Save value in currently in edx
mov edx, offset errormessage  ;// prep to write string
call writestring
call waitmsg
pop edx                       ;// restore value in edx

ret
errorMsg ENDP
END main

