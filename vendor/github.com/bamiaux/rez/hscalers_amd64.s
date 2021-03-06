// Copyright 2014 Benoît Amiaux. All rights reserved.
// Use of this source code is governed by a MIT-style
// license that can be found in the LICENSE file.

// This file is auto-generated - do not modify

DATA	zero_0<>+0x00(SB)/8, $0x0000000000000000
DATA	zero_0<>+0x08(SB)/8, $0x0000000000000000
GLOBL	zero_0<>(SB), 8, $16
DATA	hbits_1<>+0x00(SB)/8, $0x0000200000002000
DATA	hbits_1<>+0x08(SB)/8, $0x0000200000002000
GLOBL	hbits_1<>(SB), 8, $16
DATA	u8max_2<>+0x00(SB)/8, $0x00000000000000FF
DATA	u8max_2<>+0x08(SB)/8, $0x00000000000000FF
GLOBL	u8max_2<>(SB), 8, $16

TEXT ·h8scale2Amd64(SB),4,$40-136
		MOVQ	dp+120(FP), BX
		MOVQ	width+104(FP), CX
		MOVQ	CX, DX
		SUBQ	CX, BX
		SHRQ	$4, CX
		ANDQ	$15, DX
		MOVQ	BX, dstoff+-32(SP)
		MOVQ	CX, simdroll+-8(SP)
		MOVQ	DX, asmroll+-16(SP)
		MOVQ	src+24(FP), AX
		MOVQ	AX, srcref+-24(SP)
		MOVQ	taps+96(FP), DX
		SUBQ	$2, DX
		PXOR	X15, X15
		MOVO	hbits_1<>(SB), X14
		MOVQ	src+24(FP), SI
		MOVQ	dst+0(FP), DI
yloop_0:
		MOVQ	off+72(FP), BX
		MOVQ	cof+48(FP), BP
		MOVQ	simdroll+-8(SP), CX
		ORQ	CX, CX
		JE	nosimdloop_3
simdloop_1:
		MOVWQSX	(BX), R8
		MOVWQSX	2(BX), R9
		MOVWQSX	4(BX), R10
		MOVWQSX	6(BX), R11
		PINSRW	$0, (SI)(R8*1), X0
		PINSRW	$1, (SI)(R9*1), X0
		PINSRW	$2, (SI)(R10*1), X0
		PINSRW	$3, (SI)(R11*1), X0
		MOVWQSX	8(BX), R8
		MOVWQSX	10(BX), R9
		MOVWQSX	12(BX), R10
		MOVWQSX	14(BX), R11
		PINSRW	$0, (SI)(R8*1), X1
		PINSRW	$1, (SI)(R9*1), X1
		PINSRW	$2, (SI)(R10*1), X1
		PINSRW	$3, (SI)(R11*1), X1
		MOVWQSX	16(BX), R8
		MOVWQSX	18(BX), R9
		MOVWQSX	20(BX), R10
		MOVWQSX	22(BX), R11
		PINSRW	$0, (SI)(R8*1), X2
		PINSRW	$1, (SI)(R9*1), X2
		PINSRW	$2, (SI)(R10*1), X2
		PINSRW	$3, (SI)(R11*1), X2
		MOVWQSX	24(BX), R8
		MOVWQSX	26(BX), R9
		MOVWQSX	28(BX), R10
		MOVWQSX	30(BX), R11
		PINSRW	$0, (SI)(R8*1), X3
		PINSRW	$1, (SI)(R9*1), X3
		PINSRW	$2, (SI)(R10*1), X3
		PINSRW	$3, (SI)(R11*1), X3
		ADDQ	$32, BX
		PUNPCKLBW	X15, X0
		PMADDWL	(BP), X0
		PUNPCKLBW	X15, X1
		PMADDWL	16(BP), X1
		PUNPCKLBW	X15, X2
		PMADDWL	32(BP), X2
		PUNPCKLBW	X15, X3
		PMADDWL	48(BP), X3
		ADDQ	$64, BP
		PADDL	X14, X0
		PADDL	X14, X1
		PADDL	X14, X2
		PADDL	X14, X3
		PSRAL	$14, X0
		PSRAL	$14, X1
		PSRAL	$14, X2
		PSRAL	$14, X3
		PACKSSLW	X1, X0
		PACKSSLW	X3, X2
		PACKUSWB	X2, X0
		MOVOU	X0, (DI)
		ADDQ	$16, DI
		SUBQ	$1, CX
		JNE	simdloop_1
nosimdloop_3:
		MOVQ	asmroll+-16(SP), CX
		ORQ	CX, CX
		JE	end_4
asmloop_2:
		MOVWQSX	(BX), DX
		MOVBQZX	(SI)(DX*1), AX
		MOVWQSX	(BP), DX
		IMULQ	DX
		MOVQ	AX, sum+-40(SP)
		MOVWQSX	(BX), DX
		MOVBQZX	1(SI)(DX*1), AX
		MOVWQSX	2(BP), DX
		IMULQ	DX
		ADDQ	$4, BP
		ADDQ	sum+-40(SP), AX
		ADDQ	$8192, AX
		CMOVQLT	zero_0<>(SB), AX
		SHRQ	$14, AX
		CMPQ	u8max_2<>(SB), AX
		CMOVQLT	u8max_2<>(SB), AX
		ADDQ	$2, BX
		MOVB	AL, (DI)
		ADDQ	$1, DI
		SUBQ	$1, CX
		JNE	asmloop_2
end_4:
		MOVQ	srcref+-24(SP), SI
		ADDQ	dstoff+-32(SP), DI
		ADDQ	sp+128(FP), SI
		MOVQ	SI, srcref+-24(SP)
		SUBQ	$1, height+112(FP)
		JNE	yloop_0
		RET

TEXT ·h8scale4Amd64(SB),4,$40-136
		MOVQ	dp+120(FP), BX
		MOVQ	width+104(FP), CX
		MOVQ	CX, DX
		SUBQ	CX, BX
		SHRQ	$4, CX
		ANDQ	$15, DX
		MOVQ	BX, dstoff+-32(SP)
		MOVQ	CX, simdroll+-8(SP)
		MOVQ	DX, asmroll+-16(SP)
		MOVQ	src+24(FP), AX
		MOVQ	AX, srcref+-24(SP)
		MOVQ	taps+96(FP), DX
		SUBQ	$2, DX
		PXOR	X15, X15
		MOVO	hbits_1<>(SB), X14
		MOVQ	src+24(FP), SI
		MOVQ	dst+0(FP), DI
yloop_5:
		MOVQ	off+72(FP), BX
		MOVQ	cof+48(FP), BP
		MOVQ	simdroll+-8(SP), CX
		ORQ	CX, CX
		JE	nosimdloop_8
