; Made with love by Amani Murera: 218009427 and Kirezi emery Herve : 218009815
; PIC16F877A Configuration Bit Settings

; Assembly source line config statements

#include "p16f877a.inc"

; CONFIG
; __config 0x3FFB
; __CONFIG _FOSC_EXTRC & _WDTE_OFF & _PWRTE_OFF & _BOREN_ON & _LVP_ON & _CPD_OFF & _WRT_OFF & _CP_OFF

    STATUS equ 03h  ;status register will be used to select bank   
 
    RP0 equ 05 ; bit 5 of status register is named RPO
 
    RP1 equ 06 ; bit 6 of status register is named RP1
 
    PORTB equ 06h ;bank0
    
    TRISB equ 86h ;bank1 TRISB determnine if PORTB is input or output
 
    COUNTER equ 20h ;the counter for create a delay
 
    org 00h ; use the org directive to force program start at reset vector  
    clrw  ; clear  W register
	
    ;selecting bank0 RPO=0 && RP1=1
    BCF STATUS,RP0;RP0=0
    BCF STATUS,RP1;RP1=0
    
    CLRF PORTB
    
    ;switch to bank 1 to access TRISB register
    BSF STATUS,RP0;RP0=1 to select bank1
    
    CLRF TRISB 
    	
    MOVLW 0X00 ; clear w register
    MOVWF TRISB ; SET PORTB as output
    
    ;switch back to bank0 for working with portB
    BCF STATUS,RP0 ;RP0=0
BEGIN MOVLW 0x01
     MOVWF PORTB ;turn on only first pin on PORTB
	
      ;delay
     MOVLW 0xff
     MOVWF COUNTER;setting the counter 
     
Loop1 DECFSZ COUNTER,1; decrement by 1, until 0
      GOTO Loop1 ; if counter is equal to zero then carry on
      
      MOVLW 0x02  
      MOVWF PORTB ;turn on only second pin on PORTB
      
	  
      ;delay
      MOVLW 0xff  
      MOVWF COUNTER ; setting counter again
      
Loop2 DECFSZ COUNTER,1  ; decrement by 1,until 0
      GOTO Loop2 ; if counter is zero then carry on
      
      MOVLW 0x04  
      MOVWF PORTB ;turn on only third pin on PORTB 
	  
      ;delay
      MOVLW 0xff  
      MOVWF COUNTER ; setting the counter  
     
Loop3 DECFSZ COUNTER,1 ; decrement by 1
      GOTO Loop3 ; if counter 1 is  zero then carry on
 
      GOTO BEGIN
     
end


