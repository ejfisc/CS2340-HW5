# Ethan Fischer ejf180001
# Assignment 5 - merge 2 ordered lists
#
# Notes:
# list1 and list2 can be any ordered list
# size1 is the size of list1
# size2 is the size of list2
# mergedList should have enough space for all elements of list1 and list2
# mergedSize is the size of mergedList
#
# Nothing inside the main program needs to be changed, just
# modify the data as desired and run the program.
#
# This program loops through each list and adds each element
# to the merged list in order using 3 separate indexes pointing
# to each list, only incremented when an element is added to the
# merged list.


.data
	list1: .word -1,0,1,2,3
	list2: .word -10,-9,-8,4,5,6
	size1: .word 20 # 5 elements * 4 bits per word = 20
	size2: .word 24 # 6 elements * 4 bits per word = 24
	mergedList: .space 44 # 20 + 24 = 44
	mergedSize: .word 44
	space: .asciiz " "
.text
	main:
		# load size values into registers $s0, $s1, and $s2
		lw $s0, size1 # $s0 = size1
		lw $s1, size2 # $s1 = size2
		lw $s2, mergedSize # $s2 = mergedSize
		# set index values for list1, list2 and mergedList to 0
		addi $s3, $zero, 0 # $s3 = 0, index for list1
		addi $s4, $zero, 0 # $s4 = 0, index for list2
		addi $s5, $zero, 0 # $s5 = 0, index for mergedList
		
		# while indexes are less than list sizes
		while: 
			# check that list1 index is less than list1 size
			slt $t0, $s3, $s0 # $t0 = 1 if $s3 < $s0
			# check that list2 index is less than list2 size
			slt $t1, $s4, $s1 # $t1 = 1 if $s4 < $s1
			# check that both are true
			and $t2, $t0, $t1 # $t2 = 1 if $t0 = 1 & $t1 = 1
			# conditional statement
			bne $t2, 1, exitWhile # goes to exit, if $t2 != 1
			if:
				# store list1[$s3] into $t3
				lw $t3, list1($s3) # $t3 = list1[$s3]
				# store list2[$s4] into $t4
				lw $t4, list2($s4) # $t4 = list2[$s4]
				# check that $t3 < $t4
				slt $t5, $t3, $t4 # $t5 = 1 if $t3 < $t4
				# conditional statement
				bne $t5, 1, else # goes to else if $t5 != 1 (if $t3 >= $t4)
				# add element of list1 to merged list
				sw $t3, mergedList($s5) # mergedList[$s5] = $t3
				# increment list1 and mergedList indexes
				addi $s3, $s3, 4 # $s3 += 4
				addi $s5, $s5, 4 # $s5 += 4
				j exitIf # go to exitIf
			else:
				# add element of list2 to merged list
				sw $t4, mergedList($s5) # mergedList[$s5] = $t4
				# increment list2 and mergedList indexes
				addi $s4, $s4, 4 # $s4 += 4
				addi $s5, $s5, 4 # $s5 += 4
			exitIf:
			# jump back to beginning of while loop
			j while # go to while
		exitWhile:
		
		# By now, either list1 or list2 is "empty", empty the rest of the other list to mergedList
		
		# while list1 index is less than list1 size
		empty1:
			# check that list1 index is less than list1 size
			slt $t0, $s3, $s0 # $t0 = 1 if $s3 < $s0
			# conditional statement
			bne $t0, 1, exit1 # go to exit1 if $t0 != 1 (if $s3 >= $s0)
			# store list1[$s3] into $t1
			lw $t1, list1($s3) # $t1 = list1[$s3]
			# add element of list1 to merged list
			sw $t1, mergedList($s5) # mergedList[$s5] = $t1
			# increment list1 and mergedList indexes
			addi $s3, $s3, 4 # $s3 += 4
			addi $s5, $s5, 4 # $s5 += 4
			# jump back to beginning of while loop
			j empty1 # go to empty1
		exit1:
		
		# while list2 index is less than list2 size
		empty2:
			# check that list2 index is less than list2 size
			slt $t0, $s4, $s1 # $t0 = 1 if $s4 < $s1
			# conditional statement
			bne $t0, 1, exit2 # go to exit2 if $t0 != 1 (if $s4 >= $s1)
			# store list2[$s4] into $t1
			lw $t1, list2($s4) # $t1 = list2[$s4]
			# add element of list2 to merged list
			sw $t1, mergedList($s5) # mergedList[$s5] = $t1
			# increment list2 and mergedList indexes
			addi $s4, $s4, 4 # $s4 += 4
			addi $s5, $s5, 4 # $s5 += 4
			# jump back to beginning of while loop
			j empty2 # go to empty2
		exit2:
		
		# print new merged list
		# clear mergedList index to 0
		addi $s5, $zero, 0 # $s5 = 0
		print:
			# conditional statment
			beq $s5, $s2, exitPrint # go to exitPrint if $s5 = $s2
			# print value
			li $v0, 1
			lw $a0, mergedList($s5)
			syscall
			# print space
			li $v0, 4
			la $a0, space
			syscall
			# increment index
			addi $s5, $s5, 4 # $s5 += 4
			# jump back to print while loop
			j print
		exitPrint:
	exitProgram:
		# this exits the program
		li $v0, 10
		syscall
		
		