simdloop_6:
		MOVWQSX	(BX), AX
		MOVWQSX	2(BX), DX
		MOVL	(SI)(AX*1), X0
		MOVL	(SI)(DX*1), X8
		MOVWQSX	4(BX), AX
		MOVWQSX	6(BX), DX
		MOVL	(SI)(AX*1), X1
		MOVL	(SI)(DX*1), X9
		PUNPCKLLQ	X8, X0
		PUNPCKLLQ	X9, X1
		MOVWQSX	8(BX), AX
		MOVWQSX	10(BX), DX
		MOVL	(SI)(AX*1), X2
		MOVL	(SI)(DX*1), X10
		MOVWQSX	12(BX), AX
		MOVWQSX	14(BX), DX
		MOVL	(SI)(AX*1), X3
		MOVL	(SI)(DX*1), X11
		PUNPCKLLQ	X10, X2
		PUNPCKLLQ	X11, X3
		MOVWQSX	16(BX), AX
		MOVWQSX	18(BX), DX
		MOVL	(SI)(AX*1), X4
		MOVL	(SI)(DX*1), X12
		MOVWQSX	20(BX), AX
		MOVWQSX	22(BX), DX
		MOVL	(SI)(AX*1), X5
		MOVL	(SI)(DX*1), X13
		PUNPCKLLQ	X12, X4
		PUNPCKLLQ	X13, X5
		MOVWQSX	24(BX), AX
		MOVWQSX	26(BX), DX
		MOVL	(SI)(AX*1), X6
		MOVL	(SI)(DX*1), X8
		MOVWQSX	28(BX), AX
		MOVWQSX	30(BX), DX
		MOVL	(SI)(AX*1), X7
		MOVL	(SI)(DX*1), X9
		PUNPCKLLQ	X8, X6
		PUNPCKLLQ	X9, X7
		ADDQ	$32, BX
		PUNPCKLBW	X15, X0
		PMADDWL	(BP), X0
		PUNPCKLBW	X15, X1
		PMADDWL	16(BP), X1
		PUNPCKLBW	X15, X2
		PMADDWL	32(BP), X2
		PUNPCKLBW	X15, X3
		PMADDWL	48(BP), X3
		MOVO	X0, X10
		MOVO	X2, X11
		SHUFPS	$221, X1, X10
		SHUFPS	$221, X3, X11
		SHUFPS	$136, X1, X0
		SHUFPS	$136, X3, X2
		PADDL	X10, X0
		PADDL	X11, X2
		PUNPCKLBW	X15, X4
		PMADDWL	64(BP), X4
		PUNPCKLBW	X15, X5
		PMADDWL	80(BP), X5
		PUNPCKLBW	X15, X6
		PMADDWL	96(BP), X6
		PUNPCKLBW	X15, X7
		PMADDWL	112(BP), X7
		MOVO	X4, X12
		MOVO	X6, X13
		SHUFPS	$221, X5, X12
		SHUFPS	$221, X7, X13
		SHUFPS	$136, X5, X4
		SHUFPS	$136, X7, X6
		PADDL	X12, X4
		PADDL	X13, X6
		ADDQ	$128, BP
		PADDL	X14, X0
		PADDL	X14, X2
		PADDL	X14, X4
		PADDL	X14, X6
		PSRAL	$14, X0
		PSRAL	$14, X2
		PSRAL	$14, X4
		PSRAL	$14, X6
		PACKSSLW	X2, X0
		PACKSSLW	X6, X4
		PACKUSWB	X4, X0
		MOVOU	X0, (DI)
		ADDQ	$16, DI
		SUBQ	$1, CX
		JNE	simdloop_6
nosimdloop_8:
		MOVQ	asmroll+-16(SP), CX
		ORQ	CX, CX
		JE	end_9
asmloop_7:
		MOVWQSX	(BX), DX
		MOVBQZX	(SI)(DX*1), AX
		MOVWQSX	(BP), DX
		IMULQ	DX
		MOVQ	AX, sum+-40(SP)
		MOVWQSX	(BX), DX
		MOVBQZX	1(SI)(DX*1), AX
		MOVWQSX	2(BP), DX
		IMULQ	DX
		ADDQ	AX, sum+-40(SP)
		MOVWQSX	(BX), DX
		MOVBQZX	2(SI)(DX*1), AX
		MOVWQSX	4(BP), DX
		IMULQ	DX
		ADDQ	AX, sum+-40(SP)
		MOVWQSX	(BX), DX
		MOVBQZX	3(SI)(DX*1), AX
		MOVWQSX	6(BP), DX
		IMULQ	DX
		ADDQ	$8, BP
		ADDQ	sum+-40(SP), AX
		ADDQ	$8192, AX
		CMOVQLT	zero_0<>(SB), AX
		SHRQ	$14, AX
		CMPQ	u8max_2<>(SB), AX
		CMOVQLT	u8max_2<>(SB), AX
		ADDQ	$2, BX
		MOVB	AL, (DI)
		ADDQ	$1, DI
		SUBQ	$1, CX
		JNE	asmloop_7
end_9:
		MOVQ	srcref+-24(SP), SI
		ADDQ	dstoff+-32(SP), DI
		ADDQ	sp+128(FP), SI
		MOVQ	SI, srcref+-24(SP)
		SUBQ	$1, height+112(FP)
		JNE	yloop_5
		RET

TEXT ·h8scale8Amd64(SB),4,$40-136
		MOVQ	dp+120(FP), BX
		MOVQ	width+104(FP), CX
		MOVQ	CX, DX
		SUBQ	CX, BX
		SHRQ	$4, CX
		ANDQ	$15, DX
		MOVQ	BX, dstoff+-32(SP)
		MOVQ	CX, simdroll+-8(SP)
		MOVQ	DX, asmroll+-16(SP)
		MOVQ	src+24(FP), AX
		MOVQ	AX, srcref+-24(SP)
		MOVQ	taps+96(FP), DX
		SUBQ	$2, DX
		PXOR	X15, X15
		MOVO	hbits_1<>(SB), X14
		MOVQ	src+24(FP), SI
		MOVQ	dst+0(FP), DI
yloop_10:
		MOVQ	off+72(FP), BX
		MOVQ	cof+48(FP), BP
		MOVQ	simdroll+-8(SP), CX
		ORQ	CX, CX
		JE	nosimdloop_13
