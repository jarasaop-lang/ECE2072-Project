// Turn the tick pattern into digits 1-4. Here, 1 means a segment should light;
// the top level flips these bits because the board lights segments with 0.
module BCD_tickfsm(
	 input [3:0] tk,
	 output reg [6:0] tkhex 
	 );
	 
	 parameter T1 = 4'b0001, T2 = 4'b0010, T3 = 4'b0100, T4 = 4'b1000;
	 
	 reg a, b, c, d, e, f, g;
	 
	 
	 always @(*) begin
		 if (tk == T1) {a, b, c, d, e, f, g} = 7'b0110000;
		 else if (tk == T2) {a, b, c, d, e, f, g} = 7'b1101101;
		 else if (tk == T3) {a, b, c, d, e, f, g} = 7'b1111001;
		 else if (tk == T4) {a, b, c, d, e, f, g} = 7'b0110011;	
		 else {a, b, c, d, e, f, g} = 7'd0;
	 end 
	 always @(*) begin
		 tkhex = {g, f, e, d, c, b, a};
	 end 
	 
endmodule 
		 
	 