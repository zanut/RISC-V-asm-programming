.data
a: .word 1, 2, 3, 4, 5
b: .word 6, 7, 8, 9, 10
text: .string "The dot product is: "
newline: .string "\n"


.text
main:
    la a0, a # load the address of array a
    la a1, b # load the address of array b
    li a2, 5 # length of the arrays

    jal dot_product

    mv t1, a0

    li a0, 4
    la a1, text
    ecall

    li a0, 1
    mv a1, t1
    ecall

    li a0, 4
    la a1, newline
    ecall

    li a0, 10
    ecall

dot_product:
    # check if the length of the arrays is 1
    addi t0, x0, 1
    beq a2, t0, exit_base_case

    # move the first element of the array to by 4
    addi sp, sp, -4
    sw ra, 0(sp)

    # call dot_product(*a+1, *b+1, n-1)
    addi sp, sp, -4
    sw a0, 0(sp)
    addi sp, sp, -4
    sw a1, 0(sp)
    addi a2, a2, -1
    addi a0, a0, 4
    addi a1, a1, 4

    jal dot_product
    
   
    # restore
    lw t1, 0(sp)
    lw t1, 0(t1)
    addi sp, sp, 4
    lw t0, 0(sp)
    lw t0, 0(t0)
    addi sp, sp, 4

    # multiply the first element of the arrays
    mul t0, t0, t1
    add a0, a0 , t0

    # restore
    lw ra, 0(sp)
    addi sp, sp, 4
    jr ra


exit_base_case:
    lw t0, 0(a0)
    lw t1, 0(a1)
    mul a0, t0, t1
    jr ra
