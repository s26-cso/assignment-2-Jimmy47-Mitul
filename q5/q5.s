.data
filename: .string "input.txt"
mode:     .string "r"           
success_msg:  .string "Yes\n"
failure_msg:   .string "No\n"

.bss 
buf1: .space 1
buf2: .space 1

.text
.global main

main:
    #prologue
    addi sp,sp,-32

    sd ra,24(sp)
    sd s0,16(sp)
    sd s1,8(sp)
    sd s2,0(sp)

    #opening the file
    la a0,filename
    la a1,mode
    call fopen
    mv s0,a0

    mv a0,s0
    li a1,0
    li a2,2
    call fseek

    mv a0,s0
    call ftell         

    li s1,0
    addi s2,a0,-1

    
    loop:
        bge s1,s2, is_palindrome #exit condition

        
        mv a0,s0
        mv a1 ,s1
        li a2,0
        call fseek

        la a0,buf1
        li a1,1
        li a2,1
        mv a3,s0
        call fread

        mv a0,s0
        mv a1,s2
        li a2,0
        call fseek

        la a0,buf2
        li a1,1
        li a2,1
        mv a3,s0
        call fread
        
        #comparing the characters

        la t0,buf1
        lb t0,0(t0)

        la t1,buf2
        lb t1,0(t1)

        bne t0,t1,not_palindrome

        #advancing pointers
        addi s1,s1,1
        addi s2,s2,-1
        j loop


    is_palindrome:
        la a0,success_msg
        call printf
        j end_program

    not_palindrome:
        la a0, failure_msg
        call printf
        j end_program


    end_program:

    #epilogue
    ld s2,0(sp)
    ld s1,8(sp)
    ld s0,16(sp)
    ld ra,24(sp)

    addi sp,sp,32

    ret



