
.intel_syntax noprefix
.text

// guest_code: just executes vmcall
.global guest_code
.type guest_code, @function
guest_code:
    endbr64
    vmcall
    ret
.size guest_code, .-guest_code

// get_es1: returns ES segment selector (16-bit)
.global get_es1
.type get_es1, @function
get_es1:
    endbr64
    mov ax, es
    ret
.size get_es1, .-get_es1

// get_cs1: returns CS segment selector (16-bit)
.global get_cs1
.type get_cs1, @function
get_cs1:
    endbr64
    mov ax, cs
    ret
.size get_cs1, .-get_cs1

// get_ss1: returns SS segment selector (16-bit)
.global get_ss1
.type get_ss1, @function
get_ss1:
    endbr64
    mov ax, ss
    ret
.size get_ss1, .-get_ss1

// get_ds1: returns DS segment selector (16-bit)
.global get_ds1
.type get_ds1, @function
get_ds1:
    endbr64
    mov ax, ds
    ret
.size get_ds1, .-get_ds1

// get_fs1: returns FS segment selector (16-bit)
.global get_fs1
.type get_fs1, @function
get_fs1:
    endbr64
    mov ax, fs
    ret
.size get_fs1, .-get_fs1

// get_gs1: returns GS segment selector (16-bit)
.global get_gs1
.type get_gs1, @function
get_gs1:
    endbr64
    mov ax, gs
    ret
.size get_gs1, .-get_gs1

// get_tr1: returns TR (task register) selector (16-bit)
.global get_tr1
.type get_tr1, @function
get_tr1:
    endbr64
    str ax          // store task register selector to ax
    ret
.size get_tr1, .-get_tr1


// get_gdt_base1: returns GDT base address (64-bit)
.global get_gdt_base1
.type get_gdt_base1, @function
get_gdt_base1:
    endbr64
    lea rdi, [rsp - 10]  // allocate space on stack for desc_ptr (size 10 bytes)
    sgdt [rdi]           // store GDT descriptor to memory
    mov rax, [rdi + 2]   // gdt.address is 8 bytes after 2-byte limit field
    ret
.size get_gdt_base1, .-get_gdt_base1

// get_idt_base1: returns IDT base address (64-bit)
.global get_idt_base1
.type get_idt_base1, @function
get_idt_base1:
    endbr64
    lea rdi, [rsp - 10]  // allocate space for desc_ptr on stack
    sidt [rdi]           // store IDT descriptor
    mov rax, [rdi + 2]   // base address offset
    ret
.size get_idt_base1, .-get_idt_base1
