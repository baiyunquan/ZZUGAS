[list -]   ; Do not list following content
;filename: io16.inc
;A include file used with io16.lib for DOS
%macro exit 1
	mov ax,4c00h+%1
	int 21h        
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

;declare I/O libraries
	; includelib io16.lib


[list +]