.text
.global make_node
.global insert
.global get
.global getAtMost

make_node:
    #prologoue
    addi sp,sp,-16
    sd ra,8(sp)
    sd s0,0(sp)

    mv s0,a0

    li a0,24
    call malloc

    sw s0,0(a0)
    sd zero , 8(a0)
    sd zero, 16(a0)

    ld ra,8(sp)
    ld s0,0(sp)
    addi sp,sp,16
    
    ret


insert:
    #prologue
    addi sp, sp, -32
    sd ra, 24(sp)
    sd s0, 16(sp)      
    sd s1, 8(sp)      
    sd s2, 0(sp)       

    mv s0,a0            #root
    mv s1,a0            #curr(root)
    mv s2,a1            #val

    bne s0,zero,search_loop
    mv a0,s2
    call make_node
    mv s0,a0
    j end_insert

search_loop:
    lw t0, 0(s1)

    blt s2,t0,go_left
    #otherwise here will go to right

go_right:
    ld t0,16(s1)
    beq t0,zero,insert_right

    mv s1,t0
    j search_loop

insert_right:
    mv a0,s2
    call make_node

    sd a0,16(s1)
    
    j end_insert

go_left:
    ld t0,8(s1)
    beq t0,zero,insert_left

    mv s1,t0
    j search_loop

insert_left:
    mv a0,s2
    call make_node

    sd a0,8(s1)

    j end_insert

end_insert:
    #epilogue
    mv a0, s0          
    ld ra, 24(sp)
    ld s0, 16(sp)
    ld s1, 8(sp)
    ld s2, 0(sp)
    addi sp, sp, 32
    ret



get:
    
get_loop:
    beq a0,zero,end_get
    lw t0,0(a0)

    beq a1,t0,end_get
    blt a1,t0,go_left_get

go_right_get:
    ld a0,16(a0)
    j get_loop

go_left_get:
    ld a0,8(a0)
    j get_loop
    

end_get:
    ret


getAtMost:
    li t0,-1

getAtMost_loop:
    beq a1,zero,end_getAtMost
    lw t1,0(a1)

    beq t1,a0,same_match
    bgt t1,a0,go_left_getAtMost

get_right_AtMost:

    mv t0,t1
    ld a1,16(a1)
    j getAtMost_loop

go_left_getAtMost:
    ld a1,8(a1)
    j getAtMost_loop

same_match:
    mv t0,t1

end_getAtMost:
    mv a0,t0
    ret

    
