; DEVICE       = uPD78F9222

;------------------------------------------------
;-      		MACRO   DEFINITION      		-
;------------------------------------------------
PUSH_STACK      MACRO
                PUSH    AX
                ;;;PUSH    HL
                ;;;PUSH    BC                                                                      
                ;;PUSH    DE
                ENDM
                
POP_STACK       MACRO
                ;;;POP     DE
               ;;; POP     BC
               ;; POP     HL
                POP     AX
                ENDM     

;------------------------------------------------
;-      		I/O DEFINE              		-
;------------------------------------------------
LED_CALC	    EQU		P4.1  ;;;P2.0
LED_CALC_C	    EQU		PM4.1 ;;;PM2.0
LED_AUTO        EQU		P2.0  ;;;P4.1
LED_AUTO_C      EQU		PM2.0 ;;;PM4.1
LED_CUP         EQU		P4.0
LED_CUP_C       EQU		PM4.0

HEAT_MAIN       EQU		P4.2
;------------------------------------------------
;-      		SYMBOL  DECLARATION    		 	-
;------------------------------------------------
RAM_START	    EQU	    0FE80H		; 0FE20H
RAM_END		    EQU  	0FF00H
STACK		    EQU	    0FEFFH 
WriteAdr        EQU	    00D01H
WR_TIME_DR      EQU	    00E00H 
WR_EEOR_LED     EQU	    00DFDH 
WR_EEOR_TIM     EQU	    00E03H
;;;;DISP_START	    EQU	    0FEE0H
;;;;KEY_START	    EQU	    0FF00H
;------------------------------------------------
;-      		RAM  DECLARATION       			-
;------------------------------------------------
DATA	DSEG	AT	0FE80H 
  
TIMER2MS:		   DS		1
TIMER4MS:          DS		1
TIMER10MS:		   DS		1
TIMER100MS:		   DS		1
TIMER500MS:		   DS		1
TIMER1MIN:		   DS		1			

NOKEY_COUNT:	   DS		1;;;10

FLAG1:			  DS		1
F_2048US		  EQU		FLAG1.0
F_2MS			  EQU		FLAG1.1
F_4MS             EQU		FLAG1.2
F_TIME_DO         EQU		FLAG1.3
F_10MS            EQU		FLAG1.4
F_100MS           EQU		FLAG1.5
F_500MS           EQU		FLAG1.6
F_1MS             EQU		FLAG1.7

FLAG2:			  DS		1;;;;16
F_WORK            EQU		FLAG2.4
F_KEYCLOSE        EQU		FLAG2.5
F_HALF            EQU		FLAG2.6;;;;HALF  FLASH


FLAG3:			  DS		1;;;;17
F_KEY_2MS         EQU       FLAG3.0
F_KEY_100MS       EQU       FLAG3.1
F_KEYSTART        EQU       FLAG3.2
F_SINGAL_BEFORE   EQU       FLAG3.3;;;ONE  
F_NEXT_HIGHT      EQU       FLAG3.4;;;XIA CI  XUYAO 
F_START_DO        EQU       FLAG3.5;;;FIRTST  START
KEY_START_CLOSE   EQU       FLAG3.6
F_WAIT100MS       EQU       FLAG3.7


FLAG4:             DS		1
F_CUP_HIG          EQU      FLAG4.0;;;;;;;
F_CUP_BEFORE       EQU      FLAG4.1;;;;;;;
F_CUP_4MS          EQU      FLAG4.2
F_CUP_ABLE         EQU      FLAG4.3
F_TEM_4MS          EQU      FLAG4.4
F_IN2              EQU      FLAG4.5
F_KEEP_TEMP        EQU      FLAG4.6
F_AD_4MS           EQU      FLAG4.7

TIME_KEY_ADD:      DS		1;;;;34
YEA_COUNT:         DS		1;;;;;;;;3  degree
KEY_1S:            DS		1
KEY_500MS:         DS		1
WAIT_500MS:        DS		1
CUP_TIME:          DS		1

TEMP_TIMER50MS:    DS       1

FLAG5:			   DS		1;;;;43
F_CALC_500MS       EQU      FLAG5.0
;;;;F_KEY_OFF          EQU      FLAG5.1;;;;;;POWER  DOWN
F_KEY_SHORT        EQU      FLAG5.2
F_IN2_OFF          EQU      FLAG5.3
;;;F_MODE_HEAT        EQU      FLAG5.4
;;;;F_MODE_KEEP        EQU      FLAG5.5
F_WAIT_TIME        EQU      FLAG5.6
F_KEEP_500MS       EQU      FLAG5.7

HEAT_PWN:          DS		1;
DO_HEAT_PWM:       DS		1;
SEND_PWM_8:        DS		1;
CUP_SMALL_TIME:    DS		1
CUP_BIG_TIME:      DS		1

HEAT_PWN_2MS:      DS		1

;;;;=======KEEP_TIME
KEEP_SECOND:       DS		1;;;50
KEEP_MIN:          DS		1;;;;51
KEEP_HOUR:         DS		1

FLAG6:			   DS		1;;;;
;;;      EQU      FLAG6.0;;prog use  time
F_MIN_ADD100MS     EQU      FLAG6.1
F_PROG_100MS       EQU      FLAG6.2
;;---------------------------------
;;;F_PROG_DO          EQU      FLAG6.3;;prog  KEY
;;;;F_REAL_PROMODLE    EQU      FLAG6.4;;REAL  PRO  MODE   
F_LED_100MS        EQU      FLAG6.5

F_PROLED_1S        EQU      FLAG6.6;;SHOW  PORO KEY  1S
F_LED_CALC         EQU      FLAG6.7;;;LED  SHOW   CALC
;;---------------------------------

LED_TIME_HEAT:     DS		1

TIME_CALC_H:	   DS		1;;;;
TIME_CALC_L:	   DS		1;;;;

FLAG7:			   DS		1
F_CUP_500MS        EQU      FLAG7.0
F_CALC_ADD         EQU      FLAG7.1
F_KEY_ALLOFF       EQU      FLAG7.2
F_100MS_TEM        EQU      FLAG7.4
F_HHHHHH           EQU      FLAG7.3
;;;;F_FRIST_POW        EQU      FLAG7.5
F_RETURN_POW       EQU      FLAG7.6
F_LED_TIME         EQU      FLAG7.7

;;;;;-------------------------------------------
FLAG8:			   DS		1
F_CHECK_B          EQU      FLAG8.0
F_CHECK_ERROR      EQU      FLAG8.1
F_NEED_BLANK       EQU      FLAG8.2
F_FINISH_ADD       EQU      FLAG8.3
F_CALC_100MS       EQU      FLAG8.4

F_TIME_CALC        EQU      FLAG8.5
F_TWO_NEED         EQU      FLAG8.6
F_KEY4_DO          EQU      FLAG8.7								;p4.7 long press 2seconds
;---------------------------------------------


INT_MK0:           DS		1;;;64
REA_MEED_DATA:     DS		1;;;66;;;;FEC2H
ERROR_COUNT:       DS		1
COUNT_OFFH:        DS		1
CHECK_COUNT:       DS		1
NUMBER_FLASH:      DS		1;;;;70
WRITE_RETRY        EQU      (10);Retry count for write
ERASE_RETRY        EQU      (20);Retry count for erasure
FLASH_COUNT        EQU      (100);Retry count for erasure*********250********
TIME_BLO_NUMB      EQU      (14)
LED_BLO_NUMB       EQU      (13)

BLOCK_REAL_DO:     DS		1;;;

FLAG9:			   DS		1
F_TI_EASE_NEED     EQU      FLAG9.1    
F_TI_EASE_B        EQU      FLAG9.2
F_OVER_CALC_TIME   EQU      FLAG9.3
F_Blank_ERASE_DO   EQU      FLAG9.4

MODE_SAVE:         DS		1
DATA_CHANGE:       DS		1
FLAG10:			   DS		1
F_MODE_KEEP        EQU      FLAG10.3
F_MODE_HEAT        EQU      FLAG10.4
F_MODE_CALC        EQU      FLAG10.5
F_500MS_CAL        EQU      FLAG10.6
F_CALC_HEAT        EQU      FLAG10.7

FLAG11:			   DS		1
F_NO_SHOW          EQU      FLAG11.0

HEAT_CALC:         DS		1
NOHE_CALC:         DS		1
SAVE_HEAT_CALC:    DS		1
SAVE_NOHE_CALC:    DS		1

FLAG12:			   DS		1
POWER_FIRST        EQU      FLAG12.1
F_INT_MK           EQU      FLAG12.2										; finish initialize, set 1,else set 0

FLAG13:			   DS		1
DO_LED_OFF         EQU      FLAG13.1
DO_FUNTION_OFF     EQU      FLAG13.2
F_PTC_FRIST        EQU      FLAG13.3;;;;;*********()
F_POWER_ON         EQU      FLAG13.4
F_4MS_POW        EQU      FLAG13.5											;zero test power 
F_POWER_DONE       EQU      FLAG13.6										;Power effect,zero test
F_HEAT_FRIST       EQU      FLAG13.7


FLAG14:			   DS		1
F_4MS_CALC         EQU      FLAG14.0;;;;;;;;;;;;;;(*********)
F_ONOF_CHANGE      EQU      FLAG14.1;;;;;;;;;;;;;;(*********)

FLAG15:			   DS		1
F_LIG_CALC         EQU      FLAG15.0;;;;;;;;;;;;;;(*********)

CALC_S_COUN:	   DS		1

HEAT_LED_TIME:     DS		1

PTC_DELAY_3:       DS		1

TEMP_POW50MS:      DS		1																;50ms test zero 
;;;;;-------------------------------------------
;;;NEW
CUP_SAT_DELAY:     DS		1

FLAG16:			   DS		1
CUP_WAIT_100MS     EQU      FLAG16.0
F_DEL_END          EQU      FLAG16.1
F_SATRT_F          EQU      FLAG16.2
F_WOR_F            EQU      FLAG16.3;;;;;;;WORK_CHANGE_END
F_AUTO_LED         EQU      FLAG16.4

FLAG17:			   DS		1											;zero test
F_POWR_1MS         EQU      FLAG17.0			; zero test  time
F_POWR_HIG         EQU      FLAG17.1			; zero level flag

POWR_TI_COUN:	   DS		1    								;zero edge  counter  

;;;;----------------------------------------
FLAG21:			   DS		1
F_start_frist      EQU      FLAG21.0
F_nokey_frist      EQU      FLAG21.1
F_DELAY_4MS        EQU      FLAG21.2
F_DELAY_OK         EQU      FLAG21.3
F_TEST_DO          EQU      FLAG21.4
F_NO_TEST          EQU      FLAG21.5
F_SHOW_DELAY       EQU      FLAG21.6

