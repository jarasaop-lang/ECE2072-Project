module simple_proc_top(
	 input [8:0] SW,
	 input [1:0] KEY,
	 output [9:0] LEDR,
	 output [6:0] HEX5
	 );
	 
	 wire [3:0] tk;
	 wire [15:0] bus;
	 wire [6:0] hex5_inversion;
	 
	 simple_proc p1(
		 .din(SW[8:0]),
		 .bus(bus),
		 .clk(~KEY[1]),
		 .rst(~KEY[0]),
		 .tick(tk)
	 );
	 
	 
	 BCD_tickfsm b1(
		 .tk(tk),
		 .tkhex(hex5_inversion)
	 );
	 
	 assign LEDR = bus[9:0];
	 assign HEX5 = hex5_inversion;
	 
endmodule 
		 
		 
	 
		 
		 