simdloop_11:
		MOVWQSX	(BX), AX
		MOVQ	(SI)(AX*1), X0
		MOVWQSX	2(BX), DX
		MOVQ	(SI)(DX*1), X1
		MOVWQSX	4(BX), AX
		MOVQ	(SI)(AX*1), X2
		MOVWQSX	6(BX), DX
		MOVQ	(SI)(DX*1), X3
		MOVWQSX	8(BX), AX
		MOVQ	(SI)(AX*1), X4
		MOVWQSX	10(BX), DX
		MOVQ	(SI)(DX*1), X5
		MOVWQSX	12(BX), AX
		MOVQ	(SI)(AX*1), X6
		MOVWQSX	14(BX), DX
		MOVQ	(SI)(DX*1), X7
		MOVWQSX	16(BX), AX
		MOVQ	(SI)(AX*1), X8
		MOVWQSX	18(BX), DX
		MOVQ	(SI)(DX*1), X9
		MOVWQSX	20(BX), AX
		MOVQ	(SI)(AX*1), X10
		MOVWQSX	22(BX), DX
		MOVQ	(SI)(DX*1), X11
		PUNPCKLBW	X15, X0
		PMADDWL	(BP), X0
		PUNPCKLBW	X15, X1
		PMADDWL	16(BP), X1
		PUNPCKLBW	X15, X2
		PMADDWL	32(BP), X2
		PUNPCKLBW	X15, X3
		PMADDWL	48(BP), X3
		MOVO	X0, X12
		MOVO	X2, X13
		PUNPCKLQDQ	X1, X0
		PUNPCKHQDQ	X1, X12
		PADDL	X12, X0
		PUNPCKLQDQ	X3, X2
		PUNPCKHQDQ	X3, X13
		PADDL	X13, X2
		MOVO	X0, X12
		SHUFPS	$136, X2, X0
		SHUFPS	$221, X2, X12
		PADDL	X12, X0
		PUNPCKLBW	X15, X4
		PMADDWL	64(BP), X4
		PUNPCKLBW	X15, X5
		PMADDWL	80(BP), X5
		PUNPCKLBW	X15, X6
		PMADDWL	96(BP), X6
		PUNPCKLBW	X15, X7
		PMADDWL	112(BP), X7
		MOVO	X4, X1
		MOVO	X6, X2
		PUNPCKLQDQ	X5, X4
		PUNPCKHQDQ	X5, X1
		PADDL	X1, X4
		PUNPCKLQDQ	X7, X6
		PUNPCKHQDQ	X7, X2
		PADDL	X2, X6
		MOVO	X4, X1
		SHUFPS	$136, X6, X4
		SHUFPS	$221, X6, X1
		PADDL	X1, X4
		MOVWQSX	24(BX), AX
		MOVQ	(SI)(AX*1), X1
		MOVWQSX	26(BX), DX
		MOVQ	(SI)(DX*1), X2
		MOVWQSX	28(BX), AX
		MOVQ	(SI)(AX*1), X3
		MOVWQSX	30(BX), DX
		MOVQ	(SI)(DX*1), X5
		ADDQ	$32, BX
		PUNPCKLBW	X15, X8
		PMADDWL	128(BP), X8
		PUNPCKLBW	X15, X9
		PMADDWL	144(BP), X9
		PUNPCKLBW	X15, X10
		PMADDWL	160(BP), X10
		PUNPCKLBW	X15, X11
		PMADDWL	176(BP), X11
		MOVO	X8, X12
		MOVO	X10, X13
		PUNPCKLQDQ	X9, X8
		PUNPCKHQDQ	X9, X12
		PADDL	X12, X8
		PUNPCKLQDQ	X11, X10
		PUNPCKHQDQ	X11, X13
		PADDL	X13, X10
		MOVO	X8, X12
		SHUFPS	$136, X10, X8
		SHUFPS	$221, X10, X12
		PADDL	X12, X8
		PUNPCKLBW	X15, X1
		PMADDWL	192(BP), X1
		PUNPCKLBW	X15, X2
		PMADDWL	208(BP), X2
		PUNPCKLBW	X15, X3
		PMADDWL	224(BP), X3
		PUNPCKLBW	X15, X5
		PMADDWL	240(BP), X5
		MOVO	X1, X10
		MOVO	X3, X11
		PUNPCKLQDQ	X2, X1
		PUNPCKHQDQ	X2, X10
		PADDL	X10, X1
		PUNPCKLQDQ	X5, X3
		PUNPCKHQDQ	X5, X11
		PADDL	X11, X3
		MOVO	X1, X10
		SHUFPS	$136, X3, X1
		SHUFPS	$221, X3, X10
		PADDL	X10, X1
		ADDQ	$256, BP
		PADDL	X14, X0
		PADDL	X14, X4
		PADDL	X14, X8
		PADDL	X14, X1
		PSRAL	$14, X0
		PSRAL	$14, X4
		PSRAL	$14, X8
		PSRAL	$14, X1
		PACKSSLW	X4, X0
		PACKSSLW	X1, X8
		PACKUSWB	X8, X0
		MOVOU	X0, (DI)
		ADDQ	$16, DI
		SUBQ	$1, CX
		JNE	simdloop_11
nosimdloop_13:
		MOVQ	asmroll+-16(SP), CX
		ORQ	CX, CX
		JE	end_14
asmloop_12:
		MOVWQSX	(BX), DX
		MOVBQZX	(SI)(DX*1), AX
		MOVWQSX	(BP), DX
		IMULQ	DX
		MOVQ	AX, sum+-40(SP)
		MOVWQSX	(BX), DX
		MOVBQZX	1(SI)(DX*1), AX
		MOVWQSX	2(BP), DX
		IMULQ	DX
		ADDQ	AX, sum+-40(SP)
		MOVWQSX	(BX), DX
		MOVBQZX	2(SI)(DX*1), AX
		MOVWQSX	4(BP), DX
		IMULQ	DX
		ADDQ	AX, sum+-40(SP)
		MOVWQSX	(BX), DX
		MOVBQZX	3(SI)(DX*1), AX
		MOVWQSX	6(BP), DX
		IMULQ	DX
		ADDQ	AX, sum+-40(SP)
		MOVWQSX	(BX), DX
		MOVBQZX	4(SI)(DX*1), AX
		MOVWQSX	8(BP), DX
		IMULQ	DX
		ADDQ	AX, sum+-40(SP)
		MOVWQSX	(BX), DX
		MOVBQZX	5(SI)(DX*1), AX
		MOVWQSX	10(BP), DX
		IMULQ	DX
		ADDQ	AX, sum+-40(SP)
		MOVWQSX	(BX), DX
		MOVBQZX	6(SI)(DX*1), AX
		MOVWQSX	12(BP), DX
		IMULQ	DX
		ADDQ	AX, sum+-40(SP)
		MOVWQSX	(BX), DX
		MOVBQZX	7(SI)(DX*1), AX
		MOVWQSX	14(BP), DX
		IMULQ	DX
		ADDQ	$16, BP
		ADDQ	sum+-40(SP), AX
		ADDQ	$8192, AX
		CMOVQLT	zero_0<>(SB), AX
		SHRQ	$14, AX
		CMPQ	u8max_2<>(SB), AX
		CMOVQLT	u8max_2<>(SB), AX
		ADDQ	$2, BX
		MOVB	AL, (DI)
		ADDQ	$1, DI
		SUBQ	$1, CX
		JNE	asmloop_12
end_14:
		MOVQ	srcref+-24(SP), SI
		ADDQ	dstoff+-32(SP), DI
		ADDQ	sp+128(FP), SI
		MOVQ	SI, srcref+-24(SP)
		SUBQ	$1, height+112(FP)
		JNE	yloop_10
		RET

TEXT ·h8scale10Amd64(SB),4,$40-136
		MOVQ	dp+120(FP), BX
		MOVQ	width+104(FP), CX
		MOVQ	CX, DX
		SUBQ	CX, BX
		SHRQ	$4, CX
		ANDQ	$15, DX
		MOVQ	BX, dstoff+-32(SP)
		MOVQ	CX, simdroll+-8(SP)
		MOVQ	DX, asmroll+-16(SP)
		MOVQ	src+24(FP), AX
		MOVQ	AX, srcref+-24(SP)
		MOVQ	taps+96(FP), DX
		SUBQ	$2, DX
		PXOR	X15, X15
		MOVO	hbits_1<>(SB), X14
		MOVQ	src+24(FP), SI
		MOVQ	dst+0(FP), DI
yloop_15:
		MOVQ	off+72(FP), BX
		MOVQ	cof+48(FP), BP
		MOVQ	simdroll+-8(SP), CX
		ORQ	CX, CX
		JE	nosimdloop_18
