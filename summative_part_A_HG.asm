#Summative Part A

.text	#code setup

	main: #good practice formatting
	
	#initialize saved temporary registers
	add $s0 $zero $zero #store zero in $s0
	addi $s1 $zero 3 #store three in $s1
	addi $s2 $zero 7 #store seven in $s2
	
	#branch on X conditions
	blt $s1 $s2 ILT #if $s1 is less than $s2, branch to ILT (Is Less Than)
	j NLT #jump to NLT (Not Less Than) if previous condition not met  
	
		ILT: add $s0 $s1 $s2 #when branching to ILT, add 7 and $s1 and store in $s0
		     j END #jump to the END to finish running
		    
	NLT: add $s0 $s1 $s1 #secondary condition, to run if ILT is not met 
	
	END: #break out of the program, without using syscall, just like Example_A.asm
	
