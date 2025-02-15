//ACCESSING 2D ARRAY ELEMENTS
TITLE My First Program (Test.asm)
INCLUDE Irvine32.inc
.data
arr DWORD 10,20,30,40
DWORD 50,60,70,80
DWORD 90,100,110,120

rowSize=16

.code
main PROC

;for accessing 60
row=1
col=1

mov ebx,offset arr
add ebx,rowSize*row ;20*1
mov esi,col
mov eax,[ebx+esi*type arr]  ;20*1+(4*1)
call writeDec
   
   exit
main ENDP
END main

//ACCESSING DYNAMICALLY
TITLE My First Program (Test.asm)
INCLUDE Irvine32.inc
.data
arr DWORD 10,20,30,40
    DWORD 50,60,70,80
    DWORD 90,100,110,120

rows = 3                    ; Number of rows in the array

.code
main PROC

    row = 1                 ; Row index (0-based)
    col = 1                 ; Column index (0-based)

    mov ebx, OFFSET arr     ; Base address of the array
    mov eax, SIZEOF arr     ; Total size of the array in bytes
    cdq                     ; Clear edx for division
    div rows                ; eax = Size of one row (16 bytes)
    imul eax, row           ; eax = row * size of one row
    add ebx, eax            ; ebx = base address + row offset
    mov esi, col            ; Column index
    mov eax, [ebx + esi * TYPE arr]  ; Get the element at arr[row][col]
    call WriteDec           ; Display the value (should print 60)

    call Crlf               ; New line for clarity
    exit
main ENDP
END main

//CHAR SEARCH IN STRING
TITLE My First Program (Test.asm)
INCLUDE Irvine32.inc

.data
strr byte "Input String: ",0
str1 BYTE 100 DUP(?)
tofind byte '#',0
msg byte "# fount at index: ",0
msg2 byte "# not found!",0
space byte " ",0
len dword ?

.code
main Proc
call scanString
main endp

scanString PROC
;taking user input of string
mov edx,offset strr
call writestring

mov edx,offset str1
mov ecx,100
call readstring

call crlf
mov edx,offset str1
call writestring
call crlf

mov ecx,lengthof str1  ;taking length 
mov len,ecx
dec len ;minus null terminator
mov edi,offset str1

mov al,tofind
repnz scasb
jz flagsett

;else not found
mov edx,offset msg2
call writeString

flagsett:
mov eax,len
sub eax,ecx  ;ecx stop hee found pe hoa hoga
mov edx,offset msg
call writestring
call writedec

exit
ret
scanString endp
END main

//MULTIPLYING AND STORING AT INDEX
TITLE My First Program (Test.asm)
INCLUDE Irvine32.inc

.data
arr DWORD 1,2,3,4,5
multiplier DWORD 10
strr byte " ",0

.code
main PROC
cld                  ;clear direction flag
mov esi,offset arr   ;source
mov edi,offset arr          ;jisme ap stosd se dalogy

mov ecx,lengthof arr   ;loop counter

l1:
lodsd   ;load [esi] into eax
mul multiplier ;har index pe multiply
stosd   ;eax se edi mein ie destination string
loop l1    ;changes ussi array mein hrhay hongy
;lodsd and stosd by def inc krta edi and esi ko

mov ecx,lengthof arr
mov edx,offset strr ;spaces
mov esi,offset arr
l2:
mov eax,[esi]
call writedec
mov edx,offset strr
call writestring
add esi,4
loop l2

exit
main endp
END main

//COPYING USING MOVSD THEN REVERSING ARR
ITLE My First Program (Test.asm)
INCLUDE Irvine32.inc

.data
arr DWORD 1,2,3,4,5
arr2 DWORD 5 DUP (?)
strr byte " ",0

.code
main PROC
;reversing arr

cld
mov esi,offset arr
mov edi,offset arr2     ;dest

mov ecx,lengthof arr
rep movsd


;for printing 
mov edi,offset arr2
add edi,(lengthof arr2-1)*type arr2
mov ecx,lengthof arr2
l1:
mov eax,[edi]
call writeDec
mov edx,offset strr
call writestring
sub edi,4
loop l1

exit
main endp
END main

//CHECK PRIME
TITLE My First Program (Text.asm)
INCLUDE Irvine32.inc

.data
msg BYTE "Enter num: ",0
num DWORD ?
p BYTE "Prime",0
np BYTE "Not Prime",0

.code
main PROC
mov edx,offset msg
call WriteString
call ReadInt
mov num,eax  

mov ecx,num
mov ebx,2


check_div:
mov edx,0
div ebx  ;ans stored in eax
cmp edx,0  ;if zero
je not_prime
inc ebx
cmp ebx, eax         ; compare ebx with the number
jl check_div         ; if ebx < eax, continue checking

;if loop completes num is prime warna zero ajata so we would have reached not prime
prime:
mov edx,offset p
call WriteString
call crlf
jmp done

not_prime:
mov edx,offset np
call WriteString

done:
call dumpRegs
exit
main ENDP
END main