simdloop_16:
		MOVWQSX	(BX), R8
		MOVWQSX	2(BX), R9
		MOVWQSX	4(BX), R10
		MOVWQSX	6(BX), R11
		PINSRW	$0, (SI)(R8*1), X0
		PINSRW	$1, (SI)(R9*1), X0
		PINSRW	$2, (SI)(R10*1), X0
		PINSRW	$3, (SI)(R11*1), X0
		MOVWQSX	8(BX), R8
		MOVWQSX	10(BX), R9
		MOVWQSX	12(BX), R10
		MOVWQSX	14(BX), R11
		PINSRW	$0, (SI)(R8*1), X1
		PINSRW	$1, (SI)(R9*1), X1
		PINSRW	$2, (SI)(R10*1), X1
		PINSRW	$3, (SI)(R11*1), X1
		MOVWQSX	16(BX), R8
		MOVWQSX	18(BX), R9
		MOVWQSX	20(BX), R10
		MOVWQSX	22(BX), R11
		PINSRW	$0, (SI)(R8*1), X2
		PINSRW	$1, (SI)(R9*1), X2
		PINSRW	$2, (SI)(R10*1), X2
		PINSRW	$3, (SI)(R11*1), X2
		MOVWQSX	24(BX), R8
		MOVWQSX	26(BX), R9
		MOVWQSX	28(BX), R10
		MOVWQSX	30(BX), R11
		PINSRW	$0, (SI)(R8*1), X3
		PINSRW	$1, (SI)(R9*1), X3
		PINSRW	$2, (SI)(R10*1), X3
		PINSRW	$3, (SI)(R11*1), X3
		ADDQ	$2, SI
		PUNPCKLBW	X15, X0
		PMADDWL	(BP), X0
		PUNPCKLBW	X15, X1
		PMADDWL	16(BP), X1
		PUNPCKLBW	X15, X2
		PMADDWL	32(BP), X2
		PUNPCKLBW	X15, X3
		PMADDWL	48(BP), X3
		ADDQ	$64, BP
		MOVWQSX	(BX), R8
		MOVWQSX	2(BX), R9
		MOVWQSX	4(BX), R10
		MOVWQSX	6(BX), R11
		PINSRW	$0, (SI)(R8*1), X4
		PINSRW	$1, (SI)(R9*1), X4
		PINSRW	$2, (SI)(R10*1), X4
		PINSRW	$3, (SI)(R11*1), X4
		MOVWQSX	8(BX), R8
		MOVWQSX	10(BX), R9
		MOVWQSX	12(BX), R10
		MOVWQSX	14(BX), R11
		PINSRW	$0, (SI)(R8*1), X5
		PINSRW	$1, (SI)(R9*1), X5
		PINSRW	$2, (SI)(R10*1), X5
		PINSRW	$3, (SI)(R11*1), X5
		MOVWQSX	16(BX), R8
		MOVWQSX	18(BX), R9
		MOVWQSX	20(BX), R10
		MOVWQSX	22(BX), R11
		PINSRW	$0, (SI)(R8*1), X6
		PINSRW	$1, (SI)(R9*1), X6
		PINSRW	$2, (SI)(R10*1), X6
		PINSRW	$3, (SI)(R11*1), X6
		MOVWQSX	24(BX), R8
		MOVWQSX	26(BX), R9
		MOVWQSX	28(BX), R10
		MOVWQSX	30(BX), R11
		PINSRW	$0, (SI)(R8*1), X7
		PINSRW	$1, (SI)(R9*1), X7
		PINSRW	$2, (SI)(R10*1), X7
		PINSRW	$3, (SI)(R11*1), X7
		ADDQ	$2, SI
		PUNPCKLBW	X15, X4
		PMADDWL	(BP), X4
		PUNPCKLBW	X15, X5
		PMADDWL	16(BP), X5
		PUNPCKLBW	X15, X6
		PMADDWL	32(BP), X6
		PUNPCKLBW	X15, X7
		PMADDWL	48(BP), X7
		ADDQ	$64, BP
		PADDL	X4, X0
		PADDL	X5, X1
		PADDL	X6, X2
		PADDL	X7, X3
		MOVWQSX	(BX), R8
		MOVWQSX	2(BX), R9
		MOVWQSX	4(BX), R10
		MOVWQSX	6(BX), R11
		PINSRW	$0, (SI)(R8*1), X4
		PINSRW	$1, (SI)(R9*1), X4
		PINSRW	$2, (SI)(R10*1), X4
		PINSRW	$3, (SI)(R11*1), X4
		MOVWQSX	8(BX), R8
		MOVWQSX	10(BX), R9
		MOVWQSX	12(BX), R10
		MOVWQSX	14(BX), R11
		PINSRW	$0, (SI)(R8*1), X5
		PINSRW	$1, (SI)(R9*1), X5
		PINSRW	$2, (SI)(R10*1), X5
		PINSRW	$3, (SI)(R11*1), X5
		MOVWQSX	16(BX), R8
		MOVWQSX	18(BX), R9
		MOVWQSX	20(BX), R10
		MOVWQSX	22(BX), R11
		PINSRW	$0, (SI)(R8*1), X6
		PINSRW	$1, (SI)(R9*1), X6
		PINSRW	$2, (SI)(R10*1), X6
		PINSRW	$3, (SI)(R11*1), X6
		MOVWQSX	24(BX), R8
		MOVWQSX	26(BX), R9
		MOVWQSX	28(BX), R10
		MOVWQSX	30(BX), R11
		PINSRW	$0, (SI)(R8*1), X7
		PINSRW	$1, (SI)(R9*1), X7
		PINSRW	$2, (SI)(R10*1), X7
		PINSRW	$3, (SI)(R11*1), X7
		ADDQ	$2, SI
		PUNPCKLBW	X15, X4
		PMADDWL	(BP), X4
		PUNPCKLBW	X15, X5
		PMADDWL	16(BP), X5
		PUNPCKLBW	X15, X6
		PMADDWL	32(BP), X6
		PUNPCKLBW	X15, X7
		PMADDWL	48(BP), X7
		ADDQ	$64, BP
		PADDL	X4, X0
		PADDL	X5, X1
		PADDL	X6, X2
		PADDL	X7, X3
		MOVWQSX	(BX), R8
		MOVWQSX	2(BX), R9
		MOVWQSX	4(BX), R10
		MOVWQSX	6(BX), R11
		PINSRW	$0, (SI)(R8*1), X4
		PINSRW	$1, (SI)(R9*1), X4
		PINSRW	$2, (SI)(R10*1), X4
		PINSRW	$3, (SI)(R11*1), X4
		MOVWQSX	8(BX), R8
		MOVWQSX	10(BX), R9
		MOVWQSX	12(BX), R10
		MOVWQSX	14(BX), R11
		PINSRW	$0, (SI)(R8*1), X5
		PINSRW	$1, (SI)(R9*1), X5
		PINSRW	$2, (SI)(R10*1), X5
		PINSRW	$3, (SI)(R11*1), X5
		MOVWQSX	16(BX), R8
		MOVWQSX	18(BX), R9
		MOVWQSX	20(BX), R10
		MOVWQSX	22(BX), R11
		PINSRW	$0, (SI)(R8*1), X6
		PINSRW	$1, (SI)(R9*1), X6
		PINSRW	$2, (SI)(R10*1), X6
		PINSRW	$3, (SI)(R11*1), X6
		MOVWQSX	24(BX), R8
		MOVWQSX	26(BX), R9
		MOVWQSX	28(BX), R10
		MOVWQSX	30(BX), R11
		PINSRW	$0, (SI)(R8*1), X7
		PINSRW	$1, (SI)(R9*1), X7
		PINSRW	$2, (SI)(R10*1), X7
		PINSRW	$3, (SI)(R11*1), X7
		ADDQ	$2, SI
		PUNPCKLBW	X15, X4
		PMADDWL	(BP), X4
		PUNPCKLBW	X15, X5
		PMADDWL	16(BP), X5
		PUNPCKLBW	X15, X6
		PMADDWL	32(BP), X6
		PUNPCKLBW	X15, X7
		PMADDWL	48(BP), X7
		ADDQ	$64, BP
		PADDL	X4, X0
		PADDL	X5, X1
		PADDL	X6, X2
		PADDL	X7, X3
		MOVWQSX	(BX), R8
		MOVWQSX	2(BX), R9
		MOVWQSX	4(BX), R10
		MOVWQSX	6(BX), R11
		PINSRW	$0, (SI)(R8*1), X4
		PINSRW	$1, (SI)(R9*1), X4
		PINSRW	$2, (SI)(R10*1), X4
		PINSRW	$3, (SI)(R11*1), X4
		MOVWQSX	8(BX), R8
		MOVWQSX	10(BX), R9
		MOVWQSX	12(BX), R10
		MOVWQSX	14(BX), R11
		PINSRW	$0, (SI)(R8*1), X5
		PINSRW	$1, (SI)(R9*1), X5
		PINSRW	$2, (SI)(R10*1), X5
		PINSRW	$3, (SI)(R11*1), X5
		MOVWQSX	16(BX), R8
		MOVWQSX	18(BX), R9
		MOVWQSX	20(BX), R10
		MOVWQSX	22(BX), R11
		PINSRW	$0, (SI)(R8*1), X6
		PINSRW	$1, (SI)(R9*1), X6
		PINSRW	$2, (SI)(R10*1), X6
		PINSRW	$3, (SI)(R11*1), X6
		MOVWQSX	24(BX), R8
		MOVWQSX	26(BX), R9
		MOVWQSX	28(BX), R10
		MOVWQSX	30(BX), R11
		PINSRW	$0, (SI)(R8*1), X7
		PINSRW	$1, (SI)(R9*1), X7
		PINSRW	$2, (SI)(R10*1), X7
		PINSRW	$3, (SI)(R11*1), X7
		ADDQ	$2, SI
		PUNPCKLBW	X15, X4
		PMADDWL	(BP), X4
		PUNPCKLBW	X15, X5
		PMADDWL	16(BP), X5
		PUNPCKLBW	X15, X6
		PMADDWL	32(BP), X6
		PUNPCKLBW	X15, X7
		PMADDWL	48(BP), X7
		ADDQ	$64, BP
		PADDL	X4, X0
		PADDL	X5, X1
		PADDL	X6, X2
		PADDL	X7, X3
		MOVQ	taps+96(FP), AX
		SUBQ	AX, SI
		ADDQ	$32, BX
		PADDL	X14, X0
		PADDL	X14, X1
		PADDL	X14, X2
		PADDL	X14, X3
		PSRAL	$14, X0
		PSRAL	$14, X1
		PSRAL	$14, X2
		PSRAL	$14, X3
		PACKSSLW	X1, X0
		PACKSSLW	X3, X2
		PACKUSWB	X2, X0
		MOVOU	X0, (DI)
		ADDQ	$16, DI
		SUBQ	$1, CX
		JNE	simdloop_16
