.data
UP_OUTPUT:         .asciiz " up\n"
DOWN_OUTPUT:       .asciiz " down\n"
LEFT_OUTPUT:       .asciiz " left\n"
RIGHT_OUTPUT:      .asciiz " right\n"
UNKNOWN_OUTPUT:    .asciiz " Unknown input! Valid inputs: z s q d x\n"

.text
.globl main

Stackframe: 

    addi $sp, $sp, -8 # Reserveer ruimte voor return address ($ra) en een tijdelijk register ($s0)
    sw $ra, 0($sp) # Bewaar de return address op de stack
    sw $s0, 4($sp) # Bewaar tijdelijk register $s0 op de stack
    
    

main:

Known_karakter:
    li $v0, 12           # Syscall voor read character
    syscall
    move $s0, $v0        # Bewaar het ingevoerde karakter in $s0



    beq $s0, 122, one     # 122 = ascii code z
    beq $s0, 115, two   # 115 = ascii code s
    beq $s0, 113, three   # 113 = ascii code a
    beq $s0, 100, four  # 100 = ascii code d 
    beq $s0, 120, einde # 120 = ascii code x

Unknown_karakter:
    li $v0, 4
    la $a0, UNKNOWN_OUTPUT
    syscall

    j main

one:
    li $v0, 4
    la $a0, UP_OUTPUT
    syscall
    j main

two:
    li $v0, 4
    la $a0, DOWN_OUTPUT
    syscall
    j main

three:
    li $v0, 4
    la $a0, LEFT_OUTPUT
    syscall
    j main

four:
    li $v0, 4
    la $a0, RIGHT_OUTPUT
    syscall
    j main

einde:
    
    lw $ra, 0($sp) # Stackframe herstellen en programma verlaten
    addi $sp, $sp, 8

   
    li $v0, 10  # Beëindig het programma
    syscall