POW_DELAY_COU:     DS		1													;power on delay,4ms*20=80ms

NO_KEY_COU:        DS		1
SHOW_DEL_COU:      DS		1
TEST_SELECT:       DS		1  
TEST_SEC:          DS		1    

FLAG22:            DS		1
F_KEYCLOSE1        EQU      FLAG22.0


FLAG23:			   DS		1        
F_CA_100MS         EQU      FLAG23.0
F_FIN_CALC         EQU      FLAG23.1
F_CALC_FLAS        EQU      FLAG23.2
F_CALC_TWO         EQU      FLAG23.3
F_CALC_100_2       EQU      FLAG23.4

CALC_KEY_COUN:	   DS		1

CALC_LED_COU:	   DS		1

DATA_CLOSE_10:	   DS		1  
DATA_CLOSE_11:	   DS		1  

FLAG24:			   DS		1     
F_CLOSE_100MS      EQU      FLAG24.0
F_START_FIR        EQU      FLAG24.1
F_TEMP_H           EQU      FLAG24.2
F_NEED_WAIT        EQU      FLAG24.3
F_CLSE_4MS         EQU      FLAG24.4

;;*
FLAG25:            DS		1        ;;;;;;;;;2010.09.11....**
F_DELAY_4S         EQU      FLAG25.0 ;;;;;;;;;2010.09.11....**
F_T4S_100MS        EQU      FLAG25.1 ;;;;;;;;;2010.09.11....**
F_20S_100MS        EQU      FLAG25.2 ;;;;;;;;;2010.09.11
F_NEED_20S         EQU      FLAG25.3 ;;;;;;;;;2010.09.11
F_FCLOSE_4MS       EQU      FLAG25.4 ;;;;;;;;;2010.09.11
F_FOPEN_4MS        EQU      FLAG25.5 ;;;;;;;;;2010.09.11
F_WAIT_CLEAR       EQU      FLAG25.6 ;;;;;;;;;2010.09.11....**
F_CALC_500C        EQU      FLAG25.7 ;;;;;;;;;2010.09.11....**

DELAY_4SCOU:	   DS		1;;;;;....**
DELAY_CALC_COU:	   DS		1;;;;;....**    


DELAY_20SCOU:	   DS		1

RE_CLOSE_COU:	   DS		1
RE_OPEN_COU:	   DS		1

T20S_RENEW_COU:	   DS		1    

FLAG26:            DS		1        ;;;;;;;;;2010.09.11....**
F_ALR_M_DO         EQU      FLAG26.0 ;;;;;;;;;2010.09.11....**
F_NEED_MENY        EQU      FLAG26.1 ;;;;;;;;;2010.09.29....**


;;;;;==============================================================================================
;code;

;; 				VECTOR TABLE                 	-
;;;;===============================================================================================
INT0		CSEG	AT		0000H
			DW		START
			
INT11		CSEG	AT		000CH
INTTH1:	    DW		INTTMH1

INT12		CSEG	AT		000AH
INTP2:		DW		INT_NC

;------------------------------------------------
OPT     	CSEG	AT	80H		
OPTION:     DB	    10011100B;;;;
        				
PROG		CSEG	AT  82H

;------------------------------------------------

;=====================================================================================================
START:
         DI  
         CLR1        F_INT_MK
         
START_WAIT_TIME:   
         NOP
         NOP
         NOP
         NOP
         NOP
         NOP
         
         NOP
         NOP
         NOP
         NOP
         NOP
         NOP
         CLR1       F_INT_MK
         MOV		WDTM, #01110111B
         
         
START_OFF_RETURN:

		 
RAM_INIT:   
	    MOVW	AX,   #STACK
	    MOVW	SP,   AX
	    MOVW	HL,   #RAM_START
		
RAM_CLEAR:
	    MOV     A,#0
	    MOV     [HL],A
	   	INCW    HL
	    MOVW    AX,HL
	    CMPW	AX,#RAM_END
	    BC      $RAM_CLEAR	
	    
	    
	    ;;;;BR      !SYS_INIT;;;;;;;;;;;;;;---------------
;-- ------------------------------------------------------------------------------------------------
        MOV       MK0,#0FFH						;disable interrupt routine
          
        CALL      !CHECK_TIME_CALC
        
        
;;;;;-----------------------------------------------------------------------------------------------
	    
        CALL       !ModeOn  
Flash_Blank_Check:
         MOV       BLOCK_REAL_DO,#LED_BLO_NUMB    ;;;;(13)
         CALL      !FlashBlockBlankCheck
          
         CLR1       F_NEED_BLANK;;;;;;;;NEED ERASE   
         BF         F_CHECK_B,$CHE_CALC_BEEN
             
FLASH_BLANK:

         MOV        REA_MEED_DATA,#0
         CLR1       F_LED_CALC;;;;
         CLR1       F_NEED_BLANK
         
         MOV        CHECK_COUNT,#0;;;****
         
         BR         !SYS_INIT
         
         
CHE_CALC_BEEN:
         MOVW       DE,#0DFDH
         MOV        A,[DE]
         CMP        A,#0
         
         CLR1       F_LED_CALC
         BZ         $EEOR_LED_LOOP
         
         INCW       DE
         MOV        A,[DE]
         CMP        A,#0
         
         CLR1       F_LED_CALC
         BZ         $EEOR_LED_LOOP
;;;;;;----------------------------------------
         MOVW       DE,#0DFFH
         MOV        A,[DE]
         CMP        A,#0AAH
         BZ         $CALC_IS_HAPPEN
         
CHECK_LOOP:         
         MOVW       DE,#WriteAdr;;;;;;;FRIST  CHECK
         
         MOV        A,#0
         MOV        REA_MEED_DATA,A
         MOV        CHECK_COUNT,A
         MOV        NUMBER_FLASH,A;;;FLASH  SAVE  NUMBER
         
         MOV        ERROR_COUNT,A
         MOV        COUNT_OFFH,A
                  
         BR         $CHECK_LOOP1
         
CHECK_LOOP2:

         INC        E
         
CHECK_LOOP1:
         MOV        A,E
         MOV        CHECK_COUNT,A
         MOV        A,[DE]
         MOV        NUMBER_FLASH,A
         CMP        A,CHECK_COUNT
         BNZ        $CHECK_NOSAME
         
         CLR1       F_CHECK_ERROR;;;;;;ERROR  FOLLOW
         
         MOV        A,CHECK_COUNT
         MOV        REA_MEED_DATA,A
         
         CMP        A,#FLASH_COUNT;;;;;#250D
         BC         $CHECK_LOOP2
         
CALC_IS_HAPPEN:
         SET1       F_LED_CALC;;;;;;;;;;;ALL FLAG  FLASH;;>=249
         CLR1       F_CHECK_B
         MOV        REA_MEED_DATA,#FLASH_COUNT;;;;;#250D
         CLR1       F_NEED_BLANK

         BR         $SYS_INIT
         
         
CHECK_NOSAME:
         MOV        A,NUMBER_FLASH
         CMP        A,#0FFH
         BNZ        $CHECK_EEOR
         
CHECK_SAME: 

         INC        COUNT_OFFH
         CMP        COUNT_OFFH,#3
         BC         $CHECK_LOOP2;;;;;;SAME  AND  RECHECK
         
         CLR1       F_LED_CALC;;;;;;;;;;;ALL FLAG  FLASH;;>=249
         CLR1       F_CHECK_B
         CLR1       F_NEED_BLANK
         
         BR         $SYS_INIT
         
CHECK_EEOR:

         MOV        A,CHECK_COUNT
         MOV        REA_MEED_DATA,A
         
         CMP        A,#FLASH_COUNT;;;;;#250D
         BNC        $CALC_IS_HAPPEN
         
         
         MOV        COUNT_OFFH,#0;;;;;ERROR  CLEAR  FF   COUNT

         BF         F_CHECK_ERROR,$CHECK_EEOR_FRIST
         INC        ERROR_COUNT
         CMP        ERROR_COUNT,#4
         BC         $CHECK_LOOP2;;;;;;SAME  AND  RECHECK
         
         
EEOR_LED_LOOP:
         SET1       F_NEED_BLANK;;;;;;;;NEED ERASE
         CLR1       F_CHECK_B
         
         CALL       !ModeOn
         CALL       !FlashBlockErase
         
         MOV        REA_MEED_DATA,#0
         CLR1       F_LED_CALC;;;;
         
         BR         $SYS_INIT
         
         
CHECK_EEOR_FRIST:
         MOV        ERROR_COUNT,#1
         SET1       F_CHECK_ERROR;;;;;;ERROR  FOLLOW
         BR         !CHECK_LOOP2
;;===================================================================	    
SYS_INIT:
        CALL    !ModeOff
        SET1    F_INT_MK

        MOV     LVIM,#10000011B
        MOV     LVIS,#00000110B;;3.1V

        MOV     A,#0
		MOV 	PCC, A        
		MOV     PPCC,A
		MOV     IF0, A       
	    
	    MOV		OSTS,A     
	    MOV		INTM0,A     													;out interrupt   affect when falling adge comes
	    MOV     ADM,A																;stop ADC
	    MOV     PU2,A
	    ;;;MOV		P3,A
	    
	    
	    
	    MOV	    MK0, #0FFH           
	    MOV  	LSRCM, #01H      
	    MOV     ADM,#0;;;;;;****
	    MOV     PU2,#0
		MOV		P2,   #00001001B     
		MOV		PM2, #00001111B	   
		MOV		PMC2,#00000000B  
		;;;MOV		P3,  #00000000B			
		;;;MOV		PM3, #11111111B	
		
		MOV     PU4,#10001000B
		MOV		P4,  #11001100B	
		MOV		PM4, #11111100B
		
TIME_H80_INIT:                             
        
        MOV		 TMHMD1,#00110000B				
        MOV		 CMP01,#7CH;;;; #7CH;;;;125D
        
        SET1	 TMHE1
        
        CLR1	 TMIFH1
        CLR1	 TMMKH1
        
        ;;;;MOV      TIME_SECOND,#0;;;;;TIME
		
		CLR1     F_START_DO 
        MOV      TIME_KEY_ADD,#0;;;;;34MS
        MOV      KEY_1S,#0      
		
		CLR1     F_CUP_ABLE  
		SET1     F_CUP_HIG
		
        CLR1     F_start_frist;;;;;;;;;NEQW
        CLR1     F_nokey_frist;;;;;;;;;NEQW
        CLR1     F_TEST_DO;;;;;;;;;NEQW
        CLR1     F_TEST_DO;;;;;;;;;NEQW
        SET1     F_NO_TEST
		
