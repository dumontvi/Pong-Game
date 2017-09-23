.equ HEX0_3, 0xFF200020 #Adress of HEX 0-3	 	
.equ HEX4_5,0xFF200030	#Adress of HEX 4-5	
.equ LEDR, 0xFF200000   #Adress of RED LEDs	 	
.equ JP1, 0xFF200060    #Adress of GPIO_1
.equ JP1_IRQ,0x0800     #Adress of JP1-IRQ
.equ JP1_EDGE,0xFF20006C#Adress of JP1_EDGE


#Register use:

#r3 - Adress of JP1/JP1-IRQ
#r4 - Adress of HEXs




/*////////////////////////////////////////////////////MAIN/////////////////////////////////////////////////////////////////////*/


.section .text
.global _start

_start:

movia r3,JP1

movia  r2, 0x07f557ff  #sets direction for motors and sensors of JP1
stwio  r2,4(r3)        #store the value into JP1

movia r2, 0xffffffff   #initialize all motors and sensors to 0
stwio r2, 0(r3)        #store into JP1 

#INITIALIZE SENSOR 1
movia r2, 0xfabffbff   #enable sensor 1 and set threshold value
stwio r2, 0(r3)        #store into JP1

#INITIALIZE SENSOR 2
movia r2, 0xfabfefff   #enable sensor 2 and set threshold value
stwio r2, 0(r3)        #store into JP1

#ENABLE STATE MODE
movia r2, 0xffdfffff   #enable state mode
stwio r2, 0(r3)        #store into JP1

#ENABLE INTTERUPTS
movia r2, 0xf8000000   #enable interrupts on all sensors
stwio r2, 8(r3)        #store into JP1

 movia  r3,JP1-IRQ  #enable interrupt for JP1(set bit 11)
 wrctl	ctl3,r3			

 movia 	r3,1             #enable global interrupts
 wrctl 	ctl0,r3			       
 
 
 LOOP:
 
 movia r4, HEX0_3      #move address of HEX 0-3 into r4
 movia r2, 0xf938383f  #set letters 'E','L','L','0'
 stwio r2,0(r4)        #store into HEX0_3
 
 movia r4, HEX4_5      #move address of HEX 4-5 into r4
 movia r2, 0x00000076  # set letter 'H'
 stwio r2, 0(r4)       #store into HEX4_5
 
 movia r2, JP1         #move address of JP1 into r3
 movia r3, 0xffdfffff  #enable state bit and keep motors off when no interrupt
 stwio r3,0(r2)        #store into JP1
 
 br LOOP
 
 /*//////////////////////////////////////////INTERRUPTS//////////////////////////////////////////////////////////*/
 
 .section .exceptions, "ax"
 IHANDLER:
 
 subi sp,sp,8
 stw r3,0(sp)
 stw r4,4(sp)
 
 #CHECK IF INTTERUPT TRIGGERED
  rdctl et, ctl4                    # check the interrupt pending register (ctl4)
  beq et,r0,exit_handler
  
  movia r3, JP1-IRQ   
  and	r3, r3, et                  # check if the pending interrupt is from GPIO JP1 
  beq   r3, r0, exit_handler    

  movia r7,JP1_EDGE                 # disable edge capture 
  stwio r0,0(r7)  
  
  
 movia  r3,JP1            			#store JP1 into JP1
 movia  r4,HEX0_3                   #move address of HEX0_3 to r4

 ldwio	r5,0(r3)                    #Check the states of all the sensors
 srli   r5,r5,27
 andi	r6,r5,0x003
 cmpeqi r6,r5,0x003

 bne	r6,r0,exit_handler	       #no interrupt triggered
	
	
 cmpeqi	r6,r5,0x001                #Sensor 1 check
 bne	r6,r0,VGA_left
	
 cmpeqi	r6,r5,0x002                #Sensor 2 Check
 bne	r6,r0,VGA_right

br exit_handler
 
 #SENSOR 1 TRIGGERED
 VGA_left:
 movia r7, 0x38066d06 
 stwio r7, 0(r4)
 movia r7, 0xffdffffc
 stwio r7, 0(r3)
 br ISR_checker
 
#SENSOR 2 TRIGGERED 
VGA_right:
 movia r7, 0xf7066d5b 
 stwio r7, 0(r4)
 movia r7, 0xffdffffb
 stwio r7, 0(r3)
 br ISR_checker
 
#CHECK OTHER STATE VALUES 
 ISR_checker:
  ldwio r7,0(r3)
  srli r7,r7,27
  andi r6,r7,0x003
  cmpeqi r7,r7,0x003
  bne r6,r0,exit_handler
 
#EXIT INTTERUPT 
exit_handler:
ldw r3,0(sp)
ldw r4,4(sp)
addi sp,sp,8
subi ea,ea,4
eret
eret
 
  
 
 
 
 
 