nosimdloop_18:
		MOVQ	asmroll+-16(SP), CX
		ORQ	CX, CX
		JE	end_19
asmloop_17:
		MOVWQSX	(BX), DX
		MOVBQZX	(SI)(DX*1), AX
		MOVWQSX	(BP), DX
		IMULQ	DX
		MOVQ	AX, sum+-40(SP)
		MOVWQSX	(BX), DX
		MOVBQZX	1(SI)(DX*1), AX
		MOVWQSX	2(BP), DX
		IMULQ	DX
		ADDQ	AX, sum+-40(SP)
		MOVWQSX	(BX), DX
		MOVBQZX	2(SI)(DX*1), AX
		MOVWQSX	4(BP), DX
		IMULQ	DX
		ADDQ	AX, sum+-40(SP)
		MOVWQSX	(BX), DX
		MOVBQZX	3(SI)(DX*1), AX
		MOVWQSX	6(BP), DX
		IMULQ	DX
		ADDQ	AX, sum+-40(SP)
		MOVWQSX	(BX), DX
		MOVBQZX	4(SI)(DX*1), AX
		MOVWQSX	8(BP), DX
		IMULQ	DX
		ADDQ	AX, sum+-40(SP)
		MOVWQSX	(BX), DX
		MOVBQZX	5(SI)(DX*1), AX
		MOVWQSX	10(BP), DX
		IMULQ	DX
		ADDQ	AX, sum+-40(SP)
		MOVWQSX	(BX), DX
		MOVBQZX	6(SI)(DX*1), AX
		MOVWQSX	12(BP), DX
		IMULQ	DX
		ADDQ	AX, sum+-40(SP)
		MOVWQSX	(BX), DX
		MOVBQZX	7(SI)(DX*1), AX
		MOVWQSX	14(BP), DX
		IMULQ	DX
		ADDQ	AX, sum+-40(SP)
		MOVWQSX	(BX), DX
		MOVBQZX	8(SI)(DX*1), AX
		MOVWQSX	16(BP), DX
		IMULQ	DX
		ADDQ	AX, sum+-40(SP)
		MOVWQSX	(BX), DX
		MOVBQZX	9(SI)(DX*1), AX
		MOVWQSX	18(BP), DX
		IMULQ	DX
		ADDQ	$20, BP
		ADDQ	sum+-40(SP), AX
		ADDQ	$8192, AX
		CMOVQLT	zero_0<>(SB), AX
		SHRQ	$14, AX
		CMPQ	u8max_2<>(SB), AX
		CMOVQLT	u8max_2<>(SB), AX
		ADDQ	$2, BX
		MOVB	AL, (DI)
		ADDQ	$1, DI
		SUBQ	$1, CX
		JNE	asmloop_17
end_19:
		MOVQ	srcref+-24(SP), SI
		ADDQ	dstoff+-32(SP), DI
		ADDQ	sp+128(FP), SI
		MOVQ	SI, srcref+-24(SP)
		SUBQ	$1, height+112(FP)
		JNE	yloop_15
		RET

TEXT ·h8scale12Amd64(SB),4,$40-136
		MOVQ	dp+120(FP), BX
		MOVQ	width+104(FP), CX
		MOVQ	CX, DX
		SUBQ	CX, BX
		SHRQ	$4, CX
		ANDQ	$15, DX
		MOVQ	BX, dstoff+-32(SP)
		MOVQ	CX, simdroll+-8(SP)
		MOVQ	DX, asmroll+-16(SP)
		MOVQ	src+24(FP), AX
		MOVQ	AX, srcref+-24(SP)
		MOVQ	taps+96(FP), DX
		SUBQ	$2, DX
		PXOR	X15, X15
		MOVO	hbits_1<>(SB), X14
		MOVQ	src+24(FP), SI
		MOVQ	dst+0(FP), DI
yloop_20:
		MOVQ	off+72(FP), BX
		MOVQ	cof+48(FP), BP
		MOVQ	simdroll+-8(SP), CX
		ORQ	CX, CX
		JE	nosimdloop_23
