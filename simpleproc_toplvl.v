simple_proc_top(
	 input [8:0] SW;
	 input [1:0] KEY;
	 output [9:0] LEDR;
	 output [6:0] HEX5;
	 );
	 
	 wire [3:0] tk;
	 wire [15:0] bus;
	 
	 simple_proc(
		 .din(SW[8:0]),
		 .bus(bus),
		 .clk(~KEY[1]),
		 .rst(~KEY[0])
	 );
	 
	 tick_FSM(
		 .clk(~KEY[1]),
		 .rst(~KEY[0]),
		 .enable(1'b1),
		 .tick(tk)
	 );
	 
	 BCD(
		 .tk(tk),
		 .tkhex(~HEX5)
	 );
	 
	 assign LEDR = bus[9:0];
	 
endmodule 
		 
		 
	 
		 
		 