//COMPARE
TITLE My First Program (Test.asm)
INCLUDE Irvine32.inc

.data
str1 byte "help",0
str2 byte "ab",0
equal byte "EQUAL",0
greater byte "STR1 > STR2",0
lesser byte "STR1 < STR2 ",0
.code
main Proc
call IsCompare
main endp

IsCompare Proc
mov esi,offset str1     ;src
mov edi,offset str2     ;dest

cmpsb
je equall
ja greaterr

less:
mov edx,offset lesser
call writeString
jmp exx

equall:
mov edx,offset equal
call writeString 
jmp exx

greaterr:
mov edx,offset greater
call writestring


exx:
exit
ret
IsCompare Endp
END main

//

//C TO ASSM 
TITLE My First Program (Test.asm)
INCLUDE Irvine32.inc

.data
arr DWORD 1,2,3,4,5
x dword 10
y dword 3
msg1 byte "large",0
msg2 byte "small",0
.code
main Proc
mov ecx,5
mov esi,offset arr
i:
xor edx,edx
mov ebx,2
mov eax,[esi]

div ebx   ;eax div ebx
cmp edx,0
je iff

elsee:
mov eax,x
sub eax,[esi]
mov ebx,y
add ebx,1
jmp ifcondition

iff:
mov ebx,x
add ebx,[esi]
mov eax,y
shl eax,1  ;or mul DWORD ptr 2
jmp ifcondition

add esi,4
loop i

ifcondition:
cmp x,20
jg large

small:
mov edx,offset msg2
call writeString
jmp exx

large:
mov edx,offset msg1
call writeString
jmp exx

main endp
exx:
exit
END main

//FREQ 
TITLE My First Program (Test.asm)
INCLUDE Irvine32.inc

.data
strr byte "maham", 0              ; Input string
freqArr DWORD 256 DUP(0)           ; Frequency array for each ASCII character

.code
main PROC

    lea esi, strr                 ; Load address of the string into ESI
    mov ecx, lengthof strr        ; Load the length of the string into ECX
    lea edi, freqArr              ; Load the address of the frequency array into EDI

L1:
    movzx edx, byte ptr [esi]     ; Move the byte (character) at [esi] into EDX
    inc byte ptr [edi + edx]      ; Increment the corresponding position in the frequency array
    inc esi                       ; Move to the next character in the string
    loop L1                       ; Decrement ECX and repeat until ECX = 0

    ; Print the frequency array
    mov ecx, 256                  ; Set ECX to 256 (loop through all possible ASCII characters)
    lea edi, freqArr              ; Load the address of the frequency array into EDI

L2:
    movzx eax, byte ptr [edi]     ; Get the frequency count for the current character
    cmp eax, 0                    ; If the frequency is 0, skip it (no need to print)
    je skip                       ; Jump to next character if frequency is 0

    ; Print character index and its frequency count
    mov edx, edi                  ; Load the address of the current frequency entry into EDX
    call WriteDec                 ; Write the frequency value
    call CrLf                     ; Print a newline
skip:
    inc edi                       ; Move to the next byte in the frequency array
    loop L2                       ; Repeat until all 256 positions have been checked

    exit
main ENDP
END main

//SKIPPING CHAR
TITLE My First Program (Test.asm)
INCLUDE Irvine32.inc

.data

strr byte 50 dup (?)
toTrim byte ?
output byte "Trimmed String: ",0
outputstr byte 50 dup (?)
msg byte "Enter char to trim: ",0
msg2 byte "Enter string: ",0

.code
main Proc
mov edx,offset msg2
call writeString

mov edx,offset strr
mov ecx,50
call readString
call crlf

mov edx,offset msg
call writestring
call readchar

mov toTrim,al

mov esi,offset strr
mov al,toTrim
mov edi,offset outputstr
call trimChar

call crlf

mov edx,offset outputstr
call writeString
main endp

trimChar PROC
mov ecx,lengthof strr
l1:
cmp al,[esi]
jne copyy   ;if the char to trim not equal to arr copy rest else skip

skipp:
inc esi

copyy:
mov dl,[esi]
mov [edi],dl
inc esi
inc edi
loop l1
ret
trimChar endp


exit
END main

//CHECK PALINDROME
TITLE My First Program (Text.asm)
INCLUDE Irvine32.inc
.data ;string reversal
arr BYTE "maham",0
ispalin BYTE "IS PALINDROME",0
notpalin BYTE "NOT PALINDROME",0
n DWORD LENGTHOF arr
.code
main PROC
mov esi,0     ;for checking forward and backwards
mov edi,4   ;since last char at n-1 is 0 then start w n-2

check_palindrome:
movzx eax,arr[esi]
movzx ebx,arr[edi]

cmp eax,ebx ;if both dont have same val jmp to not palindrome
jne not_palindrome

;else keep inc esi and dec edi to check
inc esi
dec edi
cmp esi,edi ;if esi<edi
jl check_palindrome

