	.text
	.global	__int_sys
__int_sys:
	move.4	d4,d3
	move.4	d3,d2
	move.4	d2,d1
	move.4	d1,d0
; SYSCALL for semihosting
	syscall a5	; syscall number in d1, args in d2-d4, return in d0
	cmpi d0,#0
	jmpeq.w.t .L0
	move.4 d3,a0
	moveai a0,#%hi(errno)
	lea.4 a0,%lo(errno)(a0)
	move.4 (a0),d5
	move.4 a0,d3
.L0:
	ret a5
