TITLE My First Program (SortingProject.asm)
INCLUDE Irvine32.inc

.data
numberofdata DWORD ?        ; Number of elements in the array
array DWORD 100 DUP (?)         ; Array to store user input values
prompt BYTE "Enter number of elements to sort: ",0
promptInput BYTE "Enter data:", 0
promptOutput BYTE "Sorted output:", 0
menu BYTE "Choose Sorting Algorithm:", 0
menu1 BYTE "1. Bubble Sort", 0
menu2 BYTE "2. Shell Sort", 0
menu3 BYTE "3. Insertion Sort", 0
menu4 BYTE "4. Count Sort", 0
menu5 BYTE "5. Selection Sort", 0
menu6 BYTE "6. Quick Sort",0
menu7 BYTE "7. Comb Sort",0
invalidChoice BYTE "Invalid choice. Exiting program.", 0
choice DWORD ?              
freqArray DWORD 101 DUP(0)       ; Frequency array for CountSort (size = max value + 1)
temp dword ?
key dword ?

.code
main PROC
    mov edx, OFFSET prompt
    call WriteString
    call readDec
    mov numberofdata,eax

    mov edx, OFFSET promptInput
    call writestring
    call crlf

    call InputArray
    
    ;DISPLAY MENU
    call crlf
    mov edx, OFFSET menu
    call WriteString
    call crlf
    mov edx, OFFSET menu1
    call WriteString
    call crlf
    mov edx, OFFSET menu2
    call WriteString
    call crlf
    mov edx, OFFSET menu3
    call WriteString
    call crlf
    mov edx, OFFSET menu4
    call WriteString
    call crlf
    mov edx, OFFSET menu5
    call WriteString
    call crlf
    mov edx, OFFSET menu6
    call WriteString
    call crlf
    mov edx, OFFSET menu7
    call WriteString
    call crlf

    call readDec
    mov choice, eax

    ;choosing sort based on user's choice
    cmp choice, 1
    je BubbleSortArray
    cmp choice, 2
    je Shellsort
    cmp choice, 3
    je insertionsort
    cmp choice, 4
    je CountSort
    cmp choice, 5
    je SelectionSort
    cmp choice, 7
    je CombSort
    cmp choice, 6
    jne nexttt
    mov ebx, numberofdata 
    dec ebx
    push ebx
    mov eax, offset array
    push eax
    call QuickSort
    pop eax
    pop ebx
    nexttt:
    
    ;Invalid choice
    mov edx, OFFSET invalidChoice
    call WriteString
    jmp exitt

exitt:
ret
main ENDP

; Procedure to input elements into the array
InputArray PROC uses ecx esi
    mov ecx, numberofdata      ; Set loop counter to number of elements
    mov esi, 0                

InputLoop:
    call readdec               ; Read a decimal input from the user
    mov array[esi], eax        
    add esi, TYPE array        
    loop InputLoop             ; Repeat for each element
    ret
InputArray ENDP

; Procedure to print elements of the array
PrintArray PROC uses ecx eax esi
    mov ecx, numberofdata      ; Set loop counter to number of elements
    mov esi, 0              
    mov edx, OFFSET promptOutput
    call writestring
    call crlf

PrintLoop:
    mov eax, array[esi]        
    call writedec              ; Print the value in eax
    call crlf                  
    add esi, TYPE array       
    loop PrintLoop             
    ret
PrintArray ENDP


; Procedure to sort the array using Bubble Sort algorithm
BubbleSortArray PROC uses ecx edx eax ebx
    mov ecx, numberofdata 
    dec ecx
L1:
   mov edx, ecx
   mov esi, 0
   L2:
      mov ebx,array[esi]
      mov eax, array[esi+type  array]
      cmp eax, ebx
      JL swapping
      back:
      add esi,4
      loop L2
    mov ecx, edx
    loop L1
jmp quitt
   
swapping:
mov eax, array[esi]
xchg  eax, array[esi+type  array]
mov array[esi], eax 
mov eax , 5
cmp eax, 1                 
jne back
quitt:
jmp PrintArray
    ret
