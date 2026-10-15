/*
Monash University ECE2072: Assignment 
This file contains Verilog code to instantiate the UART communication extended version of CPU.

Please enter your student ID: 34977635

*/


// Board wiring: KEY0 resets, KEY1 steps, SW9 enables, and SW8:0 supply instruction/data.
// GPIO[1] transmits and GPIO[0] receives; both UART modules use CLOCK_50.
module proc_communication_top_lvl(
	 input [9:0] SW,
	 input [1:0] KEY,
	 input CLOCK_50,
<<<<<<< HEAD
	 input RX,
	 output TX,
=======
	 inout [1:0] GPIO, 
>>>>>>> 0a4c2dc4a3db508e6d7e66666e728dc23f58c3d2
	 output [9:0] LEDR,
	 output [7:0] HEX5,
	 output [7:0] HEX4,
	 output [7:0] HEX3,
	 output [7:0] HEX2,
	 output [7:0] HEX1,
	 output [7:0] HEX0
	 );
	 
	 wire [3:0] tk;
	 wire [15:0] bus;
     wire [15:0] display_value;
	 wire [6:0] hex5_inversion;

	 
    // Synchronize physical switches and reset into the sole clock domain.
    // Set all instruction/data switches before pressing the step button.
    
    reg [9:0] sw_meta, sw_sync;
    
    reg reset_meta, reset_sync;
    always @(posedge CLOCK_50) begin
        sw_meta <= SW;
        sw_sync <= sw_meta;
        reset_meta <= ~KEY[0];
        reset_sync <= reset_meta;
    end

	 simple_proc_communication pe1(
		 .din(sw_sync[8:0]),
		 .bus(bus),
		 .clk_50(CLOCK_50),
		 .RXin(RX),
		 .tx(TX),
        .display(display_value),
		 .clk(~KEY[1]),
		 .rst(reset_sync),
		 .tick(tk),
		 .enable(sw_sync[9]),
		 .val5(hex5_inversion),
		 .val4(HEX4),
		 .val3(HEX3),
		 .val2(HEX2),
		 .val1(HEX1),
		 .val0(HEX0)
	 );
	 
	 

	 
	 
    // LEDs show the current bus, not a permanently selected register.
    // A 0 lights a display segment. HEX5 shows the tick; its dot shows the number sign.
	 assign LEDR = bus[9:0];
	 assign HEX5 = {~display_value[15], ~hex5_inversion};
	 
endmodule 
		 
		 