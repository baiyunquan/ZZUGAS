
game:     file format elf64-x86-64


Disassembly of section .init:

0000000000401000 <_init>:
  401000:	f3 0f 1e fa          	endbr64
  401004:	48 83 ec 08          	sub    rsp,0x8
  401008:	48 8b 05 e9 2f 00 00 	mov    rax,QWORD PTR [rip+0x2fe9]        # 403ff8 <__gmon_start__@Base>
  40100f:	48 85 c0             	test   rax,rax
  401012:	74 02                	je     401016 <_init+0x16>
  401014:	ff d0                	call   rax
  401016:	48 83 c4 08          	add    rsp,0x8
  40101a:	c3                   	ret

Disassembly of section .plt:

0000000000401020 <.plt>:
  401020:	ff 35 e2 2f 00 00    	push   QWORD PTR [rip+0x2fe2]        # 404008 <_GLOBAL_OFFSET_TABLE_+0x8>
  401026:	ff 25 e4 2f 00 00    	jmp    QWORD PTR [rip+0x2fe4]        # 404010 <_GLOBAL_OFFSET_TABLE_+0x10>
  40102c:	0f 1f 40 00          	nop    DWORD PTR [rax+0x0]

0000000000401030 <puts@plt>:
  401030:	ff 25 e2 2f 00 00    	jmp    QWORD PTR [rip+0x2fe2]        # 404018 <puts@GLIBC_2.2.5>
  401036:	68 00 00 00 00       	push   0x0
  40103b:	e9 e0 ff ff ff       	jmp    401020 <.plt>

0000000000401040 <printf@plt>:
  401040:	ff 25 da 2f 00 00    	jmp    QWORD PTR [rip+0x2fda]        # 404020 <printf@GLIBC_2.2.5>
  401046:	68 01 00 00 00       	push   0x1
  40104b:	e9 d0 ff ff ff       	jmp    401020 <.plt>

0000000000401050 <srand@plt>:
  401050:	ff 25 d2 2f 00 00    	jmp    QWORD PTR [rip+0x2fd2]        # 404028 <srand@GLIBC_2.2.5>
  401056:	68 02 00 00 00       	push   0x2
  40105b:	e9 c0 ff ff ff       	jmp    401020 <.plt>

0000000000401060 <time@plt>:
  401060:	ff 25 ca 2f 00 00    	jmp    QWORD PTR [rip+0x2fca]        # 404030 <time@GLIBC_2.2.5>
  401066:	68 03 00 00 00       	push   0x3
  40106b:	e9 b0 ff ff ff       	jmp    401020 <.plt>

0000000000401070 <__isoc99_scanf@plt>:
  401070:	ff 25 c2 2f 00 00    	jmp    QWORD PTR [rip+0x2fc2]        # 404038 <__isoc99_scanf@GLIBC_2.7>
  401076:	68 04 00 00 00       	push   0x4
  40107b:	e9 a0 ff ff ff       	jmp    401020 <.plt>

0000000000401080 <rand@plt>:
  401080:	ff 25 ba 2f 00 00    	jmp    QWORD PTR [rip+0x2fba]        # 404040 <rand@GLIBC_2.2.5>
  401086:	68 05 00 00 00       	push   0x5
  40108b:	e9 90 ff ff ff       	jmp    401020 <.plt>

Disassembly of section .text:

0000000000401090 <_start>:
  401090:	f3 0f 1e fa          	endbr64
  401094:	31 ed                	xor    ebp,ebp
  401096:	49 89 d1             	mov    r9,rdx
  401099:	5e                   	pop    rsi
  40109a:	48 89 e2             	mov    rdx,rsp
  40109d:	48 83 e4 f0          	and    rsp,0xfffffffffffffff0
  4010a1:	50                   	push   rax
  4010a2:	54                   	push   rsp
  4010a3:	45 31 c0             	xor    r8d,r8d
  4010a6:	31 c9                	xor    ecx,ecx
  4010a8:	48 c7 c7 72 11 40 00 	mov    rdi,0x401172
  4010af:	ff 15 3b 2f 00 00    	call   QWORD PTR [rip+0x2f3b]        # 403ff0 <__libc_start_main@GLIBC_2.34>
  4010b5:	f4                   	hlt
  4010b6:	66 2e 0f 1f 84 00 00 	cs nop WORD PTR [rax+rax*1+0x0]
  4010bd:	00 00 00 