simdloop_21:
		MOVWQSX	(BX), R8
		MOVWQSX	2(BX), R9
		MOVWQSX	4(BX), R10
		MOVWQSX	6(BX), R11
		PINSRW	$0, (SI)(R8*1), X0
		PINSRW	$1, (SI)(R9*1), X0
		PINSRW	$2, (SI)(R10*1), X0
		PINSRW	$3, (SI)(R11*1), X0
		MOVWQSX	8(BX), R8
		MOVWQSX	10(BX), R9
		MOVWQSX	12(BX), R10
		MOVWQSX	14(BX), R11
		PINSRW	$0, (SI)(R8*1), X1
		PINSRW	$1, (SI)(R9*1), X1
		PINSRW	$2, (SI)(R10*1), X1
		PINSRW	$3, (SI)(R11*1), X1
		MOVWQSX	16(BX), R8
		MOVWQSX	18(BX), R9
		MOVWQSX	20(BX), R10
		MOVWQSX	22(BX), R11
		PINSRW	$0, (SI)(R8*1), X2
		PINSRW	$1, (SI)(R9*1), X2
		PINSRW	$2, (SI)(R10*1), X2
		PINSRW	$3, (SI)(R11*1), X2
		MOVWQSX	24(BX), R8
		MOVWQSX	26(BX), R9
		MOVWQSX	28(BX), R10
		MOVWQSX	30(BX), R11
		PINSRW	$0, (SI)(R8*1), X3
		PINSRW	$1, (SI)(R9*1), X3
		PINSRW	$2, (SI)(R10*1), X3
		PINSRW	$3, (SI)(R11*1), X3
		ADDQ	$2, SI
		PUNPCKLBW	X15, X0
		PMADDWL	(BP), X0
		PUNPCKLBW	X15, X1
		PMADDWL	16(BP), X1
		PUNPCKLBW	X15, X2
		PMADDWL	32(BP), X2
		PUNPCKLBW	X15, X3
		PMADDWL	48(BP), X3
		ADDQ	$64, BP
		MOVWQSX	(BX), R8
		MOVWQSX	2(BX), R9
		MOVWQSX	4(BX), R10
		MOVWQSX	6(BX), R11
		PINSRW	$0, (SI)(R8*1), X4
		PINSRW	$1, (SI)(R9*1), X4
		PINSRW	$2, (SI)(R10*1), X4
		PINSRW	$3, (SI)(R11*1), X4
		MOVWQSX	8(BX), R8
		MOVWQSX	10(BX), R9
		MOVWQSX	12(BX), R10
		MOVWQSX	14(BX), R11
		PINSRW	$0, (SI)(R8*1), X5
		PINSRW	$1, (SI)(R9*1), X5
		PINSRW	$2, (SI)(R10*1), X5
		PINSRW	$3, (SI)(R11*1), X5
		MOVWQSX	16(BX), R8
		MOVWQSX	18(BX), R9
		MOVWQSX	20(BX), R10
		MOVWQSX	22(BX), R11
		PINSRW	$0, (SI)(R8*1), X6
		PINSRW	$1, (SI)(R9*1), X6
		PINSRW	$2, (SI)(R10*1), X6
		PINSRW	$3, (SI)(R11*1), X6
		MOVWQSX	24(BX), R8
		MOVWQSX	26(BX), R9
		MOVWQSX	28(BX), R10
		MOVWQSX	30(BX), R11
		PINSRW	$0, (SI)(R8*1), X7
		PINSRW	$1, (SI)(R9*1), X7
		PINSRW	$2, (SI)(R10*1), X7
		PINSRW	$3, (SI)(R11*1), X7
		ADDQ	$2, SI
		PUNPCKLBW	X15, X4
		PMADDWL	(BP), X4
		PUNPCKLBW	X15, X5
		PMADDWL	16(BP), X5
		PUNPCKLBW	X15, X6
		PMADDWL	32(BP), X6
		PUNPCKLBW	X15, X7
		PMADDWL	48(BP), X7
		ADDQ	$64, BP
		PADDL	X4, X0
		PADDL	X5, X1
		PADDL	X6, X2
		PADDL	X7, X3
		MOVWQSX	(BX), R8
		MOVWQSX	2(BX), R9
		MOVWQSX	4(BX), R10
		MOVWQSX	6(BX), R11
		PINSRW	$0, (SI)(R8*1), X4
		PINSRW	$1, (SI)(R9*1), X4
		PINSRW	$2, (SI)(R10*1), X4
		PINSRW	$3, (SI)(R11*1), X4
		MOVWQSX	8(BX), R8
		MOVWQSX	10(BX), R9
		MOVWQSX	12(BX), R10
		MOVWQSX	14(BX), R11
		PINSRW	$0, (SI)(R8*1), X5
		PINSRW	$1, (SI)(R9*1), X5
		PINSRW	$2, (SI)(R10*1), X5
		PINSRW	$3, (SI)(R11*1), X5
		MOVWQSX	16(BX), R8
		MOVWQSX	18(BX), R9
		MOVWQSX	20(BX), R10
		MOVWQSX	22(BX), R11
		PINSRW	$0, (SI)(R8*1), X6
		PINSRW	$1, (SI)(R9*1), X6
		PINSRW	$2, (SI)(R10*1), X6
		PINSRW	$3, (SI)(R11*1), X6
		MOVWQSX	24(BX), R8
		MOVWQSX	26(BX), R9
		MOVWQSX	28(BX), R10
		MOVWQSX	30(BX), R11
		PINSRW	$0, (SI)(R8*1), X7
		PINSRW	$1, (SI)(R9*1), X7
		PINSRW	$2, (SI)(R10*1), X7
		PINSRW	$3, (SI)(R11*1), X7
		ADDQ	$2, SI
		PUNPCKLBW	X15, X4
		PMADDWL	(BP), X4
		PUNPCKLBW	X15, X5
		PMADDWL	16(BP), X5
		PUNPCKLBW	X15, X6
		PMADDWL	32(BP), X6
		PUNPCKLBW	X15, X7
		PMADDWL	48(BP), X7
		ADDQ	$64, BP
		PADDL	X4, X0
		PADDL	X5, X1
		PADDL	X6, X2
		PADDL	X7, X3
		MOVWQSX	(BX), R8
		MOVWQSX	2(BX), R9
		MOVWQSX	4(BX), R10
		MOVWQSX	6(BX), R11
		PINSRW	$0, (SI)(R8*1), X4
		PINSRW	$1, (SI)(R9*1), X4
		PINSRW	$2, (SI)(R10*1), X4
		PINSRW	$3, (SI)(R11*1), X4
		MOVWQSX	8(BX), R8
		MOVWQSX	10(BX), R9
		MOVWQSX	12(BX), R10
		MOVWQSX	14(BX), R11
		PINSRW	$0, (SI)(R8*1), X5
		PINSRW	$1, (SI)(R9*1), X5
		PINSRW	$2, (SI)(R10*1), X5
		PINSRW	$3, (SI)(R11*1), X5
		MOVWQSX	16(BX), R8
		MOVWQSX	18(BX), R9
		MOVWQSX	20(BX), R10
		MOVWQSX	22(BX), R11
		PINSRW	$0, (SI)(R8*1), X6
		PINSRW	$1, (SI)(R9*1), X6
		PINSRW	$2, (SI)(R10*1), X6
		PINSRW	$3, (SI)(R11*1), X6
		MOVWQSX	24(BX), R8
		MOVWQSX	26(BX), R9
		MOVWQSX	28(BX), R10
		MOVWQSX	30(BX), R11
		PINSRW	$0, (SI)(R8*1), X7
		PINSRW	$1, (SI)(R9*1), X7
		PINSRW	$2, (SI)(R10*1), X7
		PINSRW	$3, (SI)(R11*1), X7
		ADDQ	$2, SI
		PUNPCKLBW	X15, X4
		PMADDWL	(BP), X4
		PUNPCKLBW	X15, X5
		PMADDWL	16(BP), X5
		PUNPCKLBW	X15, X6
		PMADDWL	32(BP), X6
		PUNPCKLBW	X15, X7
		PMADDWL	48(BP), X7
		ADDQ	$64, BP
		PADDL	X4, X0
		PADDL	X5, X1
		PADDL	X6, X2
		PADDL	X7, X3
		MOVWQSX	(BX), R8
		MOVWQSX	2(BX), R9
		MOVWQSX	4(BX), R10
		MOVWQSX	6(BX), R11
		PINSRW	$0, (SI)(R8*1), X4
		PINSRW	$1, (SI)(R9*1), X4
		PINSRW	$2, (SI)(R10*1), X4
		PINSRW	$3, (SI)(R11*1), X4
		MOVWQSX	8(BX), R8
		MOVWQSX	10(BX), R9
		MOVWQSX	12(BX), R10
		MOVWQSX	14(BX), R11
		PINSRW	$0, (SI)(R8*1), X5
		PINSRW	$1, (SI)(R9*1), X5
		PINSRW	$2, (SI)(R10*1), X5
		PINSRW	$3, (SI)(R11*1), X5
		MOVWQSX	16(BX), R8
		MOVWQSX	18(BX), R9
		MOVWQSX	20(BX), R10
		MOVWQSX	22(BX), R11
		PINSRW	$0, (SI)(R8*1), X6
		PINSRW	$1, (SI)(R9*1), X6
		PINSRW	$2, (SI)(R10*1), X6
		PINSRW	$3, (SI)(R11*1), X6
		MOVWQSX	24(BX), R8
		MOVWQSX	26(BX), R9
		MOVWQSX	28(BX), R10
		MOVWQSX	30(BX), R11
		PINSRW	$0, (SI)(R8*1), X7
		PINSRW	$1, (SI)(R9*1), X7
		PINSRW	$2, (SI)(R10*1), X7
		PINSRW	$3, (SI)(R11*1), X7
		ADDQ	$2, SI
		PUNPCKLBW	X15, X4
		PMADDWL	(BP), X4
		PUNPCKLBW	X15, X5
		PMADDWL	16(BP), X5
		PUNPCKLBW	X15, X6
		PMADDWL	32(BP), X6
		PUNPCKLBW	X15, X7
		PMADDWL	48(BP), X7
		ADDQ	$64, BP
		PADDL	X4, X0
		PADDL	X5, X1
		PADDL	X6, X2
		PADDL	X7, X3
		MOVWQSX	(BX), R8
		MOVWQSX	2(BX), R9
		MOVWQSX	4(BX), R10
		MOVWQSX	6(BX), R11
		PINSRW	$0, (SI)(R8*1), X4
		PINSRW	$1, (SI)(R9*1), X4
		PINSRW	$2, (SI)(R10*1), X4
		PINSRW	$3, (SI)(R11*1), X4
		MOVWQSX	8(BX), R8
		MOVWQSX	10(BX), R9
		MOVWQSX	12(BX), R10
		MOVWQSX	14(BX), R11
		PINSRW	$0, (SI)(R8*1), X5
		PINSRW	$1, (SI)(R9*1), X5
		PINSRW	$2, (SI)(R10*1), X5
		PINSRW	$3, (SI)(R11*1), X5
		MOVWQSX	16(BX), R8
		MOVWQSX	18(BX), R9
		MOVWQSX	20(BX), R10
		MOVWQSX	22(BX), R11
		PINSRW	$0, (SI)(R8*1), X6
		PINSRW	$1, (SI)(R9*1), X6
		PINSRW	$2, (SI)(R10*1), X6
		PINSRW	$3, (SI)(R11*1), X6
		MOVWQSX	24(BX), R8
		MOVWQSX	26(BX), R9
		MOVWQSX	28(BX), R10
		MOVWQSX	30(BX), R11
		PINSRW	$0, (SI)(R8*1), X7
		PINSRW	$1, (SI)(R9*1), X7
		PINSRW	$2, (SI)(R10*1), X7
		PINSRW	$3, (SI)(R11*1), X7
		ADDQ	$2, SI
		PUNPCKLBW	X15, X4
		PMADDWL	(BP), X4
		PUNPCKLBW	X15, X5
		PMADDWL	16(BP), X5
		PUNPCKLBW	X15, X6
		PMADDWL	32(BP), X6
		PUNPCKLBW	X15, X7
		PMADDWL	48(BP), X7
		ADDQ	$64, BP
		PADDL	X4, X0
		PADDL	X5, X1
		PADDL	X6, X2
		PADDL	X7, X3
		MOVQ	taps+96(FP), AX
		SUBQ	AX, SI
		ADDQ	$32, BX
		PADDL	X14, X0
		PADDL	X14, X1
		PADDL	X14, X2
		PADDL	X14, X3
		PSRAL	$14, X0
		PSRAL	$14, X1
		PSRAL	$14, X2
		PSRAL	$14, X3
		PACKSSLW	X1, X0
		PACKSSLW	X3, X2
		PACKUSWB	X2, X0
		MOVOU	X0, (DI)
		ADDQ	$16, DI
		SUBQ	$1, CX
		JNE	simdloop_21
