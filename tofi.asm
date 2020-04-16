.data 
s:.asciiz "mashtarashtasht\n"
target:.asciiz "sht\n"
size:.word 15
sizee:.word 2
xx:.word 250





.text 
la $s3,s #address of real string;
la $s4,target #address of substring;
la $t6,size  #address of size of string
la $t4,sizee #address of size of substring
lw $s5,0($t6)# size of string in s5;
lw $s6,0($t4)#size of substring in s6;
addi $s1,$zero,0 #counter i=0;
addi $s2,$zero,0 #counter j=0;
addi $t7,$zero,-1 #index of first char of substring;
lb $t1,0($s4) #target[0]
add $t5,$zero,$s3
la $t8,xx

outerloop:
#first loop for getting first char of subtring with big string
#....................................................................................................#
 
fristinnerloop:
  
  lb  $t2,0($s3) #src[i] string
  blt $s1,$s5,x #check src[i]!=target[0]
  j firstcond
  x:bne $t2,$t1,oo #first condition  search about char at substring at string;
  j firstcond
  oo:addi $s1,$s1,1
  addi $s3,$s3,1
  j fristinnerloop
#....................................................................................................#


firstcond:
  beq  $s1,$s5,exit #if(src[i]==end of string)
  add $t7,$zero,$s1
  addi $t9,$zero,0
  

#second loop for check if substring in string or not
#....................................................................................................#
  la $s4,target #address of substring;
  la $s3,s #address of real string;
  add $s3,$s3,$s1
 secondinnerloop:

    lb $t2,0($s3) #src[i]
    lb $t3,0($s4) #targ[j]
    beq $t2,$t3,m #src[i]==str[j]
    j f
    m:blt $s1,$s5,n
    j  secondcond
    n:blt $s2,$s6,p
    j  secondcond
    p:addi $s1,$s1,1 #i++
      addi $s2,$s2,1  #j++
      addi $s3,$s3,1 #update adress of string
      addi $s4,$s4,1  #update adress of substring
      j secondinnerloop
 #....................................................................................................#     
     
       f:
       addi $s1,$t7,1 #i=t7+1
       addi $t7,$zero,-1
       addi $t9,$zero,-1
        secondcond:
                  beq $t9,0,ppp
               mb:bge $s1,$s5,z
                  j ff
                  z:
                   j exit
                 
      
     ff: 
      addi $s2,$zero,0 #j=0
      la $s3,s #address of real string;
      add $s3,$s3,$s1
      blt $s1,$s5,outerloop
      exit:j exit2
      ppp:
      sw $t7,0($t8)
      addi $t8,$t8,4
      j mb
      
      exit2:
