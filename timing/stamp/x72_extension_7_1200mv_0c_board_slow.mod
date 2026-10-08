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
 This file contains Slow Corner delays for the design using part 10M50DAF484C7G
 with speed grade 7, core voltage 1.2V, and temperature 0 Celsius

*/
MODEL_VERSION "1.0";
DESIGN "x72_extension";
DATE "10/08/2026 14:49:07";
PROGRAM "Quartus Prime";



INPUT KEY[0];
INPUT SW[9];
INPUT KEY[1];
INPUT SW[8];
INPUT SW[6];
INPUT SW[7];
INPUT SW[0];
INPUT SW[3];
INPUT SW[5];
INPUT SW[4];
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
OUTPUT HEX5[7];
OUTPUT HEX4[0];
OUTPUT HEX4[1];
OUTPUT HEX4[2];
OUTPUT HEX4[3];
OUTPUT HEX4[4];
OUTPUT HEX4[5];
OUTPUT HEX4[6];
OUTPUT HEX4[7];
OUTPUT HEX3[0];
OUTPUT HEX3[1];
OUTPUT HEX3[2];
OUTPUT HEX3[3];
OUTPUT HEX3[4];
OUTPUT HEX3[5];
OUTPUT HEX3[6];
OUTPUT HEX3[7];
OUTPUT HEX2[0];
OUTPUT HEX2[1];
OUTPUT HEX2[2];
OUTPUT HEX2[3];
OUTPUT HEX2[4];
OUTPUT HEX2[5];
OUTPUT HEX2[6];
OUTPUT HEX2[7];
OUTPUT HEX1[0];
OUTPUT HEX1[1];
OUTPUT HEX1[2];
OUTPUT HEX1[3];
OUTPUT HEX1[4];
OUTPUT HEX1[5];
OUTPUT HEX1[6];
OUTPUT HEX1[7];
OUTPUT HEX0[0];
OUTPUT HEX0[1];
OUTPUT HEX0[2];
OUTPUT HEX0[3];
OUTPUT HEX0[4];
OUTPUT HEX0[5];
OUTPUT HEX0[6];
OUTPUT HEX0[7];

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
pos_SW[9]__KEY[1]__setup:		SETUP (POSEDGE) SW[9] KEY[1] ;
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
pos_SW[9]__KEY[1]__hold:		HOLD (POSEDGE) SW[9] KEY[1] ;
pos_KEY[1]__HEX0[0]__delay:		DELAY (POSEDGE) KEY[1] HEX0[0] ;
pos_KEY[1]__HEX0[1]__delay:		DELAY (POSEDGE) KEY[1] HEX0[1] ;
pos_KEY[1]__HEX0[2]__delay:		DELAY (POSEDGE) KEY[1] HEX0[2] ;
pos_KEY[1]__HEX0[3]__delay:		DELAY (POSEDGE) KEY[1] HEX0[3] ;
pos_KEY[1]__HEX0[4]__delay:		DELAY (POSEDGE) KEY[1] HEX0[4] ;
pos_KEY[1]__HEX0[5]__delay:		DELAY (POSEDGE) KEY[1] HEX0[5] ;
pos_KEY[1]__HEX0[6]__delay:		DELAY (POSEDGE) KEY[1] HEX0[6] ;
pos_KEY[1]__HEX0[7]__delay:		DELAY (POSEDGE) KEY[1] HEX0[7] ;
pos_KEY[1]__HEX1[0]__delay:		DELAY (POSEDGE) KEY[1] HEX1[0] ;
pos_KEY[1]__HEX1[1]__delay:		DELAY (POSEDGE) KEY[1] HEX1[1] ;
pos_KEY[1]__HEX1[2]__delay:		DELAY (POSEDGE) KEY[1] HEX1[2] ;
pos_KEY[1]__HEX1[3]__delay:		DELAY (POSEDGE) KEY[1] HEX1[3] ;
pos_KEY[1]__HEX1[4]__delay:		DELAY (POSEDGE) KEY[1] HEX1[4] ;
pos_KEY[1]__HEX1[5]__delay:		DELAY (POSEDGE) KEY[1] HEX1[5] ;
pos_KEY[1]__HEX1[6]__delay:		DELAY (POSEDGE) KEY[1] HEX1[6] ;
pos_KEY[1]__HEX1[7]__delay:		DELAY (POSEDGE) KEY[1] HEX1[7] ;
pos_KEY[1]__HEX2[0]__delay:		DELAY (POSEDGE) KEY[1] HEX2[0] ;
pos_KEY[1]__HEX2[1]__delay:		DELAY (POSEDGE) KEY[1] HEX2[1] ;
pos_KEY[1]__HEX2[2]__delay:		DELAY (POSEDGE) KEY[1] HEX2[2] ;
pos_KEY[1]__HEX2[3]__delay:		DELAY (POSEDGE) KEY[1] HEX2[3] ;
pos_KEY[1]__HEX2[4]__delay:		DELAY (POSEDGE) KEY[1] HEX2[4] ;
pos_KEY[1]__HEX2[5]__delay:		DELAY (POSEDGE) KEY[1] HEX2[5] ;
pos_KEY[1]__HEX2[6]__delay:		DELAY (POSEDGE) KEY[1] HEX2[6] ;
pos_KEY[1]__HEX2[7]__delay:		DELAY (POSEDGE) KEY[1] HEX2[7] ;
pos_KEY[1]__HEX3[0]__delay:		DELAY (POSEDGE) KEY[1] HEX3[0] ;
pos_KEY[1]__HEX3[1]__delay:		DELAY (POSEDGE) KEY[1] HEX3[1] ;
pos_KEY[1]__HEX3[2]__delay:		DELAY (POSEDGE) KEY[1] HEX3[2] ;
pos_KEY[1]__HEX3[3]__delay:		DELAY (POSEDGE) KEY[1] HEX3[3] ;
pos_KEY[1]__HEX3[4]__delay:		DELAY (POSEDGE) KEY[1] HEX3[4] ;
pos_KEY[1]__HEX3[5]__delay:		DELAY (POSEDGE) KEY[1] HEX3[5] ;
pos_KEY[1]__HEX3[6]__delay:		DELAY (POSEDGE) KEY[1] HEX3[6] ;
pos_KEY[1]__HEX3[7]__delay:		DELAY (POSEDGE) KEY[1] HEX3[7] ;
pos_KEY[1]__HEX4[0]__delay:		DELAY (POSEDGE) KEY[1] HEX4[0] ;
pos_KEY[1]__HEX4[1]__delay:		DELAY (POSEDGE) KEY[1] HEX4[1] ;
pos_KEY[1]__HEX4[2]__delay:		DELAY (POSEDGE) KEY[1] HEX4[2] ;
pos_KEY[1]__HEX4[3]__delay:		DELAY (POSEDGE) KEY[1] HEX4[3] ;
pos_KEY[1]__HEX4[4]__delay:		DELAY (POSEDGE) KEY[1] HEX4[4] ;
pos_KEY[1]__HEX4[5]__delay:		DELAY (POSEDGE) KEY[1] HEX4[5] ;
pos_KEY[1]__HEX4[6]__delay:		DELAY (POSEDGE) KEY[1] HEX4[6] ;
pos_KEY[1]__HEX4[7]__delay:		DELAY (POSEDGE) KEY[1] HEX4[7] ;
pos_KEY[1]__HEX5[0]__delay:		DELAY (POSEDGE) KEY[1] HEX5[0] ;
pos_KEY[1]__HEX5[1]__delay:		DELAY (POSEDGE) KEY[1] HEX5[1] ;
pos_KEY[1]__HEX5[2]__delay:		DELAY (POSEDGE) KEY[1] HEX5[2] ;
pos_KEY[1]__HEX5[3]__delay:		DELAY (POSEDGE) KEY[1] HEX5[3] ;
pos_KEY[1]__HEX5[4]__delay:		DELAY (POSEDGE) KEY[1] HEX5[4] ;
pos_KEY[1]__HEX5[5]__delay:		DELAY (POSEDGE) KEY[1] HEX5[5] ;
pos_KEY[1]__HEX5[6]__delay:		DELAY (POSEDGE) KEY[1] HEX5[6] ;
pos_KEY[1]__HEX5[7]__delay:		DELAY (POSEDGE) KEY[1] HEX5[7] ;
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
___7.973__delay:		DELAY  7.973 ;
___8.141__delay:		DELAY  8.141 ;
___8.182__delay:		DELAY  8.182 ;
___8.191__delay:		DELAY  8.191 ;
___8.377__delay:		DELAY  8.377 ;
___8.529__delay:		DELAY  8.529 ;
___8.936__delay:		DELAY  8.936 ;
___8.538__delay:		DELAY  8.538 ;
___8.703__delay:		DELAY  8.703 ;
___8.516__delay:		DELAY  8.516 ;
_12.313__12.059__delay:		DELAY 12.313 12.059 ;
_12.510__12.299__delay:		DELAY 12.510 12.299 ;
_13.393__13.138__delay:		DELAY 13.393 13.138 ;
_13.045__12.720__delay:		DELAY 13.045 12.720 ;
_12.988__12.691__delay:		DELAY 12.988 12.691 ;
_13.466__13.116__delay:		DELAY 13.466 13.116 ;
_13.472__13.123__delay:		DELAY 13.472 13.123 ;
_12.537__12.302__delay:		DELAY 12.537 12.302 ;
_12.922__12.689__delay:		DELAY 12.922 12.689 ;
_12.437__12.189__delay:		DELAY 12.437 12.189 ;

ENDMODEL
