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
 with speed grade 7, core voltage 1.2V, and temperature 85 Celsius

*/
MODEL_VERSION "1.0";
DESIGN "x72";
DATE "10/15/2026 21:29:36";
PROGRAM "Quartus Prime";



INPUT KEY[0];
INPUT CLOCK_50;
INPUT SW[6];
INPUT KEY[1];
INPUT SW[9];
INPUT SW[7];
INPUT SW[8];
INPUT SW[1];
INPUT SW[4];
INPUT SW[5];
INPUT SW[3];
INPUT SW[0];
INPUT SW[2];
INPUT RX;
OUTPUT TX;
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
pos_KEY[0]__CLOCK_50__setup:		SETUP (POSEDGE) KEY[0] CLOCK_50 ;
pos_KEY[1]__CLOCK_50__setup:		SETUP (POSEDGE) KEY[1] CLOCK_50 ;
pos_RX__CLOCK_50__setup:		SETUP (POSEDGE) RX CLOCK_50 ;
pos_SW[0]__CLOCK_50__setup:		SETUP (POSEDGE) SW[0] CLOCK_50 ;
pos_SW[1]__CLOCK_50__setup:		SETUP (POSEDGE) SW[1] CLOCK_50 ;
pos_SW[2]__CLOCK_50__setup:		SETUP (POSEDGE) SW[2] CLOCK_50 ;
pos_SW[3]__CLOCK_50__setup:		SETUP (POSEDGE) SW[3] CLOCK_50 ;
pos_SW[4]__CLOCK_50__setup:		SETUP (POSEDGE) SW[4] CLOCK_50 ;
pos_SW[5]__CLOCK_50__setup:		SETUP (POSEDGE) SW[5] CLOCK_50 ;
pos_SW[6]__CLOCK_50__setup:		SETUP (POSEDGE) SW[6] CLOCK_50 ;
pos_SW[7]__CLOCK_50__setup:		SETUP (POSEDGE) SW[7] CLOCK_50 ;
pos_SW[8]__CLOCK_50__setup:		SETUP (POSEDGE) SW[8] CLOCK_50 ;
pos_SW[9]__CLOCK_50__setup:		SETUP (POSEDGE) SW[9] CLOCK_50 ;
pos_KEY[0]__CLOCK_50__hold:		HOLD (POSEDGE) KEY[0] CLOCK_50 ;
pos_KEY[1]__CLOCK_50__hold:		HOLD (POSEDGE) KEY[1] CLOCK_50 ;
pos_RX__CLOCK_50__hold:		HOLD (POSEDGE) RX CLOCK_50 ;
pos_SW[0]__CLOCK_50__hold:		HOLD (POSEDGE) SW[0] CLOCK_50 ;
pos_SW[1]__CLOCK_50__hold:		HOLD (POSEDGE) SW[1] CLOCK_50 ;
pos_SW[2]__CLOCK_50__hold:		HOLD (POSEDGE) SW[2] CLOCK_50 ;
pos_SW[3]__CLOCK_50__hold:		HOLD (POSEDGE) SW[3] CLOCK_50 ;
pos_SW[4]__CLOCK_50__hold:		HOLD (POSEDGE) SW[4] CLOCK_50 ;
pos_SW[5]__CLOCK_50__hold:		HOLD (POSEDGE) SW[5] CLOCK_50 ;
pos_SW[6]__CLOCK_50__hold:		HOLD (POSEDGE) SW[6] CLOCK_50 ;
pos_SW[7]__CLOCK_50__hold:		HOLD (POSEDGE) SW[7] CLOCK_50 ;
pos_SW[8]__CLOCK_50__hold:		HOLD (POSEDGE) SW[8] CLOCK_50 ;
pos_SW[9]__CLOCK_50__hold:		HOLD (POSEDGE) SW[9] CLOCK_50 ;
pos_CLOCK_50__HEX0[0]__delay:		DELAY (POSEDGE) CLOCK_50 HEX0[0] ;
pos_CLOCK_50__HEX0[1]__delay:		DELAY (POSEDGE) CLOCK_50 HEX0[1] ;
pos_CLOCK_50__HEX0[2]__delay:		DELAY (POSEDGE) CLOCK_50 HEX0[2] ;
pos_CLOCK_50__HEX0[3]__delay:		DELAY (POSEDGE) CLOCK_50 HEX0[3] ;
pos_CLOCK_50__HEX0[4]__delay:		DELAY (POSEDGE) CLOCK_50 HEX0[4] ;
pos_CLOCK_50__HEX0[5]__delay:		DELAY (POSEDGE) CLOCK_50 HEX0[5] ;
pos_CLOCK_50__HEX0[6]__delay:		DELAY (POSEDGE) CLOCK_50 HEX0[6] ;
pos_CLOCK_50__HEX0[7]__delay:		DELAY (POSEDGE) CLOCK_50 HEX0[7] ;
pos_CLOCK_50__HEX1[0]__delay:		DELAY (POSEDGE) CLOCK_50 HEX1[0] ;
pos_CLOCK_50__HEX1[1]__delay:		DELAY (POSEDGE) CLOCK_50 HEX1[1] ;
pos_CLOCK_50__HEX1[2]__delay:		DELAY (POSEDGE) CLOCK_50 HEX1[2] ;
pos_CLOCK_50__HEX1[3]__delay:		DELAY (POSEDGE) CLOCK_50 HEX1[3] ;
pos_CLOCK_50__HEX1[4]__delay:		DELAY (POSEDGE) CLOCK_50 HEX1[4] ;
pos_CLOCK_50__HEX1[5]__delay:		DELAY (POSEDGE) CLOCK_50 HEX1[5] ;
pos_CLOCK_50__HEX1[6]__delay:		DELAY (POSEDGE) CLOCK_50 HEX1[6] ;
pos_CLOCK_50__HEX1[7]__delay:		DELAY (POSEDGE) CLOCK_50 HEX1[7] ;
pos_CLOCK_50__HEX2[0]__delay:		DELAY (POSEDGE) CLOCK_50 HEX2[0] ;
pos_CLOCK_50__HEX2[1]__delay:		DELAY (POSEDGE) CLOCK_50 HEX2[1] ;
pos_CLOCK_50__HEX2[2]__delay:		DELAY (POSEDGE) CLOCK_50 HEX2[2] ;
pos_CLOCK_50__HEX2[3]__delay:		DELAY (POSEDGE) CLOCK_50 HEX2[3] ;
pos_CLOCK_50__HEX2[4]__delay:		DELAY (POSEDGE) CLOCK_50 HEX2[4] ;
pos_CLOCK_50__HEX2[5]__delay:		DELAY (POSEDGE) CLOCK_50 HEX2[5] ;
pos_CLOCK_50__HEX2[6]__delay:		DELAY (POSEDGE) CLOCK_50 HEX2[6] ;
pos_CLOCK_50__HEX2[7]__delay:		DELAY (POSEDGE) CLOCK_50 HEX2[7] ;
pos_CLOCK_50__HEX3[0]__delay:		DELAY (POSEDGE) CLOCK_50 HEX3[0] ;
pos_CLOCK_50__HEX3[1]__delay:		DELAY (POSEDGE) CLOCK_50 HEX3[1] ;
pos_CLOCK_50__HEX3[2]__delay:		DELAY (POSEDGE) CLOCK_50 HEX3[2] ;
pos_CLOCK_50__HEX3[3]__delay:		DELAY (POSEDGE) CLOCK_50 HEX3[3] ;
pos_CLOCK_50__HEX3[4]__delay:		DELAY (POSEDGE) CLOCK_50 HEX3[4] ;
pos_CLOCK_50__HEX3[5]__delay:		DELAY (POSEDGE) CLOCK_50 HEX3[5] ;
pos_CLOCK_50__HEX3[6]__delay:		DELAY (POSEDGE) CLOCK_50 HEX3[6] ;
pos_CLOCK_50__HEX3[7]__delay:		DELAY (POSEDGE) CLOCK_50 HEX3[7] ;
pos_CLOCK_50__HEX4[0]__delay:		DELAY (POSEDGE) CLOCK_50 HEX4[0] ;
pos_CLOCK_50__HEX4[1]__delay:		DELAY (POSEDGE) CLOCK_50 HEX4[1] ;
pos_CLOCK_50__HEX4[2]__delay:		DELAY (POSEDGE) CLOCK_50 HEX4[2] ;
pos_CLOCK_50__HEX4[3]__delay:		DELAY (POSEDGE) CLOCK_50 HEX4[3] ;
pos_CLOCK_50__HEX4[4]__delay:		DELAY (POSEDGE) CLOCK_50 HEX4[4] ;
pos_CLOCK_50__HEX4[5]__delay:		DELAY (POSEDGE) CLOCK_50 HEX4[5] ;
pos_CLOCK_50__HEX4[6]__delay:		DELAY (POSEDGE) CLOCK_50 HEX4[6] ;
pos_CLOCK_50__HEX4[7]__delay:		DELAY (POSEDGE) CLOCK_50 HEX4[7] ;
pos_CLOCK_50__HEX5[0]__delay:		DELAY (POSEDGE) CLOCK_50 HEX5[0] ;
pos_CLOCK_50__HEX5[1]__delay:		DELAY (POSEDGE) CLOCK_50 HEX5[1] ;
pos_CLOCK_50__HEX5[2]__delay:		DELAY (POSEDGE) CLOCK_50 HEX5[2] ;
pos_CLOCK_50__HEX5[3]__delay:		DELAY (POSEDGE) CLOCK_50 HEX5[3] ;
pos_CLOCK_50__HEX5[4]__delay:		DELAY (POSEDGE) CLOCK_50 HEX5[4] ;
pos_CLOCK_50__HEX5[5]__delay:		DELAY (POSEDGE) CLOCK_50 HEX5[5] ;
pos_CLOCK_50__HEX5[6]__delay:		DELAY (POSEDGE) CLOCK_50 HEX5[6] ;
pos_CLOCK_50__HEX5[7]__delay:		DELAY (POSEDGE) CLOCK_50 HEX5[7] ;
pos_CLOCK_50__LEDR[0]__delay:		DELAY (POSEDGE) CLOCK_50 LEDR[0] ;
pos_CLOCK_50__LEDR[1]__delay:		DELAY (POSEDGE) CLOCK_50 LEDR[1] ;
pos_CLOCK_50__LEDR[2]__delay:		DELAY (POSEDGE) CLOCK_50 LEDR[2] ;
pos_CLOCK_50__LEDR[3]__delay:		DELAY (POSEDGE) CLOCK_50 LEDR[3] ;
pos_CLOCK_50__LEDR[4]__delay:		DELAY (POSEDGE) CLOCK_50 LEDR[4] ;
pos_CLOCK_50__LEDR[5]__delay:		DELAY (POSEDGE) CLOCK_50 LEDR[5] ;
pos_CLOCK_50__LEDR[6]__delay:		DELAY (POSEDGE) CLOCK_50 LEDR[6] ;
pos_CLOCK_50__LEDR[7]__delay:		DELAY (POSEDGE) CLOCK_50 LEDR[7] ;
pos_CLOCK_50__LEDR[8]__delay:		DELAY (POSEDGE) CLOCK_50 LEDR[8] ;
pos_CLOCK_50__LEDR[9]__delay:		DELAY (POSEDGE) CLOCK_50 LEDR[9] ;
pos_CLOCK_50__TX__delay:		DELAY (POSEDGE) CLOCK_50 TX ;

ENDMODEL
