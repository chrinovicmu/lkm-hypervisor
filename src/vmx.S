
.intel_syntax noprefix
.text

.global _read_cr0
.type _read_cr0, @function
_read_cr0:
    endbr64
    mov rax, cr0
    ret
    .byte 0xCC
.size _read_cr0, .-_read_cr0

.global _read_cr2
.type _read_cr2, @function
_read_cr2:
    endbr64
    mov rax, cr2
    ret
    .byte 0xCC
.size _read_cr2, .-_read_cr2

.global _read_cr3
.type _read_cr3, @function
_read_cr3:
    endbr64
    mov rax, cr3
    ret
    .byte 0xCC
.size _read_cr3, .-_read_cr3

.global _read_cr4
.type _read_cr4, @function
_read_cr4:
    endbr64
    mov rax, cr4
    ret
    .byte 0xCC
.size _read_cr4, .-_read_cr4

.global _vmcs_revision_id
.type _vmcs_revision_id, @function
_vmcs_revision_id:
    endbr64
    mov ecx, 0x480     // MSR_IA32_VMX_BASIC
    rdmsr              // EAX = low 32 bits
    ret
    .byte 0xCC
.size _vmcs_revision_id, .-_vmcs_revision_id

.global _vmxon
.type _vmxon, @function
_vmxon:
    endbr64
    vmxon [rdi]
    setna al
    ret
    .byte 0xCC
.size _vmxon, .-_vmxon

.global _vmptrld
.type _vmptrld, @function
_vmptrld:
    endbr64
    vmptrld [rdi]
    setna al
    movzx eax, al
    ret
    .byte 0xCC
.size _vmptrld, .-_vmptrld

.global _vmread
.type _vmread, @function
_vmread:
    endbr64
    vmread rdi, rax
    setna cl
    mov [rsi], rax
    movzx eax, cl
    ret
    .byte 0xCC
.size _vmread, .-_vmread

.global _vmwrite
.type _vmwrite, @function
_vmwrite:
    endbr64
    vmwrite rsi, rdi
    setna al
    test al, al
    jz .vmwrite_ok
    mov eax, -1
    ret
    .byte 0xCC

.vmwrite_ok:
    xor eax, eax
    ret
    .byte 0xCC
.size _vmwrite, .-_vmwrite

.global _vmlaunch
.type _vmlaunch, @function
_vmlaunch:
    endbr64
    xor eax, eax
    ret
    .byte 0xCC
.size _vmlaunch, .-_vmlaunch
