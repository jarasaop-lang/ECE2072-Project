/*
 Copyright (C) 2018  Intel Corporation. All rights reserved.
 Your use of Intel Corporation's design tools, logic functions 
 and other software and tools, and its AMPP partner logic 
 functions, and any output files from any of the foregoing 
 (including device programming or simulation files), and any 
 associated documentation or information are expressly subject 
 to the terms and conditions of the Intel Program License 
 Subscription Agreement, the Intel Quartus Prime License Agreement,
 the Intel FPGA IP License Agreement, or other applicable license
 agreement, including, without limitation, that your use is for
 the sole purpose of programming logic devices manufactured by
 Intel and sold by Intel or its authorized distributors.  Please
 refer to the applicable agreement for further details.
*/
MODEL
/*MODEL HEADER*/
/*
 This file contains Fast Corner delays for the design using part 10M50DAF484C7G
 with speed grade M, core voltage 1.2V, and temperature 0 Celsius

*/
MODEL_VERSION "1.0";
DESIGN "x72";
DATE "10/06/2026 00:16:23";
PROGRAM "Quartus Prime";



INPUT KEY[0];
INPUT KEY[1];
INPUT SW[8];
INPUT SW[6];
INPUT SW[7];
INPUT SW[0];
INPUT SW[3];
INPUT SW[4];
INPUT SW[5];
INPUT SW[1];
INPUT SW[2];
OUTPUT LEDR[0];
OUTPUT LEDR[1];
OUTPUT LEDR[2];
OUTPUT LEDR[3];
OUTPUT LEDR[4];
OUTPUT LEDR[5];
OUTPUT LEDR[6];
OUTPUT LEDR[7];
OUTPUT LEDR[8];
OUTPUT LEDR[9];
OUTPUT HEX5[0];
OUTPUT HEX5[1];
OUTPUT HEX5[2];
OUTPUT HEX5[3];
OUTPUT HEX5[4];
OUTPUT HEX5[5];
OUTPUT HEX5[6];

/*Arc definitions start here*/
pos_KEY[0]__KEY[1]__setup:		SETUP (POSEDGE) KEY[0] KEY[1] ;
pos_SW[0]__KEY[1]__setup:		SETUP (POSEDGE) SW[0] KEY[1] ;
pos_SW[1]__KEY[1]__setup:		SETUP (POSEDGE) SW[1] KEY[1] ;
pos_SW[2]__KEY[1]__setup:		SETUP (POSEDGE) SW[2] KEY[1] ;
pos_SW[3]__KEY[1]__setup:		SETUP (POSEDGE) SW[3] KEY[1] ;
pos_SW[4]__KEY[1]__setup:		SETUP (POSEDGE) SW[4] KEY[1] ;
pos_SW[5]__KEY[1]__setup:		SETUP (POSEDGE) SW[5] KEY[1] ;
pos_SW[6]__KEY[1]__setup:		SETUP (POSEDGE) SW[6] KEY[1] ;
pos_SW[7]__KEY[1]__setup:		SETUP (POSEDGE) SW[7] KEY[1] ;
pos_SW[8]__KEY[1]__setup:		SETUP (POSEDGE) SW[8] KEY[1] ;
pos_KEY[0]__KEY[1]__hold:		HOLD (POSEDGE) KEY[0] KEY[1] ;
pos_SW[0]__KEY[1]__hold:		HOLD (POSEDGE) SW[0] KEY[1] ;
pos_SW[1]__KEY[1]__hold:		HOLD (POSEDGE) SW[1] KEY[1] ;
pos_SW[2]__KEY[1]__hold:		HOLD (POSEDGE) SW[2] KEY[1] ;
pos_SW[3]__KEY[1]__hold:		HOLD (POSEDGE) SW[3] KEY[1] ;
pos_SW[4]__KEY[1]__hold:		HOLD (POSEDGE) SW[4] KEY[1] ;
pos_SW[5]__KEY[1]__hold:		HOLD (POSEDGE) SW[5] KEY[1] ;
pos_SW[6]__KEY[1]__hold:		HOLD (POSEDGE) SW[6] KEY[1] ;
pos_SW[7]__KEY[1]__hold:		HOLD (POSEDGE) SW[7] KEY[1] ;
pos_SW[8]__KEY[1]__hold:		HOLD (POSEDGE) SW[8] KEY[1] ;
pos_KEY[1]__HEX5[0]__delay:		DELAY (POSEDGE) KEY[1] HEX5[0] ;
pos_KEY[1]__HEX5[1]__delay:		DELAY (POSEDGE) KEY[1] HEX5[1] ;
pos_KEY[1]__HEX5[2]__delay:		DELAY (POSEDGE) KEY[1] HEX5[2] ;
pos_KEY[1]__HEX5[3]__delay:		DELAY (POSEDGE) KEY[1] HEX5[3] ;
pos_KEY[1]__HEX5[4]__delay:		DELAY (POSEDGE) KEY[1] HEX5[4] ;
pos_KEY[1]__HEX5[5]__delay:		DELAY (POSEDGE) KEY[1] HEX5[5] ;
pos_KEY[1]__HEX5[6]__delay:		DELAY (POSEDGE) KEY[1] HEX5[6] ;
pos_KEY[1]__LEDR[0]__delay:		DELAY (POSEDGE) KEY[1] LEDR[0] ;
pos_KEY[1]__LEDR[1]__delay:		DELAY (POSEDGE) KEY[1] LEDR[1] ;
pos_KEY[1]__LEDR[2]__delay:		DELAY (POSEDGE) KEY[1] LEDR[2] ;
pos_KEY[1]__LEDR[3]__delay:		DELAY (POSEDGE) KEY[1] LEDR[3] ;
pos_KEY[1]__LEDR[4]__delay:		DELAY (POSEDGE) KEY[1] LEDR[4] ;
pos_KEY[1]__LEDR[5]__delay:		DELAY (POSEDGE) KEY[1] LEDR[5] ;
pos_KEY[1]__LEDR[6]__delay:		DELAY (POSEDGE) KEY[1] LEDR[6] ;
pos_KEY[1]__LEDR[7]__delay:		DELAY (POSEDGE) KEY[1] LEDR[7] ;
pos_KEY[1]__LEDR[8]__delay:		DELAY (POSEDGE) KEY[1] LEDR[8] ;
pos_KEY[1]__LEDR[9]__delay:		DELAY (POSEDGE) KEY[1] LEDR[9] ;
___4.490__delay:		DELAY  4.490 ;
___4.363__delay:		DELAY  4.363 ;
___4.138__delay:		DELAY  4.138 ;
___4.467__delay:		DELAY  4.467 ;
___4.693__delay:		DELAY  4.693 ;
___4.322__delay:		DELAY  4.322 ;
___5.150__delay:		DELAY  5.150 ;
___4.609__delay:		DELAY  4.609 ;
___4.410__delay:		DELAY  4.410 ;
___4.400__delay:		DELAY  4.400 ;

ENDMODEL