BubbleSortArray ENDP



Shellsort proc uses ecx edx eax ebx
    mov eax, numberofdata
    shr eax, 1                              ; gap = size / 2
    mov ebx, eax                            ; store gap in EBX for the outer loop

OuterLoop:
    cmp ebx, 0                              ; while gap > 0
    jle EndSort                             ; exit if gap <= 0

    ; Inner loop starts: for (j = gap; j < size; j++)
    mov ecx, ebx                            ; j = gap
InnerLoop:
    cmp ecx, numberofdata                   ; if j >= size, break inner loop
    jge EndInnerLoop

    ; temp = array[j]
    mov esi, OFFSET array                   ; array base address
    mov eax, [esi + ecx * type array]       ; temp = array[j]
    
    ; res = j
    mov edi, ecx                            ; res = j

WhileLoop:
    ; while (res >= gap && array[res - gap] > temp)
    cmp edi, ebx                            ; if res < gap, exit while loop
    jl EndWhileLoop

    ; Check if array[res - gap] > temp
    mov edx, edi                            ; calculate (res - gap) * 4
    sub edx, ebx                            ; edx = res - gap
    mov edx, [esi + edx * type array]       ; load array[res - gap] into edx
    cmp edx, eax                            ; compare array[res - gap] with temp
    jle EndWhileLoop

    ; array[res] = array[res - gap]
    mov [esi + edi * type array], edx       ; array[res] = array[res - gap]
    
    ; res -= gap
    sub edi, ebx                            ; res -= gap
    jmp WhileLoop                           ; repeat while loop

EndWhileLoop:
    ; array[res] = temp
    mov [esi + edi * type array], eax                ; array[res] = temp

    ; Increment j in the inner loop
    inc ecx
    jmp InnerLoop

EndInnerLoop:
    ; gap /= 2
    shr ebx, 1                              ; gap = gap / 2
    jmp OuterLoop
EndSort:
jmp PrintArray
ret
Shellsort endp

;INSERTION SORT ALGORITHM
insertionsort PROC
mov ecx, numberofdata
mov esi, OFFSET array  
mov eax, 1        ;i=1

forLoop:
cmp eax,ecx            ;checking if i<numberofdata
jge FinSort

mov edx, eax           ;temporarily storing i for j
mov edi, edx           ;j=i
mov ebx, [esi+edx*type array]   ;key=array[i]
mov key,ebx

whileLoop:
cmp edi,0 ;j>0
jle assignKey ;if j<=0 exit loop and assign key

mov edx,edi  ;for calculating j-1
dec edx
mov ebx, [esi+edx*type array]  ;arr[j-1]

cmp ebx,key      ;cmp arr[j-1] and key
jle assignKey    ;arr[j-1]<=key

mov [esi+ edi * 4],ebx  ;arr[j]=arr[j-1]
dec edi     ;j--
jmp whileLoop

assignKey:
mov ebx,key              ;loading key into ebx
mov [esi+edi * 4],ebx    ;arr[j]=key
inc eax                  ;i++
jmp forLoop

FinSort:
jmp PrintArray
ret 
insertionsort ENDP


;Count Sort Procedure
CountSort PROC uses ecx edx eax esi edi
    ;Step 1: Find the max element
    mov eax, array[0]              ; Assume first element is the max
    mov ecx, numberofdata
    lea esi, array                 ; Load base address of array into ESI

FindMax:
    mov edx, [esi]                 ; Load array element
    cmp edx, eax
    jle SkipMax
    mov eax, edx                   ; Update max if found
SkipMax:
    add esi, TYPE array            ; Move to the next element
    loop FindMax

    ; Step 2: Build the frequency array
    lea edi, freqArray             ; Load address of freqArray
    mov ecx, numberofdata          ; Loop through the original array
    lea esi, array
    xor edx, edx                   ; Clear index

