##==============================================================================
##
##	crt0.S
##
##	ubi32 startup code
##
##==============================================================================
##
## Copyright (c) 2000, 2001, Red Hat Incorporated
##
## The authors hereby grant permission to use, copy, modify, distribute,
## and license this software and its documentation for any purpose, provided
## that existing copyright notices are retained in all copies and that this
## notice is included verbatim in any distributions. No written agreement,
## license, or royalty fee is required for any of the authorized uses.
## Modifications to this software may be copyrighted by their authors
## and need not follow the licensing terms described here, provided that
## the new terms are clearly indicated on the first page of each file where
## they apply.
##

##------------------------------------------------------------------------------

	.file	"crt0.S"

##------------------------------------------------------------------------------
## Startup code
	#include "regs.h"
	.section ".start","ax"
	.global	_start
	.global prog_start
_start:
	; cause pc to jump to linker's idea of what pc should be
	; This is UBI32 specific code
	moveai  a7, #%hi(prog_start)  // pointer to flash acording to linker
	lea.4 a7,%lo(prog_start)(a7)
	ret  a7
	nop
	nop
prog_start:
	; Initialize memory range registers
	; Setup i_range for executable code
	moveai a6, #%hi(__progmem_start)
	lea.4 d6, %lo(__progmem_start)(a6)
	moveai a7, #%hi(__progmem_length)
	lea.4 d7, %lo(__progmem_length)(a7)
	add.4 d8, d6, d7
	movei d1, #0x3ff
	move.4 i_range0_en, d1
	move.4 i_range0_lo, d6
	move.4 i_range0_hi, d8

	moveai sp,#%hi(_stack-8)
	lea.4 sp,%lo(_stack-8)(sp)

_start0:
	moveai a5,#%hi(_edata)	; get start of bss
	lea.4 a5,%lo(_edata)(a5)

	moveai a6,#%hi(_end)	; get end of bss
	lea.4 d0,%lo(_end)(a6)

	sub.4 #0,a5,d0		; check if end and start are the same
	jmpeq.w.f .L0		; if no bss, then do nothing

.L1:
	move.4 (a5)4++,#0	; clear a byte and bump pointer
	sub.4 #0,a5,d0
	jmpne.w.t .L1

.L0:
	.if 0
	moveai a5,#%hi(__main)
	lea.4 a5,%lo(__main)(a5)
	calli a5,0(a5)	; call __main to run ctors/dtors
	.endif
	xor.4 d1,d1,d1
	xor.4 d2,d2,d2
	movei	d0,#1 		;  argc == 1, the command itself
	moveai a5,#%hi(main)
	lea.4 a5,%lo(main)(a5)
	calli a5,0(a5)
	; 	call a5,_main		; call _main program
	move.4 d1,d0		; exit with main's return value
	moveai a5,#%hi(_exit)
	lea.4 a5,%lo(_exit)(a5)
	calli a5,0(a5)	; all done, no need to return or
				; deallocate our stack.

	.align 2
	.section .stack
_stack:	.long 	1
