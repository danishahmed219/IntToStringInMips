.data
	IntStr: .space 1024
.text

.globl main
main:
	
	li $a0, 26533846
	la $a1,IntStr
	jal IntToString

	li $v0,4
	la $a0, IntStr
	syscall


Exit:
	li $v0,10	#exit
	syscall
	
	


#a0 = int expected, 
#$a1 = address of your arr which you are intend to use as a string
.globl IntToString
IntToString:
	sw $ra,($sp)
	sub $sp,$sp,4
	
	li $t1,10
	move $s2, $a0
	move $t4, $a1		
	
	divLoop:
	div $s2, $t1
	mfhi $t3
	mflo $s2
	add $t3,$t3,48
	sb $t3,($t4)
	add $t4, $t4, 1
	bne $s2, $zero, divLoop
	
	
	move $t0,$a1
	jal getLengthStr
	
	move $t0,$a1
	move $t4,$a1
	
	add $t4, $t4 , $t3

	sub $t4, $t4,1
	
	div $t3,$t3,2
	
	li $t1,0 	#reset to 0
	
	reverseLoop:
	
	lb $t2,($t0)
	lb $t5,($t4)
	
	sb $t5,($t0)
	sb $t2,($t4)
	
	add $t1, $t1, 1
	
	sub $t4, $t4, 1
	add $t0, $t0, 1
	
	blt $t1,$t3,reverseLoop
	
	add $sp,$sp,4
	lw $ra,($sp)
	jr $ra
	
	
.globl getLengthStr
getLengthStr:
	
	sw $ra,($sp)
	sub $sp,$sp,4
	
	li $t3,0
	
	loop:
		lb $t2,($t0)
		add $t0,$t0,1
		
		beq $t2,' ',Detect
		add $t3,$t3,1			 		 
	  
	  Condt:
	  bne $t2,'\0',loop 
	
	  j end
	  
	  Detect:
	  	j Condt
	  
	  end:
	  
	  sub $t3, $t3, 1
	  
	  add $sp,$sp,4
	  lw $ra,($sp)
	  jr $ra
