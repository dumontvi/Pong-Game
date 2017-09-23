.global	_start
_start:	
	#starting address of the pixel buffer
	movia r7,0x08000000
	#to get location (0,1) you do base + (00000000 00000001 0)base2
	#to get loation (1,0) you do base + (00000001 0000000 1)base2
	
	#pixel values are 16 bit values from 0-4 (blue) 5-10 (green) 11-15 (red)

	#define the x location at the right 8 bit value
	movia r5 ,0b000000000000000000
	#define y location at the left 8 bit value
	movia r6 ,0b000000000000000000
	
	add r7,r7,r5
	add r7,r7,r6
	
	
	
	
	
	
	#size of the box
	movi r15,16
	
	#color register
	movia r18,0xf0f0
	
	stwio r18 , 0(r7)
	#stwio r0, 0(r4)
	
	br wipe_screen_master

	wipe_screen_master:
		#bring offset locations back to zero
		movia r5 ,0b000000000000000000
		movia r6 ,0b000000000000000000
	
		movi r16,0 #ctr for x
		movi r17,0 #ctr for y
		
		movi r21,240 #dimension of box y
		movi r23,320 #dimension of box x
		
		
		
		
		
		wipe_screen_x:		
			#bring back y values to initial values
			movi r17,0
			movia r6 ,0b000000000000000000
			#wipe every y location at the given x location
			br wipe_screen_y
			cont_shit:
			#add one to the x locaiton
			addi r5,r5,0b000000000000000010
			#increment the x location and check if we out of bounds
			addi r16,r16,1
			beq r16,r23,cont
			br wipe_screen_x
		
		#writes the whole column a certain color
		wipe_screen_y:
			#bring base value of vga adapter back
			movia r7,0x08000000
			#compute x-y location
			add r7,r7,r5
			add r7,r7,r6
			#set color to 0?
			movia r18,0xf000
			sthio r18 , 0(r7)
			#move up the y location
			addi r6,r6 ,0b000000010000000000	
			#check conditions 
			addi r17,r17,1
			#if its equal to the max size of the secreen then go back to x clear screen
			#use r10 as speed reg
			movi r10,10
			br slow_down
			backhere:
			beq r17,r21,cont_shit
			br wipe_screen_y
	
		
	slow_down:
	subi r10,r10,1
	beq r10,r0,backhere
	br slow_down
	

	




