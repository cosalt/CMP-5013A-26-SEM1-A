.data # this .data section is where you can simulate stored data in random access memory 

	#my student number: 100512236
	array: .word 1, 2, 2, 3, 6 # you can write any label which ends in a colon such as 'array:' <- PUT YOUR STUDENT NUMBERS HERE
	length: .word 5 # <--- THIS IS THE NUMBER OF ELEMENTS IN THE ARRAY
	
	
.text #this section is where you write your main script

	main:
		la $t0, array # la is load address base address  <---- loads the base ADDRESS of the array into $t0
		li $t1, 0     # i=0 
		lw $t2, length #store length 5 into $t2
		li $t3, 0 #sum = 0
 		
############### COMPLETE YOUR CODE BELOW THIS LINE #######	

		###
		#sum all values in the array

		SUM:	#loop through the array and sum all data
	 	lw $t4, 0($t0) #load array data at position $t0 into $t4
	 	add $t3, $t4, $t3 #sum current total with data at array index specified by $t4
	 	addi $t0, $t0, 4 #shift $t0 to next index
	 	addi $t1, $t1, 1 #increment i
	 	blt $t1, $t2, SUM #if last summed index is less than the array length, continue moving through the array
	 	la $s0, ($t3) #store the sum of array values in $s0
	 	
	 	la $t0, array #reset to base address for next loop
	 	la $t1, 0 #reset to 0 for next loop
	 	
	 	###
	 	#find the mean of all values in the array
	 	
	 	AVG:	#using the sum, divide by the length of the array to calculate the mean
	 	div $s0, $t2 #divide the sum of the array data by the number of array elements
	 	mflo $s1 #store the result of the division in $s1 (the remainder is ignored) by moving from the lo regitster
	 	
	 	###
	 	#find the greatest value in the array
	 	
	 	li $t5, 0 #starting comparison number for maximum
	 	MAX:	#loop through the array, and compare each data point against the greatest of all previously checked data, starting from 0
	 	lw $t4, 0($t0) #load array data at position $t0 into $t4
	 	bgt $t4, $t5, NEWMAX #is array($t0) greater than the previous recorded maximum (starting at 0)? if no, continue, if yes, branch to NEWMAX
	 	addi $t0, $t0, 4 #shift $t0 to next index
	 	addi $t1, $t1, 1 #increment i
	 	blt $t1, $t2, MAX #if last compared index is less than the array length, continue moving through the array
	 	j EOMAX #if last compared index is equal to the array length, go directly to E(nd)O(f)MAX
	 	NEWMAX:	#is branched to when the compared data is greater than the previous recorded maximum
	 	la $t5, ($t4) #if the read array data was greater than the previous maximum, overwrite $t5 with that data.
	 	addi $t0, $t0, 4 #shift $t0 to next index
	 	addi $t1, $t1, 1 #increment i
	 	blt $t1, $t2, MAX #if last compared index is less than the array length, continue moving through the array
	 	EOMAX: #is jumped to when there are no more elements in the array
	 	la $s2, ($t5) #store the maximum value in $s2
	 	
	 	la $t0, array #reset to base address for next loop
	 	la $t1, 0 #reset to 0 for next loop
	 	
	 	###
	 	#find the lowest value in the array
	 	
	 	la $t6, ($s2) #starting comparison number for minimum
	 	MIN:	#loop through the array, and compare each data point against the lowest of all previously checked data, starting from the maximum
	 	lw $t4, 0($t0) #load array data at position $t0 into $t4
	 	blt $t4, $t6, NEWMIN #is array($t0) less than the previous recorded minimum (starting at the maximum)? if no, continue, if yes, branch to NEWMIN
	 	addi $t0, $t0, 4 #shift $t0 to next index
	 	addi $t1, $t1, 1 #increment i
	 	blt $t1, $t2, MIN #if last compared index is less than the array length, continue moving through the array
	 	j EOMIN #if last compared index is equal to the array length, go directly to E(nd)O(f)MIN
	 	NEWMIN:	#is branched to when the compared data is less than the previous recorded minimum
	 	la $t6, ($t4) #if the read array data was less than the previous minimum, overwrite $t6 with that data.
	 	addi $t0, $t0, 4 #shift $t0 to next index
	 	addi $t1, $t1, 1 #increment i
	 	blt $t1, $t2, MIN #if last compared index is less than the array length, continue moving through the array
	 	EOMIN: #is jumped to when there are no more elements in the array
	 	la $s3, ($t6) #store the maximum value in $s3
	 	#this is the end of the program, so there is no need to reset the loop counter or the array index counter
	 	
################COMPLETE YOUR CODE ABOVE THIS LINE #######
		
		
		#terminate program 
		li $v0 10     #### THIS IS A GOOD WAY TO END THE PROGRAM BY PUTTING THE VALUE 10 INTO $v0 AND USING SYSCALL
		syscall