TMH1INIT2:													;out interrupt.test them
        SET1     PM3.2
        CLR1     PU3.2
        MOV      INTM0,#00110000B;;;;;;  double edge
        SET1     PMK1
	    	                                      
WAIT_TIME_LOOP:
        NOP
        DI
        BF      TMIFH1,$WAIT_TIME_LOOP
        
        
		EI
              
;================================================================================================main loop
MAIN_1:
        CALL     !TIME
        CALL     !MAIN_LOOP

        BT        POWER_FIRST,$MAIN_TEST   ;if POWER_FIRST==0,just loop back main1
        
        CALL     !MAIN_INIT
        CALL     !TEST_DELAY
        
        BF       F_DELAY_OK,$MAIN_1
        CALL     !KEY
        BR       !MAIN_1
 
 ;===============================================================================================       
MAIN_TEST:
        CALL     !TEST_LOOP
        
MAIN_2:

        CALL     !MAIN_LOOP
        CALL     !CALC_LED
		CALL	 !TIME							
		CALL	 !KEY	
		CALL     !CUP_BIG
;;;;;;==========================
        CALL     !KEY_TEMP
;;;;;;==========================KEY HEAT  OR  OFF
        CALL     !POWER_WORK_ON			
		CALL     !KEY_HEAT_OFF	
		CALL     !DO_START
		BF       F_RETURN_POW,$MAIN_LOOP2
		BT       KEY_START_CLOSE,$MAIN_LOOP2

		BR       !START_OFF_RETURN
		
MAIN_LOOP2:		
        CALL	 !TIME
        CALL     !HEAT_PWM_OFF;;;;;PWM USE  
;;;;;;==========================
        CALL     !KEEP_TIME_COUNT
;;;;;;==========================
        CALL     !CUP_WORK_TIME
;;;;;;==========================
        CALL     !CALC_ADD
        CALL     !CLEAR_CALC_DO
;;;;;;==========================
		BR		 !MAIN_2
		
;===================================================================================================
;enable TMH1 and INTP1, end self program
MAIN_LOOP: 
        CLR1	  TMMKH1												;enable TMH1
        CLR1      PMK1												;enable	INTP1,
        MOV       INT_MK0,#11100111B
        
		MOV       WDTE,#0ACH	                      
		NOP
		
		MOV       A,FLPMC
		MOV       MODE_SAVE,A
		BF        MODE_SAVE.0,$MAIN_L_RETURN
		
		CALL      !ModeOff
MAIN_L_RETURN:
		RET
;;;=================================================================================================

MAIN_INIT:;;;;;;OPEN   POWER
		MOV      WDTE,#0ACH	                      
        
        CALL     !POWER_WORK_ON
        CALL     !TIME
        CALL     !KEY_HEAT_OFF;;;;CALL     !KEY_START;;;;FRIST KEY;;;;;
        
        
        BT       F_START_DO,$MAIN_INIT_LOOP
        RET
        
MAIN_INIT_LOOP:
        SET1     POWER_FIRST;;;**/
        CLR1     F_WAIT_TIME;;;**/
        
        SET1     F_KEYSTART
        CLR1     F_START_DO
        
        CLR1     PM4.6														;;;;;;;POWER
        CLR1     P4.6															;;open machine
        
        
        CLR1     F_TIME_DO
        
        CLR1     LED_AUTO
        CLR1     LED_AUTO_C 
        
        
        RET
              
;==========================================================
TEST_DELAY:
        BT       F_DELAY_OK,$TEST_DELAY_OUT
        
        BF       F_DELAY_4MS,$TEST_DELAY_OUT
        CLR1     F_DELAY_4MS
        
        MOV      NO_KEY_COU,#0
        INC      POW_DELAY_COU
		CMP		 POW_DELAY_COU,#20D		
		BC		 $TEST_DELAY_OUT
		MOV		 POW_DELAY_COU,#0
		SET1     F_DELAY_OK
		
TEST_DELAY_OUT:
		RET
		
		
TEST_NO_OUT:
        RET
        
;;====================================================

TEST_LOOP:
        BF       F_start_frist,$TEST_NO_OUT
        BF       F_KEYCLOSE,$TEST_NO_OUT
        
        CLR1     F_SHOW_DELAY 
        MOV      TEST_SELECT,#0
        
TEST_WORK: 
        CALL     !TIME
        CLR1     F_HALF
        
        CALL     !SHOW_DELAY
        
        BF       F_SHOW_DELAY,$TEST_CHANGE
        CLR1     F_SHOW_DELAY
        INC      TEST_SELECT
        
        
TEST_CHANGE:
        CMP      TEST_SELECT,#0
        BZ       $TEST1
        
        CMP      TEST_SELECT,#1
        BZ       $TEST2
        
        CMP      TEST_SELECT,#2
        BZ       $TEST3
        
        CMP      TEST_SELECT,#3
        BZ       $TEST4
        
        
TEST1:
        MOV      TEST_SELECT,#0
        
        CLR1     F_KEY4_DO
        CLR1     LED_CALC_C	 
        SET1     LED_CALC         
        CLR1     LED_AUTO_C 
        SET1     LED_AUTO          
        CLR1     LED_CUP_C    
        SET1     LED_CUP
        BR       !TEST_WORK
        
TEST2:
        CLR1     LED_CALC	  
        SET1     LED_CALC_C	  
        CLR1     LED_AUTO      
        SET1     LED_AUTO_C     
        CLR1     LED_CUP         
        SET1     LED_CUP_C      
        
        CLR1     PM4.2
        CLR1     P4.2
        
        BR       !TEST_WORK
        
TEST3:
        SET1     P4.2
        SET1     PM4.2

        BR       !TEST_WORK
        
TEST4:
        CLR1     F_KEY4_DO
        BR       !MAIN_2


;;;--------------------------------------------------
SHOW_DELAY:
        BF       F_DELAY_4MS,$TEST_KEY_OUT
        CLR1     F_DELAY_4MS
        
        INC      SHOW_DEL_COU
		CMP		 SHOW_DEL_COU,#250D		
		BC		 $TEST_KEY_OUT
		MOV		 SHOW_DEL_COU,#0
        SET1     F_SHOW_DELAY
        RET

TEST_KEY_OUT:
        RET
;====================================================	        
CHANGE_SIGNAL:
       SET1     PM2.1
       CLR1     PU2.1
       
SIGNAL_LOW:
       BT       P2.1,$KEY_START_OUT1
       
       INC      YEA_COUNT
	   CMP		YEA_COUNT,#3;;;;;#3		
	   BC		$KEY_START_OUT
	   
       ;;;;;;;;;SET1     F_IN2;;;;;;************************+++++++++++++++++++++
       ;;;;;;;;;SET1     F_IN2_OFF;;;;;;************************+++++++++++++++++++++

       CLR1     F_HEAT_FRIST;;;;;;************************+++++++++++++++++++++
	   
	   
	   CLR1     F_SINGAL_BEFORE
	   RET
;;;;(------------------------------------)       
KEY_START_OUT1:
       MOV     YEA_COUNT,#0
       SET1    F_SINGAL_BEFORE
             
KEY_START_OUT:
        
       RET
     
;;;;(------------------------------------)
WAIT_OPEN:;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;***********()
       SET1     PM2.1
       CLR1     PU2.1
       NOP
       BF       F_POWER_DONE,$NO_POWER_WAIT;;
              
       CALL     !CHANGE_SIGNAL
       
       INC      TIME_KEY_ADD
       
       CMP      TIME_KEY_ADD,#17D
       BC       $WAIT_LOOP1
       ;;;MOV      TIME_KEY_ADD,#0
WAIT_LOOP2:
       MOV      WAIT_500MS,#0
WAIT_LOOP:  ;;;;;34MS   NO   LOW  IS  KEY  ON  
       MOV      TIME_KEY_ADD,#0
       RET

WAIT_LOOP1:;;;;;;3CHI  NOKEY  IS  OPEN
       BT       F_SINGAL_BEFORE,$WAIT_OUT
       
       SET1     F_SINGAL_BEFORE

       INC      WAIT_500MS
	   CMP		WAIT_500MS,#2;;;20D;;;3*34(34MSZHONG YOU ONE LOW AND ALONG THREE)
	   BC	    $WAIT_LOOP

NO_POWER_WAIT:
	   MOV	    WAIT_500MS,#0
	   CLR1     KEY_START_CLOSE
	   BR       $WAIT_LOOP2
WAIT_OUT:
       RET
       
;------------------------------------------------
G_99:
       BT       F_POWER_DONE,$GG
       
G_8888:
       
       CLR1     F_WAIT_TIME
       CLR1     F_KEY_100MS
       MOV      KEY_500MS,#0
       RET 


