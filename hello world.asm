	DEVICE ZXSPECTRUM48 			; needed for SNA export (must be tab indented)
	org $8000
	
	INCLUDE "speccy_defs.asm"		; must be indented
	

START:
	ld		a, COL_BLU				; blue in a
	call	ROM_BORDER				; sets border to val in a
	call	ROM_CLS					; so AT works, not just print at bottom of screen
	ld 		bc, MY_STRING

MY_LOOP:
	ld 		a, (bc)					; load char from MY_STRING to a
	cp 		255						; check for 255 terminator
	jr 		z, UDG			; end if we're done
	rst 	$10						; ROM print the char (and move cursor)
	inc 	bc						; next char in string
	jr 		MY_LOOP					; iterate


UDG: 								; just proving I can change UDGs each time I print
	ld		a, C_UDG_1
	rst		$10
	
	ld		b, 7
	ld		HL, UDG_START
	ld		(HL), $77
	inc		HL
	ld		(HL), $77
	inc		HL
	ld		(HL), $77
	inc		HL
	ld		(HL), $77
	inc		HL
	ld		(HL), $77
	inc		HL
	ld		(HL), $77
	inc		HL
	ld		(HL), $77
	inc		HL
	ld		(HL), $77

	ld		a, C_UDG_1
	rst		$10

END_PROGRAM:
	ld		a, COL_GRN				; random border shit depending on timings...
	call	ROM_BORDER
	nop
	ld		a, COL_RED
	call	ROM_BORDER
	jr		END_PROGRAM
	ret								; return to BASIC 
									; except unless we Enabe Interrupts (EI) it won't :)

MY_STRING:
	defb 	"Top"			
	defb 	C_AT, 11, 10, COL_C_INK, COL_RED	
	defb 	"Hello World!"			
	defb 	C_AT, 21, 0, COL_C_INK, COL_BLK	
	defb 	"Bottom"			
	defb 	C_AT, 5, 0
	defb 	255				
  
  
; Deployment: Snapshot
   SAVESNA 	"hello world.sna", START
   