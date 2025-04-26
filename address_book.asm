.data
	#debug
	msg_d1: .asciiz "here1\n"
	msg_d2: .asciiz "here2\n"
	msg_d3: .asciiz "here3\n"

	msg_newline5: .asciiz "\n\n\n\n\n"
	msg_divline: .asciiz "=============\n"
	
	#�޴� ���ڿ�
	msg_menu0: .asciiz "    MENU\n"
	msg_menu1: .asciiz "    1. ADD\n"
	msg_menu2: .asciiz "    2. SHOW\n"
	msg_menu3: .asciiz "    3. SEARCH\n"
	msg_menu4: .asciiz "    4. DELETE\n"
	msg_menu5: .asciiz "CHOOSE MENU NUM: "
	
	#ADD ���ڿ�
	msg_add: .asciiz "ADD\n"
	msg_name: .asciiz "NAME: "
	msg_phone: .asciiz "PHONE: "
	
	#SHOW ���ڿ�
	msg_empty: .asciiz "Address Book is Empty\n"


	#HEAD���
	head: .word 0 #head���
	num: .word 0  #�����̵�
	
	#.align 2
.text

.globl main
#����
main:
	addi $sp, $sp, -20 #5 * 4byte Ȯ��
	li $t0, 0 #screen = 0; �ʱ� ȭ���ȣ
	sw $t0, 0($sp)
	
	li $t1, 1 #case1
	sw $t1, 4($sp)
	
	li $t2, 2 #case2
	sw $t2, 8($sp)
	
	li $t3, 3 #case3
	sw $t3, 12($sp)
	
	li $t4, 4 #case4
	sw $t4, 16($sp)
	
mainLoop: # while����
	lw $t0, 0($sp)
	lw $t1, 4($sp)
	lw $t2, 8($sp)
	lw $t3, 12($sp)
	lw $t4, 16($sp)

	beq $t0, $zero, case_0
	beq $t0, $t1, case_1
	#beq $t0, $t2, case_2
	#beq $t0, $t3, case_3
	#beq $t0, $t4, case_4
	
	
case_0: #MENU ȭ��
	#ȭ�����
	la $a0, msg_divline
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
	#�Է¹ޱ�
	la $a0, msg_menu5
	li $v0, 4	  
	syscall
	la $v0, 5
	syscall
	sw $v0, 0($sp) #���ÿ� �Է°� ����
	j mainLoop
	
case_1: #ADDȭ��
	#ȭ�����
	la $a0, msg_divline
	li $v0, 4	  
	syscall
	la $a0, msg_add
	li $v0, 4	  
	syscall
	la $a0, msg_divline
	li $v0, 4	  
	syscall
	
	#�� ��� �����(makeNode())
	jal makeNode
	move $a0, $v0 #a0 = ����ּ�, ���ڷ� �ѱ����
	
	jal append
	
	addi $t0, $zero, 0 #screen = 0
	sw $t0, 0($sp)
	j mainLoop
	
	
	
	
	
makeNode: #������Է� �� �� ��� �����

	#��� �Ҵ�ޱ�(16bytes)
	li $a0, 16
	li $v0, 9
	syscall
	move $t0, $v0 #t0 = ����ּ�
	
	#�̸� �Ҵ�ޱ�(20bytes)
	li $a0, 20
	li $v0, 9
	syscall
	move $t1, $v0 #t1 = �̸��ּ�
	#�̸� �Է¹ޱ�
	la $a0, msg_name
	li $v0, 4	  
	syscall
	move $a0, $t1
	li $a1, 20
	li $v0, 8
	syscall
	
	#�� �Ҵ�ޱ�(20bytes)
	li $a0, 20
	li $v0, 9
	syscall
	move $t2, $v0 #t2 = ���ּ�
	#�� �Է¹ޱ�
	la $a0, msg_phone
	li $v0, 4	  
	syscall
	move $a0, $t2
	li $a1, 20
	li $v0, 8
	syscall
	
	#id
	la $t3, num #t3 = num �ּ�
	lw $t4, 0($t3) #t4 = num ��
	
	sw $t4, 0($t0) #node->id = id
	sw $t1, 4($t0) #node->name = name
	sw $t2, 8($t0) #node->phone = phone
	sw $zero, 12($t0) #node->next = 0
	
	addi $t4, $t4, 1 #num = num + 1
	sw $t4, 0($t3)
	
	move $v0, $t0
	jr $ra
	
append:
	addi $sp, $sp, -4
	sw $ra, 0($sp) #��ȯ�ּ� ����

	la $t0, head #t0 = ����ּ��� �ּ� = &head (Node* head)
	lw $t1, 0($t0) #t1 = ����ּ� = head
	move $t2, $a0 #t2 = newNode
	
	beq $t1, $zero, headIsNull
	
	move $t3, $t1 #t3 = temp = head
	jal appendLoop
	
	sw $t2 , 12($t3)
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra #append ȣ���������� ����
	
	
headIsNull:
	sw $t2, 0($t0) # head = newNode
	addi $sp, $sp, 4
	jr $ra #append ȣ���������� ����
	
appendLoop: #temp -> next == NULL���� ����
	lw $t4, 12($t3) # t4 = temp->next
	beq $t4, $zero, returnLabel #if(temp->next == NULL) 
	move $t3, $t4 #temp = temp->next
	j appendLoop #�ݺ�

returnLabel:
	jr $ra #break