nosimdloop_23:
		MOVQ	asmroll+-16(SP), CX
		ORQ	CX, CX
		JE	end_24
asmloop_22:
		MOVWQSX	(BX), DX
		MOVBQZX	(SI)(DX*1), AX
		MOVWQSX	(BP), DX
		IMULQ	DX
		MOVQ	AX, sum+-40(SP)
		MOVWQSX	(BX), DX
		MOVBQZX	1(SI)(DX*1), AX
		MOVWQSX	2(BP), DX
		IMULQ	DX
		ADDQ	AX, sum+-40(SP)
		MOVWQSX	(BX), DX
		MOVBQZX	2(SI)(DX*1), AX
		MOVWQSX	4(BP), DX
		IMULQ	DX
		ADDQ	AX, sum+-40(SP)
		MOVWQSX	(BX), DX
		MOVBQZX	3(SI)(DX*1), AX
		MOVWQSX	6(BP), DX
		IMULQ	DX
		ADDQ	AX, sum+-40(SP)
		MOVWQSX	(BX), DX
		MOVBQZX	4(SI)(DX*1), AX
		MOVWQSX	8(BP), DX
		IMULQ	DX
		ADDQ	AX, sum+-40(SP)
		MOVWQSX	(BX), DX
		MOVBQZX	5(SI)(DX*1), AX
		MOVWQSX	10(BP), DX
		IMULQ	DX
		ADDQ	AX, sum+-40(SP)
		MOVWQSX	(BX), DX
		MOVBQZX	6(SI)(DX*1), AX
		MOVWQSX	12(BP), DX
		IMULQ	DX
		ADDQ	AX, sum+-40(SP)
		MOVWQSX	(BX), DX
		MOVBQZX	7(SI)(DX*1), AX
		MOVWQSX	14(BP), DX
		IMULQ	DX
		ADDQ	AX, sum+-40(SP)
		MOVWQSX	(BX), DX
		MOVBQZX	8(SI)(DX*1), AX
		MOVWQSX	16(BP), DX
		IMULQ	DX
		ADDQ	AX, sum+-40(SP)
		MOVWQSX	(BX), DX
		MOVBQZX	9(SI)(DX*1), AX
		MOVWQSX	18(BP), DX
		IMULQ	DX
		ADDQ	AX, sum+-40(SP)
		MOVWQSX	(BX), DX
		MOVBQZX	10(SI)(DX*1), AX
		MOVWQSX	20(BP), DX
		IMULQ	DX
		ADDQ	AX, sum+-40(SP)
		MOVWQSX	(BX), DX
		MOVBQZX	11(SI)(DX*1), AX
		MOVWQSX	22(BP), DX
		IMULQ	DX
		ADDQ	$24, BP
		ADDQ	sum+-40(SP), AX
		ADDQ	$8192, AX
		CMOVQLT	zero_0<>(SB), AX
		SHRQ	$14, AX
		CMPQ	u8max_2<>(SB), AX
		CMOVQLT	u8max_2<>(SB), AX
		ADDQ	$2, BX
		MOVB	AL, (DI)
		ADDQ	$1, DI
		SUBQ	$1, CX
		JNE	asmloop_22
end_24:
		MOVQ	srcref+-24(SP), SI
		ADDQ	dstoff+-32(SP), DI
		ADDQ	sp+128(FP), SI
		MOVQ	SI, srcref+-24(SP)
		SUBQ	$1, height+112(FP)
		JNE	yloop_20
		RET

