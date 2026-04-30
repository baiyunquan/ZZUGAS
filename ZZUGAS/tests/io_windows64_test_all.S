.intel_syntax noprefix

.section .data
msg_write_hdr:    .asciz "=== WRITE TESTS ==="
msg_read_hdr:     .asciz "=== READ TESTS ==="

msg_dispc:        .asciz "dispc="
msg_dispmsg:      .asciz "dispmsg=HelloOut"
msg_dispbb:       .asciz "dispbb="
msg_dispbw:       .asciz "dispbw="
msg_dispbd:       .asciz "dispbd="
msg_disphb:       .asciz "disphb="
msg_disphw:       .asciz "disphw="
msg_disphd:       .asciz "disphd="
msg_disphx:       .asciz "disphx="
msg_dispuib:      .asciz "dispuib="
msg_dispuiw:      .asciz "dispuiw="
msg_dispuid:      .asciz "dispuid="
msg_dispsib:      .asciz "dispsib="
msg_dispsiw:      .asciz "dispsiw="
msg_dispsid:      .asciz "dispsid="
msg_disprb:       .asciz "disprb="
msg_disprw:       .asciz "disprw="
msg_disprd:       .asciz "disprd="
msg_disprf:       .asciz "disprf="

msg_readc:        .asciz "readc="
msg_readmsg:      .asciz "readmsg="
msg_readmsg_len:  .asciz "readmsg_len="
msg_readbb:       .asciz "readbb="
msg_readbw:       .asciz "readbw="
msg_readbd:       .asciz "readbd="
msg_readhb:       .asciz "readhb="
msg_readhw:       .asciz "readhw="
msg_readhd:       .asciz "readhd="
msg_readuib:      .asciz "readuib="
msg_readuiw:      .asciz "readuiw="
msg_readuid:      .asciz "readuid="
msg_readsib:      .asciz "readsib="
msg_readsiw:      .asciz "readsiw="
msg_readsid:      .asciz "readsid="

msg_input_buffer: .space 128

.section .text
.globl main
main:
    lea rax, msg_write_hdr[rip]
    call dispmsg
    call dispcrlf

    lea rax, msg_dispc[rip]
    call dispmsg
    mov al, 'A'
    call dispc
    call dispcrlf

    lea rax, msg_dispmsg[rip]
    call dispmsg
    call dispcrlf

    lea rax, msg_dispbb[rip]
    call dispmsg
    mov al, 0xA5
    call dispbb
    call dispcrlf

    lea rax, msg_dispbw[rip]
    call dispmsg
    mov ax, 0xABCD
    call dispbw
    call dispcrlf

    lea rax, msg_dispbd[rip]
    call dispmsg
    mov eax, 0xABCDEF01
    call dispbd
    call dispcrlf

    lea rax, msg_disphb[rip]
    call dispmsg
    mov al, 0x7F
    call disphb
    call dispcrlf

    lea rax, msg_disphw[rip]
    call dispmsg
    mov ax, 0x7ABC
    call disphw
    call dispcrlf

    lea rax, msg_disphd[rip]
    call dispmsg
    mov eax, 0x89ABCDEF
    call disphd
    call dispcrlf

    lea rax, msg_disphx[rip]
    call dispmsg
    mov rax, 0x0123456789ABCDEF
    call disphx
    call dispcrlf

    lea rax, msg_dispuib[rip]
    call dispmsg
    mov al, 200
    call dispuib
    call dispcrlf

    lea rax, msg_dispuiw[rip]
    call dispmsg
    mov ax, 65535
    call dispuiw
    call dispcrlf

    lea rax, msg_dispuid[rip]
    call dispmsg
    mov eax, 123456789
    call dispuid
    call dispcrlf

    lea rax, msg_dispsib[rip]
    call dispmsg
    mov al, -5
    call dispsib
    call dispcrlf

    lea rax, msg_dispsiw[rip]
    call dispmsg
    mov ax, -12345
    call dispsiw
    call dispcrlf

    lea rax, msg_dispsid[rip]
    call dispmsg
    mov eax, -123456789
    call dispsid
    call dispcrlf

    lea rax, msg_disprb[rip]
    call dispmsg
    mov rax, 0x00000000000000A5
    call disprb
    call dispcrlf

    lea rax, msg_disprw[rip]
    call dispmsg
    mov rax, 0x000000000000ABCD
    call disprw
    call dispcrlf

    lea rax, msg_disprd[rip]
    call dispmsg
    mov rax, 0x00000000ABCDEF01
    call disprd
    call dispcrlf

    lea rax, msg_disprf[rip]
    call dispmsg
    mov rax, 0x0000000000000202
    call disprf
    call dispcrlf

    lea rax, msg_read_hdr[rip]
    call dispmsg
    call dispcrlf

    lea rax, msg_readc[rip]
    call dispmsg
    call readc
    call disphb
    call dispcrlf

    lea rax, msg_readmsg[rip]
    call dispmsg
    lea rax, msg_input_buffer[rip]
    call readmsg
    push rax
    lea rax, msg_input_buffer[rip]
    call dispmsg
    call dispcrlf

    lea rax, msg_readmsg_len[rip]
    call dispmsg
    pop rax
    mov eax, eax
    call dispuid
    call dispcrlf

    lea rax, msg_readbb[rip]
    call dispmsg
    call readbb
    call dispbb
    call dispcrlf

    lea rax, msg_readbw[rip]
    call dispmsg
    call readbw
    call dispbw
    call dispcrlf

    lea rax, msg_readbd[rip]
    call dispmsg
    call readbd
    call dispbd
    call dispcrlf

    lea rax, msg_readhb[rip]
    call dispmsg
    call readhb
    call disphb
    call dispcrlf

    lea rax, msg_readhw[rip]
    call dispmsg
    call readhw
    call disphw
    call dispcrlf

    lea rax, msg_readhd[rip]
    call dispmsg
    call readhd
    call disphd
    call dispcrlf

    lea rax, msg_readuib[rip]
    call dispmsg
    call readuib
    call dispuib
    call dispcrlf

    lea rax, msg_readuiw[rip]
    call dispmsg
    call readuiw
    call dispuiw
    call dispcrlf

    lea rax, msg_readuid[rip]
    call dispmsg
    call readuid
    call dispuid
    call dispcrlf

    lea rax, msg_readsib[rip]
    call dispmsg
    call readsib
    call dispsib
    call dispcrlf

    lea rax, msg_readsiw[rip]
    call dispmsg
    call readsiw
    call dispsiw
    call dispcrlf

    lea rax, msg_readsid[rip]
    call dispmsg
    call readsid
    call dispsid
    call dispcrlf

    xor eax, eax
    ret
