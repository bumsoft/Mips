.data
	msg_newline5: .asciiz "\n\n\n\n\n"
	msg_newline1: .asciiz "\n"
	msg_divline: .asciiz "=============\n"
	msg_divline_: .asciiz "-------------\n"
	
	#MENU
	msg_menu0: .asciiz "    MENU\n"
	msg_menu1: .asciiz "    1. ADD\n"
	msg_menu2: .asciiz "    2. SHOW\n"
	msg_menu3: .asciiz "    3. SEARCH\n"
	msg_menu4: .asciiz "    4. DELETE\n"
	msg_menu5: .asciiz "CHOOSE MENU NUM: "
	
	msg_add: .asciiz "ADD\n"
	msg_name: .asciiz "NAME: "
	msg_phone: .asciiz "PHONE: "
	
	msg_show: .asciiz "SHOW ALL\n"
	msg_empty: .asciiz "Address Book is Empty\n"
	msg_id: .asciiz "ID: "

	msg_search: .asciiz "SEARCH\N"
	msg_not_found: .asciiz "Not Found\n"

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
screen0: # menu screen
	bne $s0, $zero, screen1 #if(screen != 0) -> screen1
	
	jal drawScreen0
	
	jal getIntegerInput
	move $s0, $v0
	
	j mainLoop
	
screen1: # add screen
	bne $s0, $s1, screen2 #if(screen != 1) -> screen2
	
	jal drawScreen1
	
	jal makeNode
	move $t0, $v0 # $t0 = newNode's address
	move $a0, $t0 # pass t0 to append()
	
	jal append
	
	move $s0, $zero # screen = 0
	j mainLoop
	
screen2: # show screen
	bne $s0, $s2, screen3 #if(screen != 2) -> screen3
	
	jal showAll
	
	move $s0, $zero # screen = 0
	j mainLoop

screen3:
	bne $s0, $s3, screen4 #if(screen != 3) -> screen4
	
	jal search
	
	move $s0, $zero # screen = 0
	j mainLoop
	
screen4:

exit:
    li   $v0, 10
    syscall


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
	li $a0, 16
	li $v0, 9
	syscall
	move $t0, $v0 #t0 : newNode's address
	
	###################ID##################
	la $t1, num  #num's address
	lw $t2, 0($t1) #num's value
	
	sw $t2, 0($t0) # newNode->id = num
	
	addi $t2, $t2, 1 # num++
	sw $t2, 0($t1)
	##################NAME################
	li $a0, 20
	li $v0, 9
	syscall
	move $t3, $v0 #t3 : name's address
	
	la $a0, msg_name
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

	la $a0, msg_phone
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
	
	move $v0, $t0
	jr $ra #return

append:
	la $t0, head
	lw $t1, 0($t0)
	
	bne $t1, $zero, append_else #if(head == NULL)
	sw $a0, 0($t0) #head = newNode
	jr $ra
append_else:
	move $t2, $t1 # temp = head
append_while:
	lw $t3, 12($t2) # t3 = temp->next
	beq $t3, $zero, append_while_exit #if(temp->next == NULL) break;
	move $t2, $t3
	j append_while
append_while_exit:
	sw $a0, 12($t2) # temp->next= newNode
	jr $ra #return

##########################################################################
showAll:
	#draw
	la $a0, msg_newline5 # \n\n\n\n\n
	li $v0, 4
	syscall
	
	la $a0, msg_divline # ============
	li $v0, 4
	syscall
	
	la $a0, msg_show # SHOW ALL
	li $v0, 4
	syscall
	
	la $a0, msg_divline # ============
	li $v0, 4
	syscall
	# draw end
	
	la $t0, head
	lw $t1, 0($t0)
	
	bne $t1, $zero, showAll_else # if(head == NULL)
	
	la $a0, msg_empty # "Address Book is Empty"
	li $v0, 4
	syscall
	
	jr $ra #return
showAll_else:
	move $t2, $t1 # t2 = temp = head
