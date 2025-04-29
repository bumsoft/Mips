.data
	#debug
	msg_d1: .asciiz "here1\n"
	msg_d2: .asciiz "here2\n"
	msg_d3: .asciiz "here3\n"

	msg_newline5: .asciiz "\n\n\n\n\n"
	msg_newline1: .asciiz "\n"
	msg_divline: .asciiz "=============\n"
	
	
	msg_menu0: .asciiz "    MENU\n"
	msg_menu1: .asciiz "    1. ADD\n"
	msg_menu2: .asciiz "    2. SHOW\n"
	msg_menu3: .asciiz "    3. SEARCH\n"
	msg_menu4: .asciiz "    4. DELETE\n"
	msg_menu5: .asciiz "CHOOSE MENU NUM: "
	
	msg_add: .asciiz "ADD\n"
	msg_name: .asciiz "NAME: "
	msg_phone: .asciiz "PHONE: "
	
	msg_show: .asciiz "SHOW\n"
	msg_empty: .asciiz "Address Book is Empty\n"
	msg_id: .asciiz "ID: "


	head: .word 0 
	num: .word 0 
.text

.globl main
main:
	li $s0, 0
	li $s1, 1
	li $s2, 2
	li $s3, 3
	li $s4, 4
	
mainLoop:
screen0:
	bne $s0, $zero, screen1 #if(screen != 0) -> screen1
	
	jal drawScreen0
	
	jal getIntegerInput
	move $s0, $v0
	
	j mainLoop
	
screen1:
	bne $s0, $s1, screen2 #if(screen != 1) -> screen2
	
	jal drawScreen1
	
	jal makeNode
	
	#v0 start here!
	
screen2:
	bne $s0, $s2, screen3 #if(screen != 2) -> screen3

screen3:
	bne $s0, $s3, screen4 #if(screen != 3) -> screen4
	
screen4:



drawScreen0:
	la $a0, msg_newline5 #\n\n\n\n\n
	li $v0, 4
	syscall

	la $a0, msg_divline #=======
	li $v0, 4
	syscall
	
	la $a0, msg_menu0
	li $v0, 4
	syscall
	
	la $a0, msg_menu1
	li $v0, 4
	syscall
	
	la $a0, msg_menu2
	li $v0, 4
	syscall
	
	la $a0, msg_menu3
	li $v0, 4
	syscall
	
	la $a0, msg_menu4
	li $v0, 4
	syscall

	la $a0, msg_divline
	li $v0, 4
	syscall
	
	la $a0, msg_menu5
	li $v0, 4
	syscall
	
	jr $ra
	
getIntegerInput:
	li $v0, 5
	syscall
	jr $ra
	
	
drawScreen1:
	la $a0, msg_newline5
	li $v0, 4
	syscall
	
	la $a0, msg_divline
	li $v0, 4
	syscall
	
	la $a0, msg_add
	li $v0, 4
	syscall
	
	la $a0, msg_divline
	li $v0, 4
	syscall
	
	jr $ra
	
makeNode:
	addi $sp, -4
	sw $a0, 0($sp)
	
	li $a0, 16
	li $v0, 9
	syscall
	move $t0, $v0 #t0 : newNode's address
	
	###################ID##################
	la $t1, num  #num's address
	lw $t2, 0($t3) #num's value
	
	sw $t2, 0($t0) # newNode->id = num
	
	addi $t2, $t2, 1 # num++
	sw $t2, 0($t1)
	##################NAME################
	li $a0, 20
	li $v0, 9
	syscall
	move $t3, $v0 #t3 : name's address
	
	li $a0, msg_name
	li $v0, 4
	syscall
	
	move $a0, $t3 #input
	li $a1, 20
	li $v0, 8
	syscall
	
	sw $t3, 4($t0) # newNode-> name = name
	
	#################PHONE###############
	li $a0, 20
	li $v0, 9
	syscall
	move $t4, $v0 #t4 : phone's address

	li $a0, msg_phone
	li $v0, 4
	syscall
	
	move $a0, $t4 #input
	li $a1 20
	li $v0, 8
	syscall
	
	sw $t4, 8($t0) # newNode->phone = phone
	#################NEXT#################
	move $t5, $zero
	
	sw $t5, 12($t0) # newNode->next = 0(NULL)
	
	
	lw $a0, 0($sp)
	addi $sp, 4
	
	move $v0, $t0
	jr $ra