00000000004010c0 <_dl_relocate_static_pie>:
  4010c0:	f3 0f 1e fa          	endbr64
  4010c4:	c3                   	ret
  4010c5:	66 2e 0f 1f 84 00 00 	cs nop WORD PTR [rax+rax*1+0x0]
  4010cc:	00 00 00 
  4010cf:	90                   	nop

00000000004010d0 <deregister_tm_clones>:
  4010d0:	b8 58 40 40 00       	mov    eax,0x404058
  4010d5:	48 3d 58 40 40 00    	cmp    rax,0x404058
  4010db:	74 13                	je     4010f0 <deregister_tm_clones+0x20>
  4010dd:	b8 00 00 00 00       	mov    eax,0x0
  4010e2:	48 85 c0             	test   rax,rax
  4010e5:	74 09                	je     4010f0 <deregister_tm_clones+0x20>
  4010e7:	bf 58 40 40 00       	mov    edi,0x404058
  4010ec:	ff e0                	jmp    rax
  4010ee:	66 90                	xchg   ax,ax
  4010f0:	c3                   	ret
  4010f1:	66 66 2e 0f 1f 84 00 	data16 cs nop WORD PTR [rax+rax*1+0x0]
  4010f8:	00 00 00 00 
  4010fc:	0f 1f 40 00          	nop    DWORD PTR [rax+0x0]

0000000000401100 <register_tm_clones>:
  401100:	be 58 40 40 00       	mov    esi,0x404058
  401105:	48 81 ee 58 40 40 00 	sub    rsi,0x404058
  40110c:	48 89 f0             	mov    rax,rsi
  40110f:	48 c1 ee 3f          	shr    rsi,0x3f
  401113:	48 c1 f8 03          	sar    rax,0x3
  401117:	48 01 c6             	add    rsi,rax
  40111a:	48 d1 fe             	sar    rsi,1
  40111d:	74 11                	je     401130 <register_tm_clones+0x30>
  40111f:	b8 00 00 00 00       	mov    eax,0x0
  401124:	48 85 c0             	test   rax,rax
  401127:	74 07                	je     401130 <register_tm_clones+0x30>
  401129:	bf 58 40 40 00       	mov    edi,0x404058
  40112e:	ff e0                	jmp    rax
  401130:	c3                   	ret
  401131:	66 66 2e 0f 1f 84 00 	data16 cs nop WORD PTR [rax+rax*1+0x0]
  401138:	00 00 00 00 
  40113c:	0f 1f 40 00          	nop    DWORD PTR [rax+0x0]

0000000000401140 <__do_global_dtors_aux>:
  401140:	80 3d 11 2f 00 00 00 	cmp    BYTE PTR [rip+0x2f11],0x0        # 404058 <__TMC_END__>
  401147:	75 17                	jne    401160 <__do_global_dtors_aux+0x20>
  401149:	55                   	push   rbp
  40114a:	48 89 e5             	mov    rbp,rsp
  40114d:	e8 7e ff ff ff       	call   4010d0 <deregister_tm_clones>
  401152:	c6 05 ff 2e 00 00 01 	mov    BYTE PTR [rip+0x2eff],0x1        # 404058 <__TMC_END__>
  401159:	5d                   	pop    rbp
  40115a:	c3                   	ret
  40115b:	0f 1f 44 00 00       	nop    DWORD PTR [rax+rax*1+0x0]
  401160:	c3                   	ret
  401161:	66 66 2e 0f 1f 84 00 	data16 cs nop WORD PTR [rax+rax*1+0x0]
  401168:	00 00 00 00 
  40116c:	0f 1f 40 00          	nop    DWORD PTR [rax+0x0]

0000000000401170 <frame_dummy>:
  401170:	eb 8e                	jmp    401100 <register_tm_clones>

