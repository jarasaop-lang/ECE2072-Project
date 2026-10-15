/*
Monash University ECE2072: Assignment 
This file contains Verilog code to decode a 4 bit input to display a 7 segment single digit display.

Please enter your student ID: 34977635

*/
module BCD (
    input [3:0] data,
	 input neg,
    output [7:0] X
);
wire A, B, C, D;

assign A= data[3];
assign B = data[2];
assign C = data[1];
assign D = data[0];

assign X[0] = (~A & B & ~C & ~D)|(~A & ~B & ~C & D);
assign X[1] = (~A & B & ~C & D)|(~A & B & C & ~D);
assign X[2] = (~A & ~B & C & ~D);
assign X[3] = (~A & ~B & ~C & D)|(B & ~C & ~D)|(B & C & D);
assign X[4] = (~C|D)&(B|D);
assign X[5] = (C & D)|(~A & ~B & C)|(~A & ~B & D); 
assign X[6] = (~A & ~B & ~C)|(B & C & D);
assign X[7] = ~neg; // Decimal points are active-low on the DE10-Lite.

endmodule