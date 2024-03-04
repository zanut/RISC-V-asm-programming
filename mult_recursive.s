.text
main:
    # pass the first argument to a0
    # pass the second argument to a1
    li a0, 110  # a = 110
    li a1, 50   # b = 50

    jal mult  # jump to mult and save position to ra
    
    # print the result
    mv a1, a0

    addi a0, x0, 1
    ecall

    # exit the program
    addi a0, x0, 10
    ecall


mult:
    addi t0, x0, 1
    beq a1, t0, exit_base_case

    # recursive case
    addi sp, sp, -4
    sw ra, 0(sp) # storing the ra value on stack

    # call mult(a, b-1)
    addi sp, sp, -4
    sw a0, 0(sp)
    addi a1, a1, -1
    jal mult

    # a + mults(a, b-1)
    mv t1, a0

    # restore a0
    lw a0, 0(sp)
    addi sp, sp, 4
    add a0, a0, t1

    lw ra, 0(sp) # restore ra
    addi sp, sp, 4
    jr ra

exit_base_case:
    jr ra