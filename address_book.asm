.data
	.msg_newline5: .asciiz "\n\n\n\n\n"
	.msg_divline: .asciiz "============="
	
	#메뉴 문자열
	.msg_menu0: .asciiz "    MENU\n";
	.msg_menu1: .asciiz "    1. ADD\n";
	.msg_menu2: .asciiz "    2. SHOW\n";
	.msg_menu3: .asciiz "    3. SEARCH\n";
	.msg_menu4: .asciiz "    4. DELETE\n";
	.msg_menu5: .asciiz "CHOOSE MENU NUM: "
	
	#ADD 문자열
	.msg_name: .asciiz "NAME: "
	.msg_phone: .asciiz "PHONE: "
	
	#SHOW 문자열
	.msg_empty: .asciiz "Address Book is Empty\n"


	#HEAD노드
	head: .word 0
	num: .word 0 
.text

.globl main
main:
	#시작
	li $s0, 0 #screen = 0; 초기 화면번호
	li $s1, 1 #case1
	li $s2, 2 #case2
	li $s3, 3 #case3
	li $s4, 4 #case4
	
mainLoop: # while루프
	beq $s0, $zero, case_0
	beq $s0, $s1, case_1
	beq $s0, $s2, case_2
	beq $s0, $s3, case_3
	beq $s0, $s4, case_4
	
	
case_0: #MENU 화면
	
	