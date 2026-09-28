module simple_proc_top(
	 input [8:0] SW,
	 input [1:0] KEY,
	 output [9:0] LEDR,
	 output [6:0] HEX5
	 );
	 
	 wire [3:0] tk;
	 wire [15:0] bus;
	 wire [6:0] hxi;
	 
	 
	 simple_proc p1(
		 .din(SW[8:0]),
		 .bus(bus),
		 .clk(~KEY[1]),
		 .rst(~KEY[0])
	 );
	 
	 tick_FSM t1(
		 .clk(~KEY[1]),
		 .rst(~KEY[0]),
		 .enable(1'b1),
		 .tick(tk)
	 );
	 
	 BCD_tickfsm b1(
		 .tk(tk),
		 .tkhex(hxi)
	 );
	 
	 assign LEDR = bus[9:0];
	 assign HEX5 = ~hxi[5:0];
	 
endmodule 
		 
		 
	 
		 
		 