0000000000401172 <main>:
  401172:	55                   	push   rbp
  401173:	48 89 e5             	mov    rbp,rsp
  401176:	48 83 ec 10          	sub    rsp,0x10
  40117a:	c7 45 fc 0a 00 00 00 	mov    DWORD PTR [rbp-0x4],0xa
  401181:	bf 00 00 00 00       	mov    edi,0x0
  401186:	e8 d5 fe ff ff       	call   401060 <time@plt>
  40118b:	89 c7                	mov    edi,eax
  40118d:	e8 be fe ff ff       	call   401050 <srand@plt>
  401192:	e8 e9 fe ff ff       	call   401080 <rand@plt>
  401197:	48 63 d0             	movsxd rdx,eax
  40119a:	48 69 d2 cb f0 8d 28 	imul   rdx,rdx,0x288df0cb
  4011a1:	48 c1 ea 20          	shr    rdx,0x20
  4011a5:	c1 fa 04             	sar    edx,0x4
  4011a8:	89 c1                	mov    ecx,eax
  4011aa:	c1 f9 1f             	sar    ecx,0x1f
  4011ad:	29 ca                	sub    edx,ecx
  4011af:	89 55 f8             	mov    DWORD PTR [rbp-0x8],edx
  4011b2:	8b 55 f8             	mov    edx,DWORD PTR [rbp-0x8]
  4011b5:	6b d2 65             	imul   edx,edx,0x65
  4011b8:	29 d0                	sub    eax,edx
  4011ba:	89 45 f8             	mov    DWORD PTR [rbp-0x8],eax
  4011bd:	eb 60                	jmp    40121f <main+0xad>
  4011bf:	48 8d 45 f4          	lea    rax,[rbp-0xc]
  4011c3:	48 89 c6             	mov    rsi,rax
  4011c6:	bf 08 20 40 00       	mov    edi,0x402008
  4011cb:	b8 00 00 00 00       	mov    eax,0x0
  4011d0:	e8 9b fe ff ff       	call   401070 <__isoc99_scanf@plt>
  4011d5:	8b 45 f4             	mov    eax,DWORD PTR [rbp-0xc]
  4011d8:	39 45 f8             	cmp    DWORD PTR [rbp-0x8],eax
  4011db:	75 20                	jne    4011fd <main+0x8b>
  4011dd:	b8 0b 00 00 00       	mov    eax,0xb
  4011e2:	2b 45 fc             	sub    eax,DWORD PTR [rbp-0x4]
  4011e5:	89 c6                	mov    esi,eax
  4011e7:	bf 10 20 40 00       	mov    edi,0x402010
  4011ec:	b8 00 00 00 00       	mov    eax,0x0
  4011f1:	e8 4a fe ff ff       	call   401040 <printf@plt>
  4011f6:	b8 00 00 00 00       	mov    eax,0x0
  4011fb:	eb 3c                	jmp    401239 <main+0xc7>
  4011fd:	83 6d fc 01          	sub    DWORD PTR [rbp-0x4],0x1
  401201:	8b 45 f4             	mov    eax,DWORD PTR [rbp-0xc]
  401204:	39 45 f8             	cmp    DWORD PTR [rbp-0x8],eax
  401207:	7d 0c                	jge    401215 <main+0xa3>
  401209:	bf 39 20 40 00       	mov    edi,0x402039
  40120e:	e8 1d fe ff ff       	call   401030 <puts@plt>
  401213:	eb 0a                	jmp    40121f <main+0xad>
  401215:	bf 43 20 40 00       	mov    edi,0x402043
  40121a:	e8 11 fe ff ff       	call   401030 <puts@plt>
  40121f:	83 7d fc 00          	cmp    DWORD PTR [rbp-0x4],0x0
  401223:	75 9a                	jne    4011bf <main+0x4d>
  401225:	bf 50 20 40 00       	mov    edi,0x402050
  40122a:	b8 00 00 00 00       	mov    eax,0x0
  40122f:	e8 0c fe ff ff       	call   401040 <printf@plt>
  401234:	b8 00 00 00 00       	mov    eax,0x0
  401239:	c9                   	leave
  40123a:	c3                   	ret

Disassembly of section .fini:

000000000040123c <_fini>:
  40123c:	f3 0f 1e fa          	endbr64
  401240:	48 83 ec 08          	sub    rsp,0x8
  401244:	48 83 c4 08          	add    rsp,0x8
  401248:	c3                   	ret
