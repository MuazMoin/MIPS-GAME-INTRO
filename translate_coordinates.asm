.data
INPUT_RIJ: .asciiz "Voer het rijnummer in: "
INPUT_KOLOM: .asciiz "Voer het kolomnummer in: "
OUTPUT_STRING: .asciiz "Het geheugenadres voor de pixel is: "

.text
main:

	addi $sp, $sp, -16 # Reserveer ruimte op de stack

	sw $ra, 0($sp) # Bewaar de return address op de stack
    	sw $s0, 4($sp) # Bewaar register $s0 op de stack
   	sw $s1, 8($sp) # Bewaar register $s1 op de stack
   	sw $t2, 12($sp) # Bewaar register $t2 op de stack
  
#RIJ  	
   	li $v0, 4
    	la $a0, INPUT_RIJ
    	syscall
    	
    	li $v0, 5
    	syscall
    	sw $v0, 4($sp) # Bewaar het ingevoerde rijnummer op de stack
    	
#KOLOM
    	li $v0, 4
    	la $a0, INPUT_KOLOM
   	syscall
   	
   	li $v0, 5
    	syscall
    	sw $v0, 8($sp) # Bewaar het ingevoerde kolomnummer op de stack
    	
#GEHEUGENADRES
	lw $s0, 4($sp) # Laad het ingevoerde rijnummer in $s0
	li $t2, 32 # Breedte van het scherm
    	mul $t3, $s0, $t2 #(rijnummer * breedte van het scherm)
    	lw $s1, 8($sp) # Laad het ingevoerde kolomnummer in $s1
    	add $t4, $t3, $s1 #(geheugenadres = rijnummer * breedte + kolomnummer)
    	
#PIXEL
	mul $t5, $t4, 4 # Elke pixel is 32 bits
	
#DEF_GEHEUGENADRES
	add $t6, $t5, $gp # $t6 bevat nu het uiteindelijke geheugenadres
	
#PRINT STRING
	li $v0, 4
    	la $a0, OUTPUT_STRING
    	syscall
#PRINT GA
	li $v0, 1
    	move $a0, $t6
    	syscall
    	
    	lw $ra, 0($sp)
    	addi $sp, $sp, 16
#einde
    	li $v0, 10 #Beëindig het programma
    	syscall
