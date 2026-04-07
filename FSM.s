.text
.globl main

main:

    addi x7,  x0, 0          # x7  = Base address for A (0)
    addi x10, x0, 32         # x10 = Base address for B (32)
    addi x11, x0, 64         # x11 = Base address for C (64)

  
    # INITIALIZE ARRAY A: [1, 5, 9, 6, 4, 6, 9, 2]
   
    addi x20, x0, 1
    sw x20, 0(x7) 
    addi x20, x0, 5  
    sw x20, 4(x7) 
    addi x20, x0, 9  
    sw x20, 8(x7) 
    addi x20, x0, 6  
    sw x20, 12(x7)
    addi x20, x0, 4  
    sw x20, 16(x7)
    addi x20, x0, 6  
    sw x20, 20(x7)
    addi x20, x0, 9  
    sw x20, 24(x7)
    addi x20, x0, 2  
    sw x20, 28(x7)


    # INITIALIZE ARRAY B: [2, 7, 2, 3, 7, 1, 8, 8]

    addi x20, x0, 2  
    sw x20, 0(x10)
    addi x20, x0, 7  
    sw x20, 4(x10)
    addi x20, x0, 2  
    sw x20, 8(x10)
    addi x20, x0, 3  
    sw x20, 12(x10)
    addi x20, x0, 7  
    sw x20, 16(x10)
    addi x20, x0, 1  
    sw x20, 20(x10)
    addi x20, x0, 8  
    sw x20, 24(x10)
    addi x20, x0, 8  
    sw x20, 28(x10)

    # SETUP LOOP COUNTERS
 
    addi x5, x0, 0           # x5 = i (loop counter: 0 to 7)
    addi x6, x0, 8           # x6 = array size = 8

Loop:
    beq  x5, x6, Exit        # if i == 8, exit branch

    # Calculate byte offset from word index: offset = i * 4
    add  x12, x5,  x5        # x12 = i * 2
    add  x12, x12, x12       # x12 = i * 4

    # Calculate exact load/store addresses: &A[i], &B[i], &C[i]
    add  x13, x7,  x12       # x13 = &A[i]
    add  x14, x10, x12       # x14 = &B[i]
    add  x28, x11, x12       # x28 = &C[i]

    # Load A[i] and B[i] (Must use LW to load full word)
    lw   x15, 0(x13)         # x15 = A[i]
    lw   x16, 0(x14)         # x16 = B[i]

    # Compute base sum = A[i] + B[i]
    add  x17, x15, x16       # x17 = sum

    # Check if current index is even or odd
    andi x15, x5, 1          # x15 = i & 1   (0=even, 1=odd)
    beq  x15, x0, Even       # if i is 0 (even), branch to Even block

Odd:
    # Odd index formula: C[i] = A[i] + B[i]
    sw   x17, 0(x28)         # store sum 
    beq  x0, x0, Next        # Unconditional jump to Next (using BEQ)

Even:
    # Even index formula: C[i] = (A[i] + B[i])² 
    addi x16, x0, 0          # result = 0
    add  x15, x17, x0        # counter = sum (copy x17 to x15)

SquareLoop:
    beq  x15, x0, StoreEven  # if counter == 0, squaring is finished
    add  x16, x16, x17       # result += sum
    addi x15, x15, -1        # counter--
    beq  x0, x0, SquareLoop  # Unconditional leap back up

StoreEven:
    sw   x16, 0(x28)         # store final square for even index

Next:
    # Increment outer loop counter
    addi x5, x5, 1
    beq  x0, x0, Loop        # Unconditional jump to Loop

Exit:
    beq  x0, x0, Exit        # Infinite loop to prevent the PC from running into unwritten memory