showAll_while:
	beq $t2, $zero, showAll_while_exit # if(temp == NULL) break
	
	lw $t3, 0($t2) # t3: id
	lw $t4, 4($t2) # t4: name
	lw $t5, 8($t2) # t5: phone
	lw $t6, 12($t2) #t6: nextNode's address
	
	la $a0, msg_id # ID: 
	li $v0, 4
	syscall
	
	move $a0, $t3
	li $v0, 1
	syscall
	
	la $a0, msg_newline1
	li $v0, 4
	syscall
	
	la $a0, msg_name # NAME: 
	li $v0, 4
	syscall
	
	move $a0, $t4
	li $v0, 4
	syscall
	
	la $a0, msg_phone # PHONE: 
	li $v0, 4
	syscall
	
	move $a0, $t5
	li $v0, 4
	syscall
	
	la $a0, msg_divline_ # ---------
	li $v0, 4
	syscall
	
	move $t2, $t6 # temp = temp->next
	j showAll_while
showAll_while_exit:
	jr $ra #return

#######################################################
search:
	addi $sp, $sp, -8
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	
	la $a0, msg_newline5 #\n\n\n\n\n
	li $v0, 4
	syscall
	
	la $a0, msg_divline #==========
	li $v0, 4
	syscall
	
	la $a0, msg_search #SEARCH
	li $v0, 4
	syscall
	
	la $a0, msg_divline #===========
	li $v0, 4
	syscall
	
	li $a0, 20
	li $v0, 9
	syscall
	
	move $s0, $v0 # name = malloc(20)
	
	la $a0, msg_name # NAME: 
	li $v0, 4
	syscall
	
	move $a0, $s0
	move $a1, 20
	li $v0, 8
	syscall #input target_name
	
	la $a0, msg_divline_ # ------------
	li $v0, 4
	syscall
	
	move $a0, $s0
	jal find
	
	bne $v0, $zero, search_exit
	la $a0, msg_not_found
	li $v0, 4
	syscall

search_exit:
	lw $ra, 0($sp)
	lw $s0, 4($sp)
	addi $sp, $sp, 8
	jr $ra #return
	
find:
	addi $sp, $sp, -24
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	sw $s1, 8($sp)
	sw $s2, 12($sp)
	sw $s3, 16($sp)
	sw $s4, 20($sp)
	
	move $s0, $a0
	
	la $s1, head
	lw $s2, 0($s1) $ # temp = head
	
	move $s3, $zero # count = 0
	
find_while:
	beq $s2, $zero, find_while_exit #if(temp == NULL) break
	lw $s4, 4($s2) # name = temp->name
	
	move $a0, $s0
	move $a1, $s4
	jal stringCompare
	#start here!
	beq $v0, $zero, find_while_else
	#cnt++
	#printf....

find_while_else:
	lw $s2, 12($s2) #??
	
find_while_exit:
	move $v0, $s3
	
	lw $ra, 0($sp)
	lw $s0, 4($sp)
	lw $s1, 8($sp)
	lw $s2, 12($sp)
	lw $s3, 16($sp)
	lw $s4, 20($sp)
	addi $sp, $sp, 24
	
	jr $ra

stringCompare:
	addi $sp, $sp, -16
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	sw $s1, 8($sp)
	sw $s2, 12($sp)
	
	move $s0, $a0
	move $s1, $a1	
	move $s2, $zero # index = 0
	
stringCompare_while:
	# change string's start address (mips doesn't support things like "lw $t1, $t0($a0)")
	add $t0, $s0, $s2 # a + index
	add $t1, $s1, $s2 # b + index
	
	lw $t2, 0($t0) # ca = *(a+index)
	lw $t3, 0($t1) # cb = *(b+index)
	
	bne $t2, $t3, stringCompare_false #if(ca != cb) return 0
	beq $t2, $zero, stringCompare_true #if(ca == '\0') return 1
	
	addi $s2, $s2, 1 #index++
	j stringCompare_while
	
stringCompare_false:
	move $v0, $zero
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	sw $s1, 8($sp)
	sw $s2, 12($sp)
	addi $sp, $sp, -16
	jr $ra

stringCompare_true:
	li $v0, 1
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	sw $s1, 8($sp)
	sw $s2, 12($sp)
	addi $sp, $sp, -16
	jr $ra