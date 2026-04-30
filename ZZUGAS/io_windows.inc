[list -]
;filename: io_windows.inc
;A NASM include file used with io_windows64.a for Windows Console (MSYS2 GCC)

%macro exit 0
	xor ecx, ecx
	call ExitProcess
%endmacro

;declare procedures for inputting and outputting character or string
	extern readc, readmsg
	extern dispc, dispmsg, dispcrlf
;declare procedures for inputting and outputting binary number
	extern readbb, readbw, readbd
	extern dispbb, dispbw, dispbd
;declare procedures for inputting and outputting hexadecimal number
	extern readhb, readhw, readhd
	extern disphb, disphw, disphd, disphx
;declare procedures for inputting and outputting unsigned integer number
	extern readuib, readuiw, readuid
	extern dispuib, dispuiw, dispuid
;declare procedures for inputting and outputting signed integer number
	extern readsib, readsiw, readsid
	extern dispsib, dispsiw, dispsid
;declare procedures for outputting registers
	extern disprb, disprw, disprd, disprf
	extern ExitProcess

[list +]
