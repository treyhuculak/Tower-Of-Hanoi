.data
prompt: .asciiz "\nEnter the number of disks you would like to solve for: "
str1: .asciiz "Move disk "
str2: .asciiz " from peg "
str3: .asciiz " to peg "
.text
main: 
	li $v0, 4
	la $a0, prompt
	syscall			#print("Enter the number of disks you would like to solve for: ")
	
	li $v0, 5
	syscall			#Take input
	
	add $a0, $zero, $v0	# s1 = numDisks

	li $a1, '1'
	li $a2, '3'
	li $a3, '2'
	
	jal solve
	
	j abs_end
	
solve:	#s1 = n, a1 = fromPeg, a2 = toPeg, a3 = otherPeg
	beq $a0, 0, end
	
	addi $sp, $sp, -20
	sw $ra, 16($sp)
	sw $a0, 12($sp)		#12 loc. = n
	sw $a1, 8($sp)		#8  loc. = fromPeg
	sw $a2, 4($sp)		#4  loc. = toPeg
	sw $a3, 0($sp)		#0  loc. = otherPeg
	
	addi $a0, $a0, -1	#a0 = n-1

	lw $a3, 4($sp)		#a3 = a2, otherPeg = toPeg
	lw $a2, 0($sp)		#a2 = a3, toPeg = otherPeg
	
	jal solve
	
	# RESTORE ALL VALUES
	
	lw $t0, 12($sp)
	lw $a1, 8($sp)
	lw $a2, 4($sp)
	lw $a3, 0($sp)
	
	#--------------- print the statement for the current move
	li $v0, 4
	la $a0, str1
	syscall
	li $v0, 1
	la $a0, ($t0)
	syscall
	li $v0, 4
	la $a0, str2
	syscall
	li $v0, 11
	la $a0, ($a1)
	syscall
	li $v0, 4
	la $a0, str3
	syscall
	li $v0, 11
	la $a0, ($a2)
	syscall
	li $v0, 11
	li $a0, '\n'
	syscall
	#---------------
	
	addi $a0, $t0, -1	#a0 = n-1
	lw $a1, 0($sp)		#a1 = a3, fromPeg = otherPeg
	lw $a3, 8($sp)		#a3 = a1, otherPeg = fromPeg
		
	jal solve
	
	lw $ra, 16($sp)
	addi $sp, $sp, 20
	
end:
	jr $ra
	
abs_end:

	
	
