[list -]  ; Do not list following content

;filename: io_linux.inc
;A NASM include file used with io_linux.a for Windows Console

%macro exit 0
	mov eax,1   
	int 0x80        
%endmacro
;declare procedures for inputting and outputting charactor or string
	extern readc,readmsg
	extern dispc,dispmsg,dispcrlf
;declare procedures for inputting and outputting binary number
	extern readbb,readbw,readbd
	extern dispbb,dispbw,dispbd
;declare procedures for inputting and outputting hexadecimal number
	extern readhb,readhw,readhd
	extern disphb,disphw,disphd
;declare procedures for inputting and outputting unsigned integer number
	extern readuib,readuiw,readuid
	extern dispuib,dispuiw,dispuid
;declare procedures for inputting and outputting signed integer number
	extern readsib,readsiw,readsid
	extern dispsib,dispsiw,dispsid
;declare procedures for outputting registers
	extern disprb,disprw,disprd,disprf


[list +]
