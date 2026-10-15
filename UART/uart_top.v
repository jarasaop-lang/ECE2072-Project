module uart_top(
	input [7:0] SW,
   input [1:0] KEY,
   output [1:0] LEDR,
	input CLOCK_50

);
	uart_tx u1(
	.data(SW),
	.clk(CLOCK_50),
	.start(~KEY[0]),
	.reset(~KEY[1]),
	.tx(LEDR[0]),
	.busy(LEDR[1])
	);
endmodule 
	

	