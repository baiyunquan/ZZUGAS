.intel_syntax noprefix

.text

.extern dispmsg_impl
.extern dispcrlf_impl
.extern dispc_impl
.extern dispbb_impl
.extern dispbw_impl
.extern dispbd_impl
.extern disphb_impl
.extern disphw_impl
.extern disphd_impl
.extern disphx_impl
.extern dispuib_impl
.extern dispuiw_impl
.extern dispuid_impl
.extern dispsib_impl
.extern dispsiw_impl
.extern dispsid_impl
.extern disprb_impl
.extern disprw_impl
.extern disprd_impl
.extern disprf_impl
.extern readc_impl
.extern readmsg_impl
.extern readbb_impl
.extern readbw_impl
.extern readbd_impl
.extern readhb_impl
.extern readhw_impl
.extern readhd_impl
.extern readuib_impl
.extern readuiw_impl
.extern readuid_impl
.extern readsib_impl
.extern readsiw_impl
.extern readsid_impl

.macro WRAP0 public_name, impl_name
	.globl \public_name
\public_name:
	sub rsp, 40
	call \impl_name
	add rsp, 40
	ret
.endm

.macro WRAP_RAX public_name, impl_name
	.globl \public_name
\public_name:
	sub rsp, 40
	mov rcx, rax
	call \impl_name
	add rsp, 40
	ret
.endm

.macro WRAP_AL public_name, impl_name
	.globl \public_name
\public_name:
	sub rsp, 40
	movzx ecx, al
	call \impl_name
	add rsp, 40
	ret
.endm

.macro WRAP_AX public_name, impl_name
	.globl \public_name
\public_name:
	sub rsp, 40
	movzx ecx, ax
	call \impl_name
	add rsp, 40
	ret
.endm

.macro WRAP_EAX public_name, impl_name
	.globl \public_name
\public_name:
	sub rsp, 40
	mov ecx, eax
	call \impl_name
	add rsp, 40
	ret
.endm

.macro WRAP_SAL public_name, impl_name
	.globl \public_name
\public_name:
	sub rsp, 40
	movsx rcx, al
	call \impl_name
	add rsp, 40
	ret
.endm

.macro WRAP_SAX public_name, impl_name
	.globl \public_name
\public_name:
	sub rsp, 40
	movsx rcx, ax
	call \impl_name
	add rsp, 40
	ret
.endm

.macro WRAP_SEAX public_name, impl_name
	.globl \public_name
\public_name:
	sub rsp, 40
	movsxd rcx, eax
	call \impl_name
	add rsp, 40
	ret
.endm

WRAP_RAX dispmsg, dispmsg_impl
WRAP0 dispcrlf, dispcrlf_impl
WRAP_AL dispc, dispc_impl
WRAP_AL dispbb, dispbb_impl
WRAP_AX dispbw, dispbw_impl
WRAP_EAX dispbd, dispbd_impl
WRAP_AL disphb, disphb_impl
WRAP_AX disphw, disphw_impl
WRAP_EAX disphd, disphd_impl
WRAP_RAX disphx, disphx_impl
WRAP_AL dispuib, dispuib_impl
WRAP_AX dispuiw, dispuiw_impl
WRAP_EAX dispuid, dispuid_impl
WRAP_SAL dispsib, dispsib_impl
WRAP_SAX dispsiw, dispsiw_impl
WRAP_SEAX dispsid, dispsid_impl
WRAP_RAX disprb, disprb_impl
WRAP_RAX disprw, disprw_impl
WRAP_RAX disprd, disprd_impl
WRAP_RAX disprf, disprf_impl
WRAP0 readc, readc_impl
WRAP_RAX readmsg, readmsg_impl
WRAP0 readbb, readbb_impl
WRAP0 readbw, readbw_impl
WRAP0 readbd, readbd_impl
WRAP0 readhb, readhb_impl
WRAP0 readhw, readhw_impl
WRAP0 readhd, readhd_impl
WRAP0 readuib, readuib_impl
WRAP0 readuiw, readuiw_impl
WRAP0 readuid, readuid_impl
WRAP0 readsib, readsib_impl
WRAP0 readsiw, readsiw_impl
WRAP0 readsid, readsid_impl
