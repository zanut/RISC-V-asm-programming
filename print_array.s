.data
A: .word 11, 22, 33, 44, 55
space: .string " "
newline: .string "\n"

.text
print_array:
    addi t0, x0, 0
loop1:
    bge to, a1, exit
    slli t1, t0
    add t2, t1, a0
    lw t3, 0(t2)

    #print A[i]

    # save a0, a1 to stack; calller save as ecall realizes that t0 and t1 needed after call
    addi sp, sp, -8
    sw a0, 0(sp)
    sw a1, 4(sp)

    addi a0, x0, 1
    mv a1, t3
    ecall

    
    addi a0, x0, 4
    la a1, space
    ecall

    lw a0, 0(sp)
    lw a1, 4(sp)
    addi sp, sp, 8

    addi t0, t0, 1
    j loop1

exit1:
    addi a0, x0, 4
    la a1, newline
    ecall
    ret