TEXT ·h8scaleNAmd64(SB),4,$64-136
		MOVQ	dp+120(FP), BX
		MOVQ	width+104(FP), CX
		MOVQ	CX, DX
		SUBQ	CX, BX
		SHRQ	$4, CX
		ANDQ	$15, DX
		MOVQ	BX, dstoff+-32(SP)
		MOVQ	CX, simdroll+-8(SP)
		MOVQ	DX, asmroll+-16(SP)
		MOVQ	src+24(FP), AX
		MOVQ	AX, srcref+-24(SP)
		MOVQ	taps+96(FP), DX
		SUBQ	$2, DX
		MOVQ	DX, inner+-64(SP)
		PXOR	X15, X15
		MOVO	hbits_1<>(SB), X14
		MOVQ	src+24(FP), SI
		MOVQ	dst+0(FP), DI
yloop_25:
		MOVQ	off+72(FP), BX
		MOVQ	cof+48(FP), BP
		MOVQ	simdroll+-8(SP), CX
		ORQ	CX, CX
		JE	nosimdloop_28
simdloop_26:
		MOVWQSX	(BX), R8
		MOVWQSX	2(BX), R9
		MOVWQSX	4(BX), R10
		MOVWQSX	6(BX), R11
		PINSRW	$0, (SI)(R8*1), X0
		PINSRW	$1, (SI)(R9*1), X0
		PINSRW	$2, (SI)(R10*1), X0
		PINSRW	$3, (SI)(R11*1), X0
		MOVWQSX	8(BX), R8
		MOVWQSX	10(BX), R9
		MOVWQSX	12(BX), R10
		MOVWQSX	14(BX), R11
		PINSRW	$0, (SI)(R8*1), X1
		PINSRW	$1, (SI)(R9*1), X1
		PINSRW	$2, (SI)(R10*1), X1
		PINSRW	$3, (SI)(R11*1), X1
		MOVWQSX	16(BX), R8
		MOVWQSX	18(BX), R9
		MOVWQSX	20(BX), R10
		MOVWQSX	22(BX), R11
		PINSRW	$0, (SI)(R8*1), X2
		PINSRW	$1, (SI)(R9*1), X2
		PINSRW	$2, (SI)(R10*1), X2
		PINSRW	$3, (SI)(R11*1), X2
		MOVWQSX	24(BX), R8
		MOVWQSX	26(BX), R9
		MOVWQSX	28(BX), R10
		MOVWQSX	30(BX), R11
		PINSRW	$0, (SI)(R8*1), X3
		PINSRW	$1, (SI)(R9*1), X3
		PINSRW	$2, (SI)(R10*1), X3
		PINSRW	$3, (SI)(R11*1), X3
		ADDQ	$2, SI
		PUNPCKLBW	X15, X0
		PMADDWL	(BP), X0
		PUNPCKLBW	X15, X1
		PMADDWL	16(BP), X1
		PUNPCKLBW	X15, X2
		PMADDWL	32(BP), X2
		PUNPCKLBW	X15, X3
		PMADDWL	48(BP), X3
		ADDQ	$64, BP
		MOVQ	DI, dstref+-48(SP)
		MOVQ	inner+-64(SP), DI
loop_30:
		MOVWQSX	(BX), R8
		MOVWQSX	2(BX), R9
		MOVWQSX	4(BX), R10
		MOVWQSX	6(BX), R11
		PINSRW	$0, (SI)(R8*1), X4
		PINSRW	$1, (SI)(R9*1), X4
		PINSRW	$2, (SI)(R10*1), X4
		PINSRW	$3, (SI)(R11*1), X4
		MOVWQSX	8(BX), R8
		MOVWQSX	10(BX), R9
		MOVWQSX	12(BX), R10
		MOVWQSX	14(BX), R11
		PINSRW	$0, (SI)(R8*1), X5
		PINSRW	$1, (SI)(R9*1), X5
		PINSRW	$2, (SI)(R10*1), X5
		PINSRW	$3, (SI)(R11*1), X5
		MOVWQSX	16(BX), R8
		MOVWQSX	18(BX), R9
		MOVWQSX	20(BX), R10
		MOVWQSX	22(BX), R11
		PINSRW	$0, (SI)(R8*1), X6
		PINSRW	$1, (SI)(R9*1), X6
		PINSRW	$2, (SI)(R10*1), X6
		PINSRW	$3, (SI)(R11*1), X6
		MOVWQSX	24(BX), R8
		MOVWQSX	26(BX), R9
		MOVWQSX	28(BX), R10
		MOVWQSX	30(BX), R11
		PINSRW	$0, (SI)(R8*1), X7
		PINSRW	$1, (SI)(R9*1), X7
		PINSRW	$2, (SI)(R10*1), X7
		PINSRW	$3, (SI)(R11*1), X7
		ADDQ	$2, SI
		PUNPCKLBW	X15, X4
		PMADDWL	(BP), X4
		PUNPCKLBW	X15, X5
		PMADDWL	16(BP), X5
		PUNPCKLBW	X15, X6
		PMADDWL	32(BP), X6
		PUNPCKLBW	X15, X7
		PMADDWL	48(BP), X7
		ADDQ	$64, BP
		PADDL	X4, X0
		PADDL	X5, X1
		PADDL	X6, X2
		PADDL	X7, X3
		SUBQ	$2, DI
		JNE	loop_30
		MOVQ	dstref+-48(SP), DI
		MOVQ	taps+96(FP), AX
		SUBQ	AX, SI
		ADDQ	$32, BX
		PADDL	X14, X0
		PADDL	X14, X1
		PADDL	X14, X2
		PADDL	X14, X3
		PSRAL	$14, X0
		PSRAL	$14, X1
		PSRAL	$14, X2
		PSRAL	$14, X3
		PACKSSLW	X1, X0
		PACKSSLW	X3, X2
		PACKUSWB	X2, X0
		MOVOU	X0, (DI)
		ADDQ	$16, DI
		SUBQ	$1, CX
		JNE	simdloop_26
nosimdloop_28:
		MOVQ	asmroll+-16(SP), CX
		ORQ	CX, CX
		JE	end_29
asmloop_27:
		MOVWQSX	(BX), DX
		MOVBQZX	(SI)(DX*1), AX
		MOVWQSX	(BP), DX
		IMULQ	DX
		MOVQ	AX, sum+-40(SP)
		MOVQ	inner+-64(SP), AX
		MOVQ	AX, count+-56(SP)
loop_31:
		MOVWQSX	(BX), DX
		MOVBQZX	1(SI)(DX*1), AX
		MOVWQSX	2(BP), DX
		IMULQ	DX
		ADDQ	$1, SI
		ADDQ	$2, BP
		ADDQ	AX, sum+-40(SP)
		SUBQ	$1, count+-56(SP)
		JNE	loop_31
		MOVWQSX	(BX), DX
		MOVBQZX	1(SI)(DX*1), AX
		MOVWQSX	2(BP), DX
		IMULQ	DX
		ADDQ	$4, BP
		SUBQ	inner+-64(SP), SI
		ADDQ	sum+-40(SP), AX
		ADDQ	$8192, AX
		CMOVQLT	zero_0<>(SB), AX
		SHRQ	$14, AX
		CMPQ	u8max_2<>(SB), AX
		CMOVQLT	u8max_2<>(SB), AX
		ADDQ	$2, BX
		MOVB	AL, (DI)
		ADDQ	$1, DI
		SUBQ	$1, CX
		JNE	asmloop_27
end_29:
		MOVQ	srcref+-24(SP), SI
		ADDQ	dstoff+-32(SP), DI
		ADDQ	sp+128(FP), SI
		MOVQ	SI, srcref+-24(SP)
		SUBQ	$1, height+112(FP)
		JNE	yloop_25
		RET