BuildFrequency:
    mov eax, [esi]                 ; Load current array element
    inc DWORD PTR [edi + eax * type array]  ; Increment its frequency count
    add esi, TYPE array            ; Move to the next element
    loop BuildFrequency

    ; Step 3: Rebuild the array
    lea esi, array                 ; Load base address of array
    xor eax, eax                   ; Index in freqArray
RebuildArray:
    mov edx, [edi + eax * type array]       ; Frequency of the current value
    test edx, edx
    jz SkipRebuild
WriteElements:
    mov [esi], eax                 ; Write the value
    add esi, TYPE array
    dec edx
    jnz WriteElements
SkipRebuild:
    inc eax
    cmp eax, 101                   ; Check if max value is reached
    jl RebuildArray

    jmp PrintArray
    ret
CountSort ENDP


; Procedure to sort the array using Selection Sort algorithm
SelectionSort PROC uses ecx esi edi eax ebx
    mov ecx, numberofdata        ; Outer loop: Iterate through each element
    dec ecx                      ; Last element doesn't need comparison

OuterLoop:
    mov esi, ecx                 ; Set current index as the minimum index
    mov edi, esi
    mov ebx, array[edi * type array ]      ; Assume current element as the smallest

InnerLoop:
    cmp edi, 0                   ; Inner loop: Search for the smallest element
    jl EndInnerLoop

    mov eax, array[edi * type array ]      ; Load element at index edi
    cmp eax, ebx                 ; Compare with the current minimum
    jl SkipUpdate
    mov esi, edi                 ; Update minimum index if smaller element found
    mov ebx, eax                 ; Update the smallest value
SkipUpdate:
    dec edi
    jmp InnerLoop

EndInnerLoop:
    cmp esi, ecx                 ; Swap if a smaller element is found
    je SkipSwap                  ; Skip if no smaller element found
    mov eax, array[ecx * type array]      ; Swap current element with the smallest
    mov array[esi * type array], eax
    mov array[ecx * type array], ebx
SkipSwap:
    loop OuterLoop
    jmp PrintArray
    ret
SelectionSort ENDP



CombSort PROC uses ecx edx eax ebx esi edi
    mov ecx, numberofdata      ; ECX = size of the array
    mov eax, ecx              
    shr eax, 1                 ; Initial gap = size / 2
    mov ebx, eax               ; Store gap in EBX
    mov esi, OFFSET array      ; Base address of the array

CombOuterLoop:
    cmp ebx, 1                 ; If gap <= 1, exit outer loop
    jle CombDone

    mov edi, 0                 ; Initialize index i = 0
CombInnerLoop:
    ; Calculate effective offset for i
    mov eax, edi
    imul eax, type array                ; eax = i * 4 (size of each element in the array)

    ; Check if j = i + gap is out of bounds
    mov edx, ebx
    add edx, edi
    imul edx, type array                ; edx = (i + gap) * 4
    cmp edx, ecx               ; If (i + gap) >= size, break the loop
    jge EndCombInnerLoop

    ; Compare array[i] and array[i + gap]
    mov eax, [esi + edi * 4]   ; eax = array[i]
    mov ebx, [esi + edx]       ; ebx = array[i + gap]
    cmp eax, ebx
    jle SkipSwap

    ; Swap array[i] and array[i + gap]
    mov [esi + edi * type array], ebx   ; array[i] = array[i + gap]
    mov [esi + edx], eax       ; array[i + gap] = eax

SkipSwap:
    inc edi                    ; Move to the next index
    jmp CombInnerLoop          ; Continue inner loop

EndCombInnerLoop:
    ; Reduce the gap by multiplying it by a shrink factor (e.g., 1.3)
    mov eax, ebx               ; Get current gap
    mov edx, 0                 ; Clear high bits for division
    mov ecx, 130               ; Divisor = 1.3 scaled by 100
    imul eax, 100              ; Scale gap by 100
    div ecx                    ; Divide by 130
    test eax, eax              ; Check if gap is zero
    jnz ValidGap
    mov eax, 1                 ; Set gap to 1 if zero

