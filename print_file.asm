.data
fin: .asciiz "test_file_1.txt"  # filename for input
buffer: .space 2048        # space used as a buffer

.text
.globl main

main:

file_openen:
    li $v0, 13 # Laad het systeemoproepnummer voor het openen van een bestand
    la $a0, fin # Laad het adres van de bestandsnaam in $a0
    li $a1, 0 # Zet $a1 naar de modus "read-only"
    li $a2, 0
    syscall # Voer de systeemoproep uit

    move $s6, $v0  # Save the file descriptor

file_lezen:
    li $v0, 14 # Laad het systeemoproepnummer voor het lezen van een bestand
    move $a0, $s6 # Zet $a0 naar de bestandsdescriptor
    la $a1, buffer # Zet $a1 naar het adres van de buffer
    li $a2, 2048 # Zet $a2 naar het aantal te lezen bytes
    syscall # Voer de systeemoproep uit

print_file:
    li $v0, 4  # Laad het systeemoproepnummer voor het printen van een string
    move $a0, $a1 # Zet $a0 naar het adres van de buffer met de gelezen inhoud
    syscall # Voer de systeemoproep uit

file_sluiten:
    li $v0, 16 # Laad het systeemoproepnummer voor het sluiten van een bestand
    move $a0, $s6 # Zet $a0 naar de bestandsdescriptor
    syscall # Voer de systeemoproep uit

einde:
    li $v0, 10 # Laad het systeemoproepnummer voor het afsluiten van het programma
    syscall # Voer de systeemoproep uit



#Slides Practicum
#volgens chatgpt 3.5 moest ik mijn filepath doorgeven.