;after complete check 
mov edx,offset ispalin
call WriteString
jmp end_prog

not_palindrome:
mov edx,offset notpalin
call WriteString

end_prog:
call DumpRegs
exit
main ENDP
END main

//ADDING NUM
INCLUDE Irvine32.inc

.data
num dword 1234 

.code
main PROC
    mov ecx, 4
    mov eax,0
    mov ebx, 0
    mov eax, num
    l1:
      mov edx, 0
      mov esi, 10
      div esi
      add ebx, edx
    loop l1
    mov eax, ebx
    call writedec
   
    exit         
main ENDP
END main

//FIB SERIES
INCLUDE Irvine32.inc

.data
num dword 10 

.code
main PROC
    mov ecx, num  
    mov esi, 0   
l1:
    mov eax, esi 
    call fib      
    call writedec 
    call crlf    
    inc esi      
loop l1      

    exit         
main ENDP

fib PROC
    push ebx      
    cmp eax, 1    
    jg recurse    
    mov ebx, eax  
    jmp done     
recurse:
    push eax     
    sub eax,1       
    call fib      ; Recursive call
    mov ebx, eax  ; Save F(n-1) in EBX
    pop eax       ; Restore EAX (current n)
    sub eax, 2    ; F(n-2)
    call fib      
    add eax, ebx  ; F(n) = F(n-1) + F(n-2)

done:
    pop ebx       
    ret           
fib ENDP
END main

//FINDING MAXIMUM
TITLE My First Program (Test.asm)
INCLUDE Irvine32.inc

.data
arr word 1,2,3,4,5
maxx dw ?
.code

main Proc
mov ebx,offset arr
mov cx,lengthof arr
call Maximum
movzx eax,maxx
call writedec
exit
main endp

Maximum Proc
mov ax,word ptr [ebx]
mov maxx,ax

add bx,2
L1:
cmp cx,0
je endd

mov ax,word ptr [ebx]
cmp ax,maxx
jg update
add bx,2
loop L1

update:
mov maxx,ax
add bx,2
loop L1   ;go check loop again

endd:
ret
Maximum endp
exit
END main

//CAPITAL EXTRACTION
TITLE My First Program (Test.asm)  
INCLUDE Irvine32.inc  

.data  
strr byte "FAST National University Karachi", 0  
output byte 7 dup (0)  ; Corrected to byte instead of dword  

.code  
main Proc  
    mov esi, offset strr  
    mov edi, offset output  
    mov cx, lengthof strr  ; Assumes length includes null terminator  
    dec cx                  ; Adjust to ignore the null terminator  
    call capitalCase  

    mov edx, offset output  
    call writeString  
main endp  

capitalCase Proc  
    cmp cx, 0              ; Check if we have processed all characters  
    je endd  

    mov al, byte ptr [esi] ; Load the current character  
    cmp al, 'A'  
    jb notCap              ; Jump if below 'A'  
    cmp al, 'Z'  
    ja notCap              ; Jump if above 'Z'  

    ; If it's an uppercase letter  
    mov [edi], al          ; Store the uppercase letter  
    inc edi                 ; Move to next byte in output  

notCap:  
    inc esi                ; Move to the next character in input  
    dec cx                 ; Decrement the character count  

    push cx                ; Save registers before calling recursively  
    push esi  
    push edi  
    call capitalCase       ; Recursive call  
    pop edi                ; Restore registers  
    pop esi  
    pop cx  
endd:  
    ret                    ; Properly return from the procedure  
capitalCase endp  

exit  
END main

//COUNTING 
.386  
.model flat, stdcall  
stderr equ 2  
include Irvine32.inc  

.data  
    prompt  BYTE "Enter an integer: ", 0  
    output  BYTE "The binary representation has ", 0  
    odd_msg BYTE " an odd number of 1's.", 0  
    even_msg BYTE " an even number of 1's.", 0  
    totalOnes DWORD ?  

.code  
main PROC  
    ; Prompt user for an integer input  
    WriteString prompt   
    ReadInt totalOnes ; Read user integer  

    ; Initialize count of 1s  
    mov eax, totalOnes ; Move the input number into EAX  
    xor ecx, ecx      ; Clear ECX, this will count the 1s  

count_ones:  
    test eax, 1       ; Test least significant bit  
    jz skip_increment  ; If zero, skip incrementing count  
    inc ecx           ; If one, increment count  
skip_increment:  
    shr eax, 1        ; Shift right by 1 to check next bit  
    test eax, eax     ; Check if eax is 0 (all bits checked)  
    jnz count_ones    ; If not zero, repeat  

    ; Determine if the count of 1s is odd or even  
    test ecx, 1       ; Test the least significant bit of the count  
    jz even_count      ; If zero, it's even  

    ; Output odd case  
    WriteString output  
    WriteInt ecx  
    WriteString odd_msg  
    jmp finish  

even_count:  
    ; Output even case  
    WriteString output  
    WriteInt ecx  
    WriteString even_msg  

finish:  
    ExitProcess 0  
main ENDP  
END main
