	DEVICE ZXSPECTRUM48 			; needed for SNA export (must be tab indented)
	org $8000
	
	
; character codes (must be left-aligned)	
C_ENTER		= $0D
C_AT		= $16

; colours
COL_BLK		= $0
COL_BLU		= $1
COL_RED		= $2
COL_MAG		= $3
COL_GRN		= $4
COL_CYN		= $5
COL_YEL		= $6
COL_WHT		= $7
COL_C_INK	= $10
COL_C_PAP	= $11
COL_C_FLA	= $12
COL_C_BRI	= $13

; ROM calls
ROM_CLS		= $0DAF					; cls and open Channel 2 
ROM_BORDER	= $229B					; set border to value in a

START:
	ld		a, COL_BLU				; blue in a
	call	ROM_BORDER				; sets border to val in a
	call	ROM_CLS					; so AT works, not just print at bottom of screen
	ld 		bc, MY_STRING

MY_LOOP:
	ld 		a, (bc)					; load char from MY_STRING to a
	cp 		255						; check for 255 terminator
	jr 		z, END_PROGRAM			; end if we're done
	rst 	$10						; ROM print the char (and move cursor)
	inc 	bc						; next char in string
	jr 		MY_LOOP					; iterate

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
	defb 	255				
  
  
; Deployment: Snapshot
   SAVESNA 	"hello world.sna", START
   