.equ ADDR_VGA, 0x08000000
.equ ADDR_CHAR, 0x09000000

.section .text

.global _start

_start:

  movia r2,ADDR_VGA
  movia r3, ADDR_CHAR
  
  
  loop:
  #movui r4,0xffff  /* White pixel */
  #movi  r5, 0x41   /* ASCII for 'A' */
  #sthio r4,20500(r2) /* pixel (4,1) is x*2 + y*1024 so (8 + 1024 = 1032) */
  #stbio r5,288(r3) /* character (4,1) is x + y*128 so (4 + 128 = 132) */
  movi r5,0x50
  stbio r5,288(r3) # ASCII for P into VGA
  movi r5,0x4F
  stbio r5,289(r3)#O
  movi r5,0x4E
  stbio r5,290(r3)#N
  movi r5,0x47
  stbio r5,291(r3)#G

  stbio r5,294(r3)
  movi r5,0x41
  stbio r5,295(r3) # ASCII for P into VGA
  movi r5,0x4D
  stbio r5,296(r3)#O
  movi r5,0x45
  stbio r5,297(r3)#N
   
   
  
  
  
  br loop