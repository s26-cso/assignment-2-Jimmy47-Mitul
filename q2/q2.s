.data
fmt_space: .string "%d "  

.text
.global atoi
.global main

main:
    # PROLOGUE
    addi sp, sp, -80
    sd ra, 72(sp)
    sd s1, 64(sp)
    sd s2, 56(sp)
    sd s3, 48(sp)
    sd s4, 40(sp)
    sd s5, 32(sp)
    sd s6, 24(sp)
    sd s7, 16(sp)
    sd s8, 8(sp)
  

    #here tot elem is argc - 1
    addi s3, a0, -1
    mv s2, a1

    #allocating memory for arrays(total 3 arrays)
    li t0, 12
    mul a0, s3, t0
    
    call malloc

    mv s4, a0

    slli t1, s3, 2  #offset for next array (Integers are still 4 bytes)
    add s5, s4, t1  #arr2 base array
    add s6, s5, t1
    
    #initialize ans arr with -1
    li t0, 0
    li t1, -1

loop_init:
    bge t0, s3, parse_args
    slli t2, t0, 2
    add t2, s5, t2        
    sw t1, 0(t2)
    addi t0, t0, 1        
    j loop_init          

parse_args:
    li s1, 0                # s1 = Outer loop counter (i = 0)

parse_outer_loop:
    bge s1, s3, run_algorithm # (If i >= n, we are done parsing)

    addi t1, s1, 1         
    slli t1, t1, 3          
    add t1, s2, t1          

    #logic for atoi 
    ld a0, 0(t1)
    call atoi
    mv t2, a0              
    
store_parsed:
    
    slli t4, s1, 2         
    add t4, s4, t4          # t4 = base address of arr (s4) + offset
    sw t2, 0(t4)            

    addi s1, s1, 1          
    j parse_outer_loop      

run_algorithm:
    mv s7, s6               # s7 = Top of Stack
    addi s8, s3, -1         # s8 = loop counter 'i'

nge_loop:
    bltz s8, print_output   # If i < 0, main loop is done

while_loop:
    beq s7, s6, end_while   

    # Get index at top of stack (top_idx)
    addi t0, s7, -4         # Address of top element
    lw t1, 0(t0)            # t1 = top_idx

    # Get arr[top_idx]
    slli t2, t1, 2          # t2 = top_idx*4
    add t2, s4, t2          # t2 = address of arr[top_idx]
    lw t3, 0(t2)            # t3 = arr[top_idx]

    # Get arr[i]
    slli t4, s8, 2          # t4 = i * 4
    add t4, s4, t4          # t4 = address of arr[i]
    lw t5, 0(t4)            # t5 = arr[i]

    # Compareing logic here 
    bgt t3, t5, end_while   

    # Pop stack 
    addi s7, s7, -4        
    j while_loop            

end_while:
    beq s7, s6, push_i      

    # Recording result
    addi t0, s7, -4         # Address of top element
    lw t1, 0(t0)            # t1 = top_idx
    
    slli t4, s8, 2         
    add t4, s5, t4         
    sw t1, 0(t4)           

push_i:
    # push current index 'i' onto stack
    sw s8, 0(s7)            
    addi s7, s7, 4          

    addi s8, s8, -1         
    j nge_loop              

print_output:
    li s8, 0                

print_loop:
    bge s8, s3, exit        # If i >= n, exit program

    # Load result[i] into a1
    slli t0, s8, 2          
    add t0, s5, t0          
    lw a1, 0(t0)            

    # Load format string into a0 
    la a0, fmt_space
    
    call printf

    addi s8, s8, 1          
    j print_loop

exit:
    # EPILOGUE
    ld ra, 72(sp)
    ld s1, 64(sp)
    ld s2, 56(sp)
    ld s3, 48(sp)
    ld s4, 40(sp)
    ld s5, 32(sp)
    ld s6, 24(sp)
    ld s7, 16(sp)
    ld s8, 8(sp)
    addi sp, sp, 80
   
               
    ret

    