ValidGap:
    mov ebx, eax               ; Update gap
    jmp CombOuterLoop          ; Repeat outer loop

CombDone:
    jmp PrintArray
    ret
CombSort ENDP






;void QuickSort(void *pArray, int nItems);
QuickSort PROC
    
    ;These registers must be restored at the end
    push EBP
    mov EBP, ESP
    push EBX
    push ESI
    push EDI
   
    ;EBP + 8    is the array
    ;EBP + 12   is the number of items in the array
   
    mov ESI, [EBP+8]    ;ESI is the array
   
    ;setting ECX to the number of items
    ;we multiply by 4 (size of the element) in order to put ECX
    ;at the last address of the array
    mov EAX, [EBP+12]
    mov ECX, type array
    mul ECX
    mov ECX, EAX
   
    ;EAX will be our 'low index', we initially set it to 0
    xor EAX, EAX
   
    ;EBX will be our 'high index', we initially set it to
    ;the last element of the array (currently stored in ECX)
    mov EBX, ECX
   
    ;We now call our recursive function that will sort the array
    call Quick
       
    ;Restoring the registers
    pop EDI
    pop ESI
    pop EBX
    pop EBP

    jmp PrintArray
    RET
QuickSort ENDP



;;Recursive QuickSort function
Quick PROC
QuickRecursive:
   
    ;if lowIndex >= highIndex, we exit the function
    cmp EAX, EBX
    jge PostIf
   
    push EAX    ;saving our low index, now EAX is 'i'
    push EBX    ;saving our high index, now EBX is 'j'
    add EBX, type array  ;j = high + 1
   
    ;EDI is our pivot
    ;pivot = array[lowIndex];
    mov EDI, [ESI+EAX]
   
    MainLoop:

        iIncreaseLoop:
           
            ;i++
            add EAX, type array
           
            ;If i >= j, exit this loop
            cmp EAX, EBX
            jge End_iIncreaseLoop
           
            ;If array[i] >= pivot, exit this loop
            cmp [ESI+EAX], EDI
            jge End_iIncreaseLoop
           
            ;Go back to the top of this loop
            jmp iIncreaseLoop

        End_iIncreaseLoop:
       
        jDecreaseLoop:
       
            ;j--
            sub EBX, 4
           
            ;If array[j] <= pivot, exit this loop
            cmp [ESI+EBX], EDI
            jle End_jDecreaseLoop
           
            ;Go back to the top of this loop
            jmp jDecreaseLoop

        End_jDecreaseLoop:
       
        ;If i >= j, then don't swap and end the main loop
        cmp EAX, EBX
        jge EndMainLoop
       
        ;Else, swap array[i] with array [j]
        push [ESI+EAX]
        push [ESI+EBX]
       
        pop [ESI+EAX]
        pop [ESI+EBX]
       
        ;Go back to the top of the main loop
        jmp MainLoop
       
    EndMainLoop:       
   
    ;Restore the high index into EDI
    pop EDI
   
    ;Restore the low index into ECX
    pop ECX
   
    ;If low index == j, don't swap
    cmp ECX, EBX
    je EndSwap
   
    ;Else, swap array[low index] with array[j]
    push [ESI+ECX]
    push [ESI+EBX]
       
    pop [ESI+ECX]
    pop [ESI+EBX]
       
    EndSwap:

    ;Setting EAX back to the low index
    mov EAX, ECX
   
    push EDI    ;Saving the high Index
    push EBX    ;Saving j
   
    sub EBX, type array  ;Setting EBX to j-1
   
    ;QuickSort(array, low index, j-1)
    call QuickRecursive
   
    ;Restore 'j' into EAX
    pop EAX
    add EAX, type array  ;setting EAX to j+1
   
    ;Restore the high index into EBX
    pop EBX
   
    ;QuickSort(array, j+1, high index)
    call QuickRecursive
   
    PostIf:

RET

Quick Endp
END main