;------------------------------------------------	        
KEY_HEAT_OFF:
       ;;;;;RET;;;;;;;;;;;;;;[[[[[[[[[[[[[[[[[[
       BF       F_KEY_2MS,$KEY_START_OUT
       CLR1     F_KEY_2MS
       
       
       BF       POWER_FIRST,$G_99;;;;******/
        
       BF       KEY_START_CLOSE,$GG
       BR       $WAIT_OPEN;;;;;;CLOSE  KEY  ELE
GG:
       BF       F_KEYSTART,$KEY_START_LOOP1
       
       CLR1     F_KEYSTART
       MOV      TIME_KEY_ADD,#0;;;;;26MS
       MOV      KEY_500MS,#0    
       
KEY_START_LOOP1:
       CALL     !CHANGE_SIGNAL
       
       BT       F_SINGAL_BEFORE,$KEY_COUNT_26
KKKK: 
       CLR1     F_WAIT_TIME
       CLR1     F_KEY_100MS
       MOV      KEY_500MS,#0
       RET 
       
KEY_COUNT_26:;;;;;;;34MS  ON  SIGNAL  1000MS  IS  DO
       BF       F_KEY_100MS,$KEY_START_OUT
       CLR1     F_KEY_100MS
       
       INC      KEY_500MS
	   CMP		KEY_500MS,#50D;;;;#5
	   BC	    $KEY_START_OUT
	   
	   MOV		KEY_500MS,#0
 	   SET1     KEY_START_CLOSE
	   
	   MOV		CUP_SAT_DELAY, #0
	   MOV      FLAG10,#0
	   MOV      TIME_KEY_ADD,#0
	   
	   BF       POWER_FIRST,$POWE_START_ON
;------------------------------------------------
KEY_POWER_OFF:
;;;;;***;;;//////////////////////////////////////
       CLR1     PM4.6											;;set out put 
	     SET1     P4.6											;;high level ,turn off the relay
	   
       CLR1     F_START_FIR;;;;NEW()
       CLR1     F_NEED_WAIT;;;;NEW()
       CLR1     F_TEMP_H;;;;NEW()
       MOV      DATA_CLOSE_10,#0
       MOV      DATA_CLOSE_11,#0
       MOV      TEMP_TIMER50MS,#0
	   
       CLR1     F_START_FIR;;;;NEW()
       CLR1     F_NEED_WAIT;;;;NEW()
	   
	   SET1     F_KEY_ALLOFF
	   SET1     F_TIME_DO;;;;++++++=====
	   SET1     F_RETURN_POW
	   
	   CLR1     LED_AUTO
       SET1     LED_AUTO_C   
KEY_STOP:
       CLR1     F_HEAT_FRIST;;;;;*********(*)
                
       CALL     !HEAT_OFF_FISH
       
       
       MOV      DELAY_4SCOU,#0    ;;;2010.09.11
       CLR1     F_DELAY_4S        ;;;2010.09.11
       MOV      DELAY_CALC_COU,#0 ;;;2010.09.11
       CLR1     F_WAIT_CLEAR      ;;;2010.09.11
       
       MOV      TEMP_TIMER50MS,#0 ;;;2010.09.12
       CLR1     F_NEED_20S        ;;;2010.09.12
       MOV      DELAY_20SCOU,#0   ;;;2010.09.12
       MOV      RE_CLOSE_COU,#0   ;;;2010.09.12
       MOV      RE_OPEN_COU,#0    ;;;2010.09.12
       MOV      T20S_RENEW_COU,#0 ;;;2010.09.12
       CLR1     F_ALR_M_DO        ;;;2010.09.12
       
       
       CLR1     F_NEED_MENY       ;;;2010.09.29
       
       
       SET1     F_KEYSTART;;;;;;;;;KEY  REKNOW
       CLR1     F_START_DO
       
       CLR1     F_SATRT_F
       SET1     F_CUP_ABLE
       SET1     F_WOR_F
       
       RET
;------------------------------------------------       
POWE_START_ON:
       SET1     F_START_DO
       
       SET1     F_SATRT_F
       CLR1     F_CUP_ABLE
       CLR1     F_WOR_F
       
POWE_START_OUT:      
       RET
        
;------------------------------------------------
        
DO_START:
        BT       F_WOR_F,$POWE_START_OUT
        BF       F_CUP_ABLE,$POWE_START_OUT
        
        SET1     F_WOR_F
        
        SET1     F_MODE_HEAT
        SET1     F_HEAT_FRIST;;;;;*********(*)
  
        SET1     F_START_FIR;;;;NEW()
        CLR1     F_NEED_WAIT;;;;NEW()
        CLR1     F_TEMP_H;;;;NEW()
        MOV      DATA_CLOSE_10,#0
        MOV      DATA_CLOSE_11,#0
        MOV      TEMP_TIMER50MS,#0
        
        
        MOV      DELAY_4SCOU,#0;;;2010.09.11
        CLR1     F_DELAY_4S    ;;;2010.09.11
        MOV      DELAY_CALC_COU,#0 ;;;2010.09.11
        CLR1     F_WAIT_CLEAR   ;;;2010.09.11
        
        CLR1     F_NEED_MENY       ;;;2010.09.29
        
        MOV      TEMP_TIMER50MS,#0 ;;;2010.09.12
        CLR1     F_NEED_20S        ;;;2010.09.12
        MOV      DELAY_20SCOU,#0   ;;;2010.09.12
        MOV      RE_CLOSE_COU,#0   ;;;2010.09.12
        MOV      RE_OPEN_COU,#0    ;;;2010.09.12
        MOV      T20S_RENEW_COU,#0 ;;;2010.09.12
        CLR1     F_ALR_M_DO        ;;;2010.09.12
        
        
        CLR1     F_FINISH_ADD
        CLR1     F_CALC_ADD
        CLR1     F_CUP_500MS
        
        CLR1     F_OVER_CALC_TIME
        
        CALL     !HEAT_PWM_CHANGE
SET_SMALL_PWM:
        
        SET1     F_KEYSTART
        MOV      LED_TIME_HEAT,#0
        
        RET
;------------------------------------------------
HEAT_PWM_CHANGE:;;;;;;;+++++++++++++++++++++++++++++
        MOV      HEAT_PWN,#0FFH
        MOV      DO_HEAT_PWM,#0FFH
        
        MOV      TIME_CALC_H,#12
        MOV      TIME_CALC_L,#3;;;1
    
        BF       F_CUP_HIG,$SET_SMALL_1
        RET
        
SET_SMALL_1:        

        MOV      TIME_CALC_H,#10
        MOV      TIME_CALC_L,#3;;;1
        
        SET1     F_CALC_HEAT
        MOV      HEAT_CALC,#36D
        MOV      SAVE_HEAT_CALC,#36D
        MOV      NOHE_CALC,#20D
        MOV      SAVE_NOHE_CALC,#20D
 
TIME_EXIT1:                              ;;;2010.09.12
        RET

       
;==========================================================
TIME:
		BF		   F_2048US, $TIME_EXIT1;;;;;2010.09.12
		CLR1	   F_2048US
		SET1       F_1MS
		SET1       F_POWR_1MS					
		
TIMER_2MS:

        INC       TIMER2MS

		CMP		  TIMER2MS, #2		
		BC		  $TIME_EXIT
		MOV		  TIMER2MS, #0
		SET1      F_KEY_2MS
		
TIMER_4MS:
        INC       TIMER4MS
		CMP		  TIMER4MS,#2		
		BC		  $TIME_EXIT
		MOV		  TIMER4MS, #0
		SET1      F_4MS_POW
		SET1      F_4MS
		SET1      F_CUP_4MS
		SET1      F_TEM_4MS
		SET1      F_AD_4MS
		SET1      F_KEY_100MS
		SET1      CUP_WAIT_100MS
		SET1      F_DELAY_4MS
		
        SET1      F_100MS_TEM;;;;;;NEW()
		SET1      F_CLOSE_100MS;;;;NEW()
		SET1      F_CLSE_4MS 
		
		
        SET1      F_FCLOSE_4MS ;;;;;;;;;2010.09.12
        SET1      F_FOPEN_4MS  ;;;;;;;;;2010.09.12
		
TIMER_100MS:
        INC       TIMER100MS
		CMP		  TIMER100MS,#25D
		BC		  $TIME_EXIT
		
		MOV		  TIMER100MS,#0
		SET1      F_LED_100MS
		SET1      F_100MS_TEM
		SET1      F_CALC_100MS
		SET1      F_CA_100MS
		;;SET1      CUP_WAIT_100MS
		SET1      F_CALC_100_2
		SET1      F_T4S_100MS;;;;;2010.09.11
		
		SET1      F_20S_100MS;;;;;2010.10.13

TIMER_500MS:
        INC       TIMER500MS
		CMP		  TIMER500MS,#5
		BC		  $TIME_EXIT
		
		MOV		  TIMER500MS, #0
		
		SET1      F_CALC_500C;;;;;2010.09.11
		
		SET1      F_500MS
		SET1      F_KEEP_500MS
		SET1      F_500MS_CAL;;;;*****
		SET1      F_CUP_500MS
		XOR       FLAG2,#01000000B
		
TIME_EXIT:
		RET
		
;-----------------------------------------------------------------------------------------		
;-----------------------------------------------------------------------------------------      
INTTMH1:

		SET1	F_2048US	               	                                
		RETI
;=========================================================================================
KEY:
        SET1     PU4.7
        SET1     P4.7
        
        NOP
        NOP
        NOP
        
		BF		 F_AD_4MS,$KEY_OUT1;;;BF		F_2MS,$AD_EXIT
		CLR1	 F_AD_4MS
		
        MOV      A,P4
        OR       A,#01111111B
        SUB      A,#0FFH
        BNZ      $KEY_DOING
        
OPEN_KEY:
		CLR1     F_KEYCLOSE
		CLR1     F_KEYCLOSE1
		SET1	 	 F_WORK
		MOV		 	 NOKEY_COUNT,#0
		MOV      CALC_KEY_COUN,#0
        RET
        
KEY_DOING:      
        BT       F_KEYCLOSE1,$KEY_OUT1
        
KEY_INC:
        
		INC	 	 NOKEY_COUNT
		CMP		 NOKEY_COUNT,#7
		BC       $KEY_OUT1;;;;;;;;;;;;xiao YU 8
            		
		MOV		 NOKEY_COUNT,#0;;;;;
		SET1     F_KEYCLOSE
        SET1     F_start_frist;;;;;;;;;NEQW  
        

 KEY_CALC_USE:   
        BF        F_CALC_100_2,$KEY_OUT1										;100ms time
        CLR1      F_CALC_100_2
        
        
        INC       CALC_KEY_COUN
		CMP		  CALC_KEY_COUN,#20D
		BC		  $KEY_OUT1
		MOV       CALC_KEY_COUN,#0															;long press 20*100ms =2seconds
        
        SET1      F_KEYCLOSE1
        SET1      F_KEY4_DO
KEY_OUT1:
        RET
        
;=========================================================================================
CALC_LED_OFF:      ;;;;;;;2010.04.30
;;,,,,------------------------------------------new 2010.04.30
        CLR1     LED_CUP_C          ;;cup=big
        CLR1     LED_CUP   
        
        CLR1     LED_AUTO_C
        CLR1     LED_AUTO
        RET
;;,,,,------------------------------------------new 2010.04.30
CUP_END_OUT:
        BT       F_MODE_CALC,$CALC_LED_OFF;;;;;;;;;;;2010.04.30
        
        BT       F_CUP_HIG,$SHOW_BIG_CUP
        
        CLR1     LED_CUP_C           ;;cup=small
        CLR1     LED_CUP   
        
        CLR1     LED_AUTO_C
        SET1     LED_AUTO
                                    
        ;;CLR1     LED_CUP_C
        ;;SET1     LED_CUP   
        RET
        
SHOW_BIG_CUP:
        CLR1     LED_CUP_C          ;;cup=big
        SET1     LED_CUP   
        
        CLR1     LED_AUTO_C
        SET1     LED_AUTO;;;;;CLR1     LED_AUTO;;;;2010.06.21
        RET
        

NO_SHOW_CUP:
		;;CLR1    LED_CUP             ;;cup=big
        ;;CLR1    LED_CUP_C
        
        CLR1     LED_CUP_C          
        CLR1     LED_CUP   
        
        CLR1     LED_AUTO_C
        CLR1     LED_AUTO
        RET
        
;;;;;;;;--------------------------------------------------
CUP_BIG:
        SET1     PU4.3        
        SET1     PM4.3
        
        NOP
        NOP
        NOP
        NOP
        
        BF       F_SATRT_F,$NO_SHOW_CUP
        
CUP_WORK:        
        BT       F_DEL_END,$CUP_ALL_ELE
        
        BF       CUP_WAIT_100MS,$CUP_OUT
        CLR1     CUP_WAIT_100MS
         
        INC      CUP_SAT_DELAY
		CMP		 CUP_SAT_DELAY,#25D;;;100MS
		BC		 $CUP_OUT
		
		MOV		 CUP_SAT_DELAY, #0
        SET1     F_DEL_END
        CLR1     F_CUP_ABLE
        
CUP_ALL_ELE:
        BT       F_CUP_ABLE,$CUP_END_OUT;;;;;START  after  no  test        
        
        BF       F_CUP_4MS,$CUP_OUT
        CLR1     F_CUP_4MS
        
        BF       P4.3,$CUP_HIGHT
        
CUP_LOW: 
        BF       F_CUP_BEFORE,$CUP_LOW_ADD
        
        CLR1     F_CUP_BEFORE
        MOV      CUP_TIME,#1
        RET
        
CUP_LOW_ADD:
        INC      CUP_TIME   
        CMP      CUP_TIME,#15D
		BC		 $CUP_OUT
		
		MOV      CUP_TIME,#0
		CLR1     F_CUP_HIG
		
		SET1     F_CUP_ABLE

        CLR1     LED_CUP_C           ;;cup=small
        CLR1     LED_CUP   
        
        CLR1     LED_AUTO_C
        SET1     LED_AUTO
        
        ;;;;CLR1     LED_CUP_C
        ;;;;SET1     LED_CUP
        RET
        
CUP_HIGHT:
        BT       F_CUP_BEFORE,$CUP_HIG_ADD
        
        SET1     F_CUP_BEFORE
        MOV      CUP_TIME,#1
        
        RET
        
CUP_HIG_ADD:
        INC      CUP_TIME   
        CMP      CUP_TIME,#20D
		BC		 $CUP_OUT
		
		MOV      CUP_TIME,#0
		SET1     F_CUP_HIG
		
		SET1     F_CUP_ABLE
		
        CLR1     LED_CUP_C          ;;cup=big
        SET1     LED_CUP   
        
        CLR1     LED_AUTO_C
        CLR1     LED_AUTO
		
		
		;;CLR1     LED_CUP
        ;;SET1     LED_CUP_C

CUP_OUT:		
        RET
       
;=========================================================
TEMP_DELAY_4S:
        BF       F_T4S_100MS,$TEMP_DELAY_OUT;;;;;2010.09.11
        CLR1     F_T4S_100MS
        
        INC      DELAY_4SCOU
        CMP      DELAY_4SCOU,#16D;;;;;;1.2-1.1s;;;;;;2010.10.13
        BC       $TEMP_DELAY_OUT
        
        MOV      DELAY_4SCOU,#0
        CLR1     F_DELAY_4S
TEMP_DELAY_OUT:        
        RET
        
;;;;--------------------------------------------------------

TEMP_RETURN1:
        CLR1     F_KEEP_TEMP 
        
TEMP_RETURN2:
        RET  
;;;;--------------------------------------------------------


KEY_TEMP:;;;;;;;;;;;;key  keep  temper: heat mode and no keep mode doing judge
        ;;RET;;;;;;;;;;;;;;;;;;;;;;;;;;;****************++++++++++++
        
        BT       F_DELAY_4S,$TEMP_DELAY_4S;;;;;2010.09.11
        
        BF       F_NEED_20S,$temp_old_loop;;;;2010.08.30     
        BR       !TEMP_DELAY_20S
        
temp_old_loop:
        
        BF       F_MODE_HEAT,$TEMP_RETURN1
        BT       F_KEEP_TEMP,$TEMP_RETURN2
 
        BF       F_START_FIR,$KEY_TEM_LOOP;;;;;NEW()
        BF       F_CLOSE_100MS,$KEY_TEM_LOOP;;;;;NEW()
        CLR1     F_CLOSE_100MS;;;;;NEW()
        
        INC      DATA_CLOSE_10;;;;;NEW()
        CMP      DATA_CLOSE_10,#55D;;;;;NEW()
        BC       $KEY_TEM_LOOP;;;;;NEW()
        
        MOV      DATA_CLOSE_10,#0;;;;;NEW()
        MOV      TEMP_TIMER50MS,#0     ;;;;;2010.09.11
        MOV      DATA_CLOSE_11,#0      ;;;;;2010.09.11
        
        CLR1     F_START_FIR;;;;;NEW()
        
        BF       F_TEMP_H,$KEY_TEM_LOOP;;;;;NEW()
        SET1     F_NEED_WAIT;;;;;NEW()
        
        SET1     F_DELAY_4S;         ;;;;;2010.09.11
        MOV      DELAY_4SCOU,#0      ;;;;;2010.09.11
        RET
        
KEY_TEM_LOOP:
 ;;*
        ;;;;RET
        BF       F_IN2,$KEY_TEMP_ADD					;;if F_IN2=0,jmp
        CLR1     F_IN2
        
        MOV      TEMP_TIMER50MS,#0
        
        BF       F_NEED_WAIT,$KEY_TEM_LOOP_OUT;;;;;NEW()
        BF       F_CLSE_4MS ,$KEY_TEM_LOOP_OUT;;;;;NEW()
        CLR1     F_CLSE_4MS 
        
        INC      DATA_CLOSE_11
        CMP      DATA_CLOSE_11,#55D
        BC       $KEY_TEM_LOOP_OUT
        
        MOV      TEMP_TIMER50MS,#0
        MOV      DATA_CLOSE_11,#0
        CLR1     F_NEED_WAIT
        CLR1     F_TEMP_H
        
        SET1     F_DELAY_4S;         ;;;;;2010.09.11
        MOV      DELAY_4SCOU,#0      ;;;;;2010.09.11
        
KEY_TEM_LOOP_OUT:
        RET
;;=============================================================================================        
KEY_TEMP_ADD:;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        
        BF       F_100MS_TEM,$TEMP_RETURN
        CLR1     F_100MS_TEM

        INC      TEMP_TIMER50MS
        CMP      TEMP_TIMER50MS,#25D
        BC       $TEMP_RETURN
        
        MOV      TEMP_TIMER50MS,#0
        MOV      DATA_CLOSE_11,#0;;;;;NEW()
        
        BT       F_START_FIR,$TEMP_FIR_KEEP
        BT       F_NEED_WAIT,$TEMP_RETURN
        
        SET1     F_NEED_20S;;;;2010.09.12
        SET1     F_DELAY_4S;;;;2010.09.12
        RET                ;;;;2010.09.12
        
        ;;;MOV      TEMP_TIMER50MS,#0
        ;;;SET1     F_KEEP_TEMP
;;;---------------------------------------------------
HEAT_KEEP_TEMP:;;;;;;;judge  keep temper
        MOV      TEMP_TIMER50MS,#0;;;;;2010.09.12
        SET1     F_KEEP_TEMP      ;;;;;2010.09.12
        
        CLR1     F_KEEP_500MS
        CLR1     F_MODE_HEAT
        SET1     F_MODE_KEEP  
        
        BT       F_MODE_CALC,$CALC_KEEP_TIME
        
        MOV      KEEP_SECOND,#80D  ;;;;#120D ;;2010.09.12		;2013.10.11,change 3min
        MOV      KEEP_MIN,#1D      ;;;;;;;;change_test
        MOV      KEEP_HOUR,#0D     ;;;;;;;;change_test
;;------------------------------------------------------        
TEMP_RETURN:
        RET


;====================================================================================        
CALC_KEEP_TIME:
        MOV      KEEP_SECOND,#120D;;;XIAO
        MOV      KEEP_MIN,#37D;;;;#29D
        MOV      KEEP_HOUR,#0
        
        ;;;;;BF       F_CUP_HIG,$TEMP_RETURN;;;;++++++++++++++++
        
        ;;;;MOV      KEEP_SECOND,#80D;;;;DA
        ;;;MOV      KEEP_MIN,#1D								;2013.10.11,change 3min
        ;;;;MOV      KEEP_HOUR,#0D
        RET
        
TEMP_FIR_KEEP:
        SET1      F_TEMP_H
        RET
        
;;;-------------------------------------------------------
;;;;;;;;;;;;;;;;;;;;;;;;;;; 2010.08.30
TEMP_DELAY_20S:
;;*
        BF        F_20S_100MS,$RE_TEMP_LOOP
        CLR1      F_20S_100MS
        
        
        INC      DELAY_20SCOU
        CMP      DELAY_20SCOU,#234D    ;;;25S   ;;;;2010.10.13  23.7+1.3
        BC       $RE_TEMP_LOOP
        
        MOV      DATA_CLOSE_11,#0;;;;;NEW()
        MOV      DELAY_20SCOU,#0
        MOV      RE_OPEN_COU,#0
        MOV      RE_CLOSE_COU,#0
        MOV      DELAY_4SCOU,#0
        MOV      T20S_RENEW_COU,#0 ;;;2010.09.12
        CLR1     F_ALR_M_DO        ;;;2010.09.12
        
        CLR1     F_NEED_20S
        
        BR       !HEAT_KEEP_TEMP
        

DELAY_20S_OUT:
        RET
;;;;-------------------------------------------------------
;;;RE_CLOSE_COU:	   DS		1
;;;RE_OPEN_COU:	   DS		1
;;F_FCLOSE_4MS       EQU      FLAG25.4 ;;;;;;;;;2010.08.30
;;F_FOPEN_4MS        EQU      FLAG25.5 ;;;;;;;;;2010.08.30

     
RE_TEMP_LOOP:
        BF       F_IN2,$OPEN_TEMP_ADD
        CLR1     F_IN2
        
        
        MOV      RE_OPEN_COU,#0

        BF       F_FCLOSE_4MS ,$RE_TEMP_OUT
        CLR1     F_FCLOSE_4MS 
        
        INC      RE_CLOSE_COU
        CMP      RE_CLOSE_COU,#55D
        BC       $RE_TEMP_OUT
        
        MOV      DATA_CLOSE_11,#0;;;;;NEW()
        MOV      TEMP_TIMER50MS,#0
        MOV      RE_CLOSE_COU,#0
        MOV      RE_OPEN_COU,#0
        MOV      DELAY_4SCOU,#0
        MOV      DELAY_20SCOU,#0
        
        CLR1     F_NEED_20S
        
        CLR1     F_NEED_WAIT
        CLR1     F_START_FIR;;;;;NEW()
        SET1     F_DELAY_4S;;;;2010.08.30
        
;;;;;-----------                     
        MOV      A,SAVE_HEAT_CALC         ;;;;;2010.10.12
        MOV      HEAT_CALC,A              ;;;;;2010.10.12
        
        SET1     F_CALC_HEAT              ;;;;;2010.10.12
        
        MOV      A,SAVE_NOHE_CALC         ;;;;;2010.10.12
        MOV      NOHE_CALC,A              ;;;;;2010.10.12
        
;;;;;-------------------------
        
        BT       F_MODE_CALC,$RE_TEMP_OUT  ;;;2010.09.12
        
        BT       F_ALR_M_DO,$RE_TEMP_OUT   ;;;2010.09.12
        
        INC      T20S_RENEW_COU
        CMP      T20S_RENEW_COU,#3D
        BC       $RE_TEMP_OUT
;;*
        MOV      T20S_RENEW_COU,#0          ;;;2010.09.12
        SET1     F_ALR_M_DO                 ;;;2010.09.12
        SET1     F_NEED_MENY                ;;;2010.09.29
        
RE_TEMP_OUT: 
        RET
        
;;;---------------
OPEN_TEMP_ADD:

        BF       F_FOPEN_4MS,$OPEN_TIME_OUT
        CLR1     F_FOPEN_4MS ;;;;;NEW()
        
        INC      RE_OPEN_COU;;;;;NEW()
        CMP      RE_OPEN_COU,#12D;;;;;NEW()
        BC       $OPEN_TIME_OUT;;;;;NEW()
        
        MOV      TEMP_TIMER50MS,#0
        MOV      RE_OPEN_COU,#0
        MOV      RE_CLOSE_COU,#0
        MOV      DATA_CLOSE_11,#0;;;;;NEW()

OPEN_TIME_OUT:
        RET
        
;==================================================================================================
;name:		POWER_WORK_ON
;output:  F_POWER_DONE
;description: if it has zero signal,set F_POWER_DONE,if in 48ms no signal,clr F_POWER_DONE
;===================================================================================================
POWER_WORK_ON:
        BF       F_POWR_1MS,$POWER_RETURN
        CLR1     F_POWR_1MS
        
        CLR1     PU4.4
        SET1     PM4.4
        CLR1     PU4.5
        SET1     PM4.5
        
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        
        
        BT        F_POWR_HIG,$LEL_LOW
        
LEL_HIG:        
        BF        P4.4,$POWER_WORK_ADD
        INC       POWR_TI_COUN
		CMP		  POWR_TI_COUN,#4
		BC		  $POWER_RETURN
		
        MOV		  POWR_TI_COUN,#0
        MOV       TEMP_POW50MS,#0
        SET1      F_POWER_DONE
        SET1      F_POWR_HIG
        RET
        
        
LEL_LOW:
        BT        P4.4,$POWER_WORK_ADD
        
        INC       POWR_TI_COUN
		CMP		  POWR_TI_COUN,#4		
		BC		  $POWER_RETURN
		
		MOV		  POWR_TI_COUN,#0
        MOV       TEMP_POW50MS,#0
        SET1      F_POWER_DONE
        CLR1      F_POWR_HIG
        RET
        
POWER_WORK_ADD:;;;;;;;;;;;;*******************
        MOV		 POWR_TI_COUN,#0
        BF       F_4MS_POW,$POWER_RETURN;;;;;2010.09.12
        CLR1     F_4MS_POW

        INC      TEMP_POW50MS
        CMP      TEMP_POW50MS,#12D
        BC       $POWER_RETURN
        
        MOV      TEMP_POW50MS,#0
        CLR1     F_POWER_DONE		;if no power signal in 50ms, clear F_POWER_DONE
        MOV		 POWR_TI_COUN,#0
        
POWER_RETURN:
        RET
        
;=========================================================
INT_NC:
        PUSH_STACK

        SET1     F_IN2;;;;;;INT2  FLAG  USE   INT2_DO_FLAG
        SET1     F_IN2_OFF

        POP_STACK
        RETI
        
        
;=========================================================
;=========================================================
HEAT_PWM_OFF:
        BT       F_NEED_20S,$TREWQ            ;;;;2010.09.12

        BT       F_NEED_WAIT,$HEAT_NOPWM_OFF

        BT       F_MODE_KEEP,$HEAT_NOPWM_OFF;;;;;()

        BF       F_MODE_HEAT,$HEAT_NOPWM_OFF1;;;;;()
                                            
        BT       F_MODE_CALC,$CALC_TIME;;;;++++++++++++++++
		BT       F_CUP_HIG,$HEAT_PWM_ON;;;;++++++++++++++++
		
        
CALC_TIME:
;;; 88
        BF       F_CALC_HEAT,$CALC_NO_DO
        
        BF       F_ONOF_CHANGE,$CALC_HEAT_LOOP
        ;;;;SET1     F_HEAT_FRIST;;;;VVV
        CLR1     F_ONOF_CHANGE
        BR       $CALC_HEAT_OUT
        
CALC_HEAT_LOOP:        
        CLR1     PM4.2
        CLR1     HEAT_MAIN  
        
        BF       F_500MS_CAL,$CALC_HEAT_OUT;;;********************************
        CLR1     F_500MS_CAL
        
        
        DBNZ     HEAT_CALC,$CALC_HEAT_OUT
        
        MOV      A,SAVE_HEAT_CALC
        MOV      HEAT_CALC,A
        
        CLR1     F_CALC_HEAT     
        
CALC_HEAT_OUT:
        RET
        
CALC_NO_DO:
        SET1     PM4.2
        SET1     HEAT_MAIN
        
        BF       F_500MS_CAL,$CALC_HEAT_OUT;;;********************************
        CLR1     F_500MS_CAL
        
        DBNZ     NOHE_CALC,$CALC_NOHEAT_OUT

        MOV      A,SAVE_NOHE_CALC
        MOV      NOHE_CALC,A
        
        SET1     F_ONOF_CHANGE;;;;;;;;;;;;(++++++++++++++)*****
        SET1     F_CALC_HEAT 
        
CALC_NOHEAT_OUT:
        RET
        
HEAT_NOPWM_OFF1:;;;;;()
        
HEAT_NOPWM_OFF:
        CLR1     F_IN2_OFF
TREWQ:
        SET1     PM4.2
        SET1     HEAT_MAIN  
        
HEAT_PWM_OUT:
        RET
        
HEAT_PWM_ON:
        CLR1     PM4.2
        CLR1     HEAT_MAIN  
        CLR1     F_IN2_OFF  
        RET
                
;=========================================================       
KEEP_TIME_COUNT:
        BT       F_MODE_HEAT,$HEA_PTC_ON

        BF       F_MODE_KEEP,$KEEP_TIME_OUT1
        
        BF       F_NEED_MENY,$KEEP_old_loop      ;;;2010.09.29
        CLR1     F_NEED_MENY                     ;;;2010.09.29
        CALL     !Write_TIME_CALC1               ;;;2010.09.29   
        
KEEP_old_loop:

        BF       F_MODE_CALC,$HEAT_KEEP_LOOP
        BR       !KEY_POWER_OFF

        
HEAT_KEEP_LOOP:
        CALL     !HEA_PTC_ON
              
MODLE_KEEP_LOOP:
        BF       F_KEEP_500MS,$KEEP_TIME_OUT
        CLR1     F_KEEP_500MS
        
        AND      KEEP_SECOND,#0FFH 
        BNZ      $P_TIMER_SEC
        
        AND      KEEP_MIN,#0FFH 
        BNZ      $P_TIMER_MIN
        
        AND      KEEP_HOUR,#0FFH 
        BNZ      $P_TIMER_HOUR
        
        CLR1     F_MODE_KEEP 
        CLR1     F_MODE_HEAT
        BR       !KEY_POWER_OFF
        
        
P_TIMER_HOUR:
        ADD      KEEP_HOUR,#0FFH
        MOV      KEEP_MIN,#59D
        MOV      KEEP_SECOND,#119D;;;;;#119D
        RET
        
P_TIMER_MIN:

        MOV      KEEP_SECOND,#119D;;;;;#119D
        ADD      KEEP_MIN,#0FFH
        RET
        
        
P_TIMER_SEC:    
        ADD      KEEP_SECOND,#0FFH
        RET
        
              
HEA_PTC_ON:
KEEP_TIME_OUT:
        RET
        
KEEP_TIME_OUT1:
        SET1     PM4.0
        SET1     HEAT_MAIN  
        RET
 
;;;====================================================================
CUP_WORK_TIME:
        BT       F_NEED_WAIT,$KEEP_TIME_OUT;;;;NEW()

        BT       F_OVER_CALC_TIME,$CUP_TIME_OUT
        BF       F_MODE_HEAT,$CUP_TIME_OUT

        BF       F_CUP_500MS,$CUP_TIME_OUT
        CLR1     F_CUP_500MS

        AND      TIME_CALC_L,#0FFH 
        BNZ      $CUP_L_DEC

        AND      TIME_CALC_H,#0FFH 
        BNZ      $CUP_H_DEC
        
        SET1     F_OVER_CALC_TIME
;;;--------------------------------------------------------***********
        CALL     !CHECK_TIME_CALC 
            
        BT       F_TIME_CALC,$CUP_CALC_OUT
        BT       F_TI_EASE_B,$Write_TIME_CALC1
   
           
        CALL     !ModeOn
        CALL     !FlashBlockErase
        
        
Write_TIME_CALC1:
        SET1     F_TIME_CALC
        MOVW     DE,#WR_TIME_DR
        SET1     F_TWO_NEED
        
        CALL     !ModeOn
        
Write_TIME_CALC:
        MOV       B,#WRITE_RETRY
        
TIME_CALC_LOOP:
;;;HHHHHH
        MOV       PFS,#0
        
        MOV       FLCMD,#05H ; Sets flash con trol command (byte write)
        MOV       A,D
        MOV       FLAPH,A; Sets address to which data is to be written, with
        MOV       A,E
        MOV       FLAPL,A; Sets address to which data is to be written, with
        MOV       FLW,#0AAH ; Sets data to be written (10H is specified here)
        
        CALL      !SubFlashSelfPrg
        
        ;;;;MOV       PFS,#00H ; Clears flash status register
        ;;;;MOV       WDTE,#0ACH ; Clears & restarts WDT
        ;;;;HALT                 ; Self programming is started
        ;;;;MOV       A,PFS
        ;;;;CMP       A,#0
        BZ        $TIME_RIGHT_WRITE
        
        DBNZ      B,$TIME_CALC_LOOP
        
        
TIME_RIGHT_WRITE:
        BF        F_TWO_NEED,$CUP_CALC_OUT
        CLR1      F_TWO_NEED
        INCW      DE
        BR        $Write_TIME_CALC
       
;;;---------------------------------------------------------------------------

CUP_L_DEC: 
        ADD       TIME_CALC_L,#0FFH
        RET

CUP_H_DEC:
        MOV       TIME_CALC_L,#119D;;;;;#119D
        ADD       TIME_CALC_H,#0FFH
        
        BT        F_FINISH_ADD,$CUP_TIME_OUT
        
        BT        F_CALC_ADD,$CUP_TIME_OUT
        
        SET1      F_CALC_ADD
        RET
;;;------------------------------------------------------------******
CUP_CALC_OUT:
        ;;;MOV       HEAT_PWN,#0FH
        ;;;MOV       DO_HEAT_PWM,#0FH
        
        CALL      !ModeOff
;;;------------------------------------------------------------
         
CUP_TIME_OUT:
        RET
        
;;;;===========================================================
;;;CALC_ADD_DONT:
        ;;;RET

;;;;;--------------------------------------------------------------
CALC_ADD:
        BT         F_FINISH_ADD,$CUP_TIME_OUT;;;$CALC_ADD_DONT;;;;0
        
        BF         F_CALC_ADD,$CUP_TIME_OUT;;$CALC_ADD_DONT;;;;;;;1
        
        SET1       F_FINISH_ADD;;;;;;;;;1
        CLR1       F_CALC_ADD;;;;;;;;;;;0
  

        BT         F_LED_CALC,$CUP_TIME_OUT
        
        MOVW       DE,#0DFFH
        MOV        A,[DE]
        CMP        A,#0AAH
        BZ         $CUP_TIME_OUT
        
CALC_ADD_LOOP:  
      
        CALL      !ModeOn
        
        BT        F_CHECK_B,$CALC_ADD_LOOP1
         
        BF        F_NEED_BLANK,$CALC_ADD_LOOP1;;;;;;;;NO  NEED ERASE

;;;;-------------------------------------------------------------*************
       
        MOV       BLOCK_REAL_DO,#LED_BLO_NUMB      ;;;   (13)
;;;;-------------------------------------------------------------*************
        
        CALL      !FlashBlockErase;;;;;;;;;NEED   ERASE
        BF        F_CHECK_B,$CALC_ADD_RETURN;;;;NO RIGHT--NO ADD OR RIGHT--ADD
        
        MOV       REA_MEED_DATA,#0
        CLR1      F_LED_CALC;;;;
        
 ;;;---------------------------------------------------------------    
CALC_ADD_LOOP1:
        INC       REA_MEED_DATA
        
 ;;;---------------------------------------------------------------       
FlashWrite:
        MOV       B,#WRITE_RETRY
        
Write_EEOR_LOOP:

        MOV       PFS,#0
        MOV       FLCMD,#05H ; Sets flash con trol command (byte write)
        MOV       FLAPH,#0DH;#0DH ;  Sets address to which data is to be written, with
        
        MOV       A,REA_MEED_DATA
        MOV       FLAPL,A; Sets address to which data is to be written, with
        MOV       FLW,A ; Sets data to be written (10H is specified here)
        
        CALL      !SubFlashSelfPrg
        
        ;;;MOV       PFS,#00H ; Clears flash status register
        ;;;MOV       WDTE,#0ACH ; Clears & restarts WDT
        ;;;HALT                 ; Self programming is started
        
        ;;;MOV       A,PFS
        ;;;CMP       A,#0
        BZ        $RIGHT_WRITE
        
        DBNZ      B,$Write_EEOR_LOOP
        
RIGHT_WRITE:
        CLR1       F_CHECK_B;;;;;;;ADD  AFTER  NO  BLANK  OR NEED BLANK  FLAG
        CLR1       F_NEED_BLANK
        
        MOV        A,REA_MEED_DATA
         
        CMP        A,#FLASH_COUNT;;;;;#250D
        BC         $CALC_ADD_RETURN
        MOV        REA_MEED_DATA,#FLASH_COUNT;;;;;#250D
        SET1       F_LED_CALC
;;;--------------------------------------------------------------- ;;CALC  FLAG  AT  0DFF=0AAH
WRIST_CALC_FLAG:
        MOV       B,#WRITE_RETRY

WCALC_FLAG_LOOP:
        MOV       PFS,#0
        MOV       FLCMD,#05H ; Sets flash con trol command (byte write)
        MOV       FLAPH,#0DH;#0DH ; Sets address to which data is to be written, with
        
        MOV       FLAPL,#0FFH; Sets address to which data is to be written, with
        MOV       FLW,#0AAH ; Sets data to be written (10H is specified here)
        
        CALL      !SubFlashSelfPrg
        
        
        ;;;MOV       PFS,#00H ; Clears flash status register
        ;;;MOV       WDTE,#0ACH ; Clears & restarts WDT
        ;;;HALT                 ; Self programming is started
        
        ;;;MOV       A,PFS
        ;;;CMP       A,#0
        BZ        $WCALC_FLAG_RIGHT
        
        DBNZ      B,$WCALC_FLAG_LOOP

WCALC_FLAG_RIGHT:
        
;;;--------------------------------------------------------------- 
        
CALC_ADD_RETURN:       
        CALL      !ModeOff      
        RET
        
 ;;;--------------------------------------------------------------- 
FlashBlockErase:
  
        CALL       !FlashBlockBlankCheck
        
        MOV        A,BLOCK_REAL_DO
        CMP        A,#13
        BNZ        $CHCK_ONBLANK
        
        BF         F_CHECK_B,$ERASE_LOOP_BLOCK
        CLR1       F_NEED_BLANK;;;;;;;;NEED ERASE
        CALL      !ModeOff
        RET
        
CHCK_ONBLANK:
        BF         F_TI_EASE_B,$ERASE_LOOP_BLOCK
        CLR1       F_TI_EASE_NEED;;;;;;;;NEED ERASE
        CALL      !ModeOff
        RET
;;;-------------------------------------------------;;;**********
        

ERASE_LOOP_BLOCK:
        SET1       F_Blank_ERASE_DO
        CALL       !ModeOn

        MOV        B,#ERASE_RETRY
        
ERASE_EEOR:
        MOV        FLCMD,#03H ; Sets flash control command (block erase)
        
        MOV        A,BLOCK_REAL_DO
        MOV        FLAPH,A ; Sets number of block to be erased (block 7 is specified; here)
        MOV        FLAPL,#00H ; Fixes FLAPL to ?0H?
        MOV        FLAPHC,A ; Sets erase block compare number (same value as that of; FLAPH)
        MOV        FLAPLC,#00H ; Fixes FLAPLC to ?0H?
        
        CALL       !SubFlashSelfPrg
        
        ;;;MOV       PFS,#00H ; Clears flash status register
        ;;;MOV        WDTE,#0ACH ; Clears & restarts WDT
        ;;;HALT                  ; Self programming is started
        ;;;MOV        A,PFS
        ;;;CMP        A,#00H
        
        BZ         $FlashBlockBlankCheck
        DBNZ       B,$ERASE_EEOR
        
MID_ERASE_EEOR:

        BR        $FINISH_ERASE_EEOR
        
FlashBlockBlankCheck:
        MOV        FLCMD,#04H ; Sets flash control command (block blank check)
        
        MOV        A,BLOCK_REAL_DO
        MOV        FLAPH,A; Sets number of block for blank check (block 7 is specified
        MOV        FLAPL,#00H ; Fixes FLAPL to ?0H?
        MOV        FLAPHC,A ; Sets blank check block compare number (same value as that of
        MOV        FLAPLC,#0FFH ; Fixes FLAPLC to ?FH?
        
        CALL       !SubFlashSelfPrg
        
        ;;;MOV        PFS,#00H ; Clears flash status register
        ;;;MOV        WDTE,#0ACH ; Clears & restarts WDT
        ;;;HALT                  ; Self programming is started
        ;;;MOV        A,PFS
        ;;;CMP        A,#0
        BZ         $RIGHT_ERASE

;===================================================================================================
;    ERASE_EEOR    
FINISH_ERASE_EEOR:
        CALL       !ModeOff
        CALL	   !TIME
        
        SET1       F_TWO_NEED
        
        
        MOV        A,BLOCK_REAL_DO
        CMP        A,#13
        BNZ        $FINISH_ERASE_EEOR1

        CLR1       F_CHECK_B;;;;;;;ADD  AFTER  NO  BLANK  OR NEED BLANK  FLAG
        SET1       F_NEED_BLANK
        
        BF         F_Blank_ERASE_DO,$CHECK_BLANK_OUT
        
        CALL       !ModeOn
        CALL       !WRITE_EEOR1
        RET
        
FINISH_ERASE_EEOR1:
        CLR1       F_TI_EASE_B;;;;;;;ADD  AFTER  NO  BLANK  OR NEED BLANK  FLAG
        SET1       F_TI_EASE_NEED
        
        BF         F_Blank_ERASE_DO,$CHECK_BLANK_OUT
        
       ;;; DD
        CALL       !ModeOn
        CALL       !WRITE_EEOR2
        
        RET
        
;===================================================================================================  
;     ERASE RIGHT      
RIGHT_ERASE:
        CALL       !ModeOff
        CALL	   !TIME
        CLR1       F_Blank_ERASE_DO

        MOV        A,BLOCK_REAL_DO
        CMP        A,#13
        BNZ        $RIGHT_ERASE1
        
        CLR1       F_NEED_BLANK;;;;;;;;NEED ERASE
        SET1       F_CHECK_B
        
        RET
 ;==================================================================================================      
RIGHT_ERASE1:
        CLR1       F_TI_EASE_NEED;;;;;;;;NEED ERASE
        SET1       F_TI_EASE_B
CHECK_BLANK_OUT:

        RET
;;;;------------------------------------------------------------------------------------------------        
WRITE_EEOR1:

        MOVW       AX,#WR_EEOR_LED
        MOVW       DE,AX
        
Write_00_LOOP:
        MOV        B,#WRITE_RETRY
        
Write_00_LOOP1:

        MOV        PFS,#0
        MOV        FLCMD,#05H ; Sets flash con trol command (byte write)
        
        MOV        FLAPH,A ; Sets address to which data is to be written, with
        XCH        A,X
        MOV        FLAPL,A; Sets address to which data is to be written, with
        MOV        FLW,#0 ; Sets data to be written (10H is specified here)
        
        CALL      !SubFlashSelfPrg
        
        ;;;MOV       PFS,#00H ; Clears flash status register
        ;;;MOV       WDTE,#0ACH ; Clears & restarts WDT
        ;;;HALT                 ; Self programming is started
        
        ;;;MOV       A,PFS
        ;;;CMP       A,#0
        BZ        $RIGHT_00_WRITE
        
        DBNZ      B,$Write_00_LOOP1
        
RIGHT_00_WRITE:
        
        BF        F_TWO_NEED,$Write_00_LOOP_OUT
        CLR1      F_TWO_NEED
        MOVW      AX,DE
        INCW      AX
        BR        $Write_00_LOOP
        ;;;RET
        
Write_00_LOOP_OUT:
        CALL       !ModeOff
        RET
        
WRITE_EEOR2:
        MOVW        AX,#WR_EEOR_TIM
        MOVW        DE,AX
        BR         $Write_00_LOOP
        ;;;RET
        
        
;;;;------------------------------------------------------------------        
        
        
ModeOff:													;end self program
        MOV       PFS,#00H ; Clears flash status register
        MOV       PFCMD,#0A5H ; PFCMD register control
        MOV       FLPMC,#00H ; FLPMC register control (sets value)
        MOV       FLPMC,#0FFH ; FLPMC register control (inverts set value)
        MOV       FLPMC,#00H ; Sets normal mode via FLPMC register control (sets value)
        MOV       A,PFS
        CMP       A,#00H
        BNZ       $ModeOff ; Checks completion of write to specific registers
                           ; Repeats the same processing when an error occurs?
                           
        BF        F_INT_MK,$BBB			;IF bit=0, jmp
        
        MOV       A,INT_MK0
        MOV       MK0,A
        
        BF        F_INT_MK,$BBB
        EI
        RET
        
BBB:  
        MOV       MK0,#0FFH
        DI
        RET
        
        
 ;;;;-----------------------------------------------------------------------------------------------
ModeOn:																;open  flash selfprogramer 
         MOV       A,MK0
         MOV       INT_MK0,A
        
         MOV        MK0,#11111111B ; Masks all interrupts
         DI
ModeOnLoop:
         MOV        PFS,#00H ; Clears flash status register
         MOV        PFCMD,#0A5H ; PFCMD register control
         MOV        FLPMC,#01H ; FLPMC register control (sets value)
         MOV        FLPMC,#0FEH ; FLPMC register control (inverts set value)
         MOV        FLPMC,#01H ; Sets self 
         MOV        A,PFS
         CMP        A,#00H
         BNZ        $ModeOnLoop ; Checks completion of write to specific registers
         RET
;;;;================================================================================================
CHECK_TIME_CALC:
        MOV       BLOCK_REAL_DO,#TIME_BLO_NUMB   ;14
         
        CALL      !ModeOn 
        CALL      !FlashBlockBlankCheck
        CALL      !ModeOff

        BT        F_TI_EASE_B,$CHECK_CALTI_B						;?
        
        
        MOVW       DE,#0E03H
        CALL       !HHHH
        BF         F_TIME_CALC,$CHECK_CALTI_OUT 
        
        INCW       DE
        CALL       !HHHH
        BF         F_TIME_CALC,$CHECK_CALTI_OUT
        
        MOVW       DE,#0E00H;;;;#0F00H
        CALL       !GGGG
        
        BT         F_TIME_CALC,$CHECK_CALTI_OUT   
        
        INCW       DE
        CALL       !GGGG
        
        RET
 
HHHH:      
        MOV        A,[DE]
        CMP        A,#0
        
        CLR1       F_TIME_CALC
        BZ         $CHECK_CALTI_OUT
        SET1       F_TIME_CALC
        RET
 
GGGG:      
        MOV        A,[DE]
        CMP        A,#0AAH
        
        SET1       F_TIME_CALC
        BZ         $CHECK_CALTI_OUT
        CLR1       F_TIME_CALC
        
        RET
  
CHECK_CALTI_B:
        CLR1       F_TIME_CALC
        
CHECK_CALTI_OUT:
        
        RET
        
;;;;================================================================================================
;;;ALL_HEAT_OFF:
;;;; SET1    PMK2
         
HEAT_OFF_FISH:
         CLR1    F_CALC_FLAS;;;;;;NEWWW1111
         MOV     CALC_LED_COU,#0;;;;;;NEWWW1111
         
         MOV     PU4,#00000100B
         CLR1    P4.0
         SET1    PM4.0
         CLR1    F_MODE_HEAT
         
         CLR1    PU2.0
         CLR1    P2.0
         SET1    PM2.0

         
         CLR1    P4.1
         SET1    PM4.1
         RET
         
;;;;================================================================================================
CLEAR_CALC_DO:

        BT        F_WAIT_CLEAR,$CALC_WAIT_TIME   ;;;2010.09.11  bts1

        BF        F_KEY4_DO,$CLEAR_CALC_OUT      ;;;2010.09.11  bts0
        CLR1      F_KEY4_DO                      ;;;2010.09.11

        
        SET1      F_WAIT_CLEAR                    ;;;2010.09.11
        
        
CLEAR_CALC_OUT1:
        SET1     F_START_FIR;;;;NEW()
        CLR1     F_NEED_WAIT;;;;NEW()
        CLR1     F_TEMP_H;;;;NEW()
        MOV      DATA_CLOSE_10,#0
        MOV      DATA_CLOSE_11,#0
        MOV      TEMP_TIMER50MS,#0
        
;;
        MOV      DELAY_4SCOU,#0;;;2010.09.11
        CLR1     F_DELAY_4S    ;;;2010.09.11
        MOV      DELAY_CALC_COU,#0 ;;;2010.09.11
        
        
        MOV      TEMP_TIMER50MS,#0 ;;;2010.09.12
        CLR1     F_NEED_20S        ;;;2010.09.12
        MOV      DELAY_20SCOU,#0   ;;;2010.09.12
        MOV      RE_CLOSE_COU,#0   ;;;2010.09.12
        MOV      RE_OPEN_COU,#0    ;;;2010.09.12
        MOV      T20S_RENEW_COU,#0 ;;;2010.09.12
        CLR1     F_ALR_M_DO        ;;;2010.09.12
        
        
        CLR1     F_NEED_MENY       ;;;2010.09.29
        
        
        CLR1       F_MODE_KEEP;;;;;;;;2010.05.06
        SET1       F_MODE_CALC
        SET1       F_MODE_HEAT
        CLR1       F_MODE_KEEP;;;;;;;;;;;;;;;;;;;;;;**********(*)
        
        CLR1       F_CALC_FLAS;;;;;;NEWWW1111
        MOV        CALC_LED_COU,#0;;;;;;NEWWW1111
        
        SET1       F_OVER_CALC_TIME
        MOV        HEAT_PWN,#0FFH
        MOV        DO_HEAT_PWM,#0FFH
        MOV        SEND_PWM_8,#8
;  00  
;;*    
;;,,,,------------------------------------------new 2010.04.30
        CLR1     LED_CUP_C          ;;cup=big
        CLR1     LED_CUP   
        
        CLR1     LED_AUTO_C
        CLR1     LED_AUTO
        
;;,,,,------------------------------------------new 2010.04.30
        SET1       F_CALC_HEAT
        MOV        HEAT_CALC,#20D
        MOV        SAVE_HEAT_CALC,#20D
        MOV        NOHE_CALC,#80D
        MOV        SAVE_NOHE_CALC,#80D
        
        MOV        TEMP_TIMER50MS,#0;;;;9999
        ;;;;BF         F_CUP_HIG,$CLEAR_CALC_OUT;;;;++++++++++++++++
        ;;;;MOV        HEAT_CALC,#36D
        ;;;;MOV        SAVE_HEAT_CALC,#36D
        ;;;MOV        NOHE_CALC,#20D
        ;;;MOV        SAVE_NOHE_CALC,#20D
        RET
        
        
CLEAR_CALC_OUT:

        RET
;;;;------------------------------------------------2010.09.11
CALC_WAIT_TIME:    ;;;;;2010.09.11
;;;*
  
        BF        F_CALC_500C,$CALC_WAIT_OUT
        CLR1      F_CALC_500C
        
        
        INC      DELAY_CALC_COU
        CMP      DELAY_CALC_COU,#112D
        BC       $CALC_WAIT_OUT
        
        MOV      DELAY_CALC_COU,#0
        CLR1     F_WAIT_CLEAR
        
        BF        F_TIME_CALC,$CHECK_BLOCK_CLEAR
        CLR1      F_TIME_CALC
        
        MOV       BLOCK_REAL_DO,#TIME_BLO_NUMB    ;;;;(14)
        

        CALL      !ModeOn
        CALL      !FlashBlockErase
        CALL      !ModeOff
CHECK_BLOCK_CLEAR:       
        ;;;;;BF        F_LED_CALC,$CLEAR_CALC_OUT1;;;;;;2010.09.11
        CLR1      F_LED_CALC                 ;;;;;;2010.09.11
        
        MOV       BLOCK_REAL_DO,#LED_BLO_NUMB    ;;;;(13)
        

        CALL      !ModeOn 
        CALL      !FlashBlockErase
        CALL      !ModeOff
        
        MOV        REA_MEED_DATA,#0
        
        
CALC_WAIT_OUT:
        RET

        
;;;;======================================***************************************
CALC_LED:
        
        BT       F_MODE_CALC,$CALC_LED_ON 
        
CALC_LED_LOOP:
        BT       F_TIME_CALC,$CALC_LED_ALON
        BT       F_LED_CALC,$CALC_LED_ALON

OFF_LED_CA:   
        
        SET1     LED_CALC_C
        CLR1     LED_CALC 
        RET
;;;;----------------------------------------------------
CALC_LED_ON:
        BF       F_CA_100MS,$CALC_LED_REL;;;;;NEWWW1111
        CLR1     F_CA_100MS
        
        INC      CALC_LED_COU
        CMP      CALC_LED_COU,#5
        BC       $CALC_LED_REL
        MOV      CALC_LED_COU,#0
        
        XOR      FLAG23,#00000100B

CALC_LED_REL:
        BT       F_CALC_FLAS,$OFF_LED_CA;;;;;;;;NEWWWW1

CALC_LED_ALON:
        

        SET1     LED_CALC
        CLR1     LED_CALC_C
        SET1     LED_CALC
        RET  
;;;;======================================***********************
SubFlashSelfPrg:
        MOV       PFS,#00H ; Clears flash status register
        MOV       WDTE,#0ACH ; Clears & restarts WDT
        HALT                 ; Self programming is started
        
        MOV       A,PFS
        CMP       A,#0
        RET
;;;;======================================***************************************
;;;ORG     0FF4H
;;;BBBBBB:
        ;; CLR1        PM4.5;;()
        ;; SET1        P4.5;;()
         
        ;; MOV         WDTE,#0
        ;; BR          !START

		END


		;;eric zhang
                                                                                  
