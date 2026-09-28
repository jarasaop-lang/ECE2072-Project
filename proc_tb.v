`timescale 1ns/1ns
/*
Monash University ECE2072: Assignment 
This file contains a Verilog test bench to test the correctness of the processor.

Please enter your student ID:

*/
module proc_tb;
	
	wire [15:0] actual_registers [0:7];
	reg clk, rst;
	reg [8:0] din;
	
	wire [3:0] tick;
	wire [15:0] bus; 
	
	
	
	
	
	//instantiate the module here
	simple_proc testing_processor(
		.R0(actual_registers[0]), .R1(actual_registers[1]), .R2(actual_registers[2]), .R3(actual_registers[3]), .R4(actual_registers[4]), .R5(actual_registers[5]), .R6(actual_registers[6]), .R7(actual_registers[7]),
		.bus(bus),
		.rst(rst),
		.clk(clk),
		.tick(tick),
		.din(din)
	);
	

	//initialise the shadow variables
	reg [15:0] expected_registers [0:7];
	reg [8:0] immediate;
	reg [15:0] sign_extended_immediate;
	
	//initialising the parameters
	parameter ADD = 3'b001, SUB = 3'b011, ADDI = 3'b010, MOVI = 3'b111;
	localparam R1 = 3'd1, R2 = 3'd2, R3 = 3'd3, R4 = 3'd4, R5 = 3'd5, R6 = 3'd6, R7 = 3'd7;
	
	
	//initialise the seed and pass registers
	integer seed; 
	integer pass_count, fail_count;
	integer iterator;
	
	
	
	reg [2:0] RX, RY;
	
	
	//Logic for all type 1 instructions
	task type_1_instructions;
		input [2:0] opcode;
		input [2:0] rx;
		input [2:0] ry;
		integer type_1_i;
		
			begin
			
			case(opcode)
		
				ADD: expected_registers[rx] = expected_registers[rx] + expected_registers[ry];
				SUB: expected_registers[rx] = expected_registers[rx] - expected_registers[ry];
				default: begin
					$display("Fail, invalid OPCODE used: Expected opcode = %d or %d, opcode, immediate, rx, expected_registers[type_2_i], actual_registers[type_2_i]);
				end
				
			endcase
			
			//tick 1
			@(negedge clk);
			din = {opcode, rx, ry};
			@(posedge clk);
					
			//tick 2 
			@(negedge clk);
			din = $random(seed);
			@(posedge clk);
					
			//tick 3, loading junk values for din
			@(negedge clk);
			din = $random(seed);
			@(posedge clk);
					
			//tick 4
			@(negedge clk);
			din = $random(seed);
			@(posedge clk);
			
			#1;
			
			
			//register checks --> cycle through all the registers 
			
			for (type_1_i = 0; type_1_i < 8; type_1_i = type_1_i + 1) begin
				if (expected_registers[type_1_i] !== actual_registers[type_1_i]) begin
					$display("Fail Type 1: opcode = %d, RY = %d: Selected RX Register: %d Register Expected = %b, Register Actual = %b", opcode, ry, rx, expected_registers[type_1_i], actual_registers[type_1_i] );
					fail_count = fail_count + 1;	
				end
					
				else begin
					$display("Pass Type 1: opcode = %d, RY = %d: Selected RX Register: %d Register Expected = %b, Register Actual = %b", opcode, ry, rx, expected_registers[type_1_i], actual_registers[type_1_i]);
					pass_count = pass_count + 1;
				end			
			
			end
		end
	
	endtask
	
	
	//logic for all type 2 instructions
	task type_2_instructions;
		input [2:0] opcode;
		input [2:0] rx;
		input [8:0] immediate;
		integer type_2_i;
		
		begin
		
			sign_extended_immediate = {{7{immediate[8]}}, immediate};
			//assigning the right operation per op code 
			case(opcode)
				MOVI: expected_registers[rx] = $signed(sign_extended_immediate);
				ADDI: expected_registers[rx] = expected_registers[rx] + $signed(sign_extended_immediate);
				default: ;
				
			endcase
			
			//tick 1
			@(negedge clk);
			din = {opcode, rx, 3'b000};
			@(posedge clk);
					
			//tick 2 
			@(negedge clk);
			din = immediate;
			@(posedge clk);
					
			//tick 3, loading junk values for din
			@(negedge clk);
			din = $random(seed);
			@(posedge clk);
					
			//tick 4
			@(negedge clk);
			din = $random(seed);
			@(posedge clk);
			
			#1;
			
			//register checks --> cycle through all the registers 
			for (type_2_i = 0; type_2_i < 8; type_2_i = type_2_i + 1) begin
				if (expected_registers[type_2_i] !== actual_registers[type_2_i]) begin
					$display("Fail Type 2: opcode = %d, immediate = %d: Selected Register: %d Register Expected = %b, Register Actual = %b", opcode, immediate, rx, expected_registers[type_2_i], actual_registers[type_2_i] );
					fail_count = fail_count + 1;
				end
					
				else begin
					$display("Pass Type 2: opcode = %d, immediate = %d: Selected Register: %d Register Expected = %b, Register Actual = %b", opcode, immediate, rx, expected_registers[type_2_i], actual_registers[type_2_i]);
					pass_count = pass_count + 1;
					
				end			
			
			end
		end
	
	endtask
	
	
	task edge_cases;
	

		begin
			// directed edge cases
			
			//testing that the boundaries are 16 bits
			type_2_instructions(MOVI, R1, 9'h0FF); //testing 0 extension
			type_2_instructions(MOVI, R1, 9'h100); //testing 1 extention
			
			//testing a negative immediate values through the ALU path
			type_2_instructions(MOVI, R1, 9'h1FF); // should equal FF00 - 1
			
			
			//Testing the output of a negative subtraction result
			type_2_instructions(MOVI, R2, 9'd5);
			type_2_instructions(MOVI, R3, 9'd9);
			type_1_instructions(SUB, R2, R3); //results in R2 - R3 = 5 - 9 = -4
		
			
			//Testing when the registers are equivalent
			type_1_instructions(SUB, R3, R3); //result should be 0
			type_1_instructions(SUB, R2, R2); //result should be -4 + -4 = -8
			
			
			//Testing a single wrap around instance (FFFF to 0000)
			type_2_instructions(MOVI, R4, 9'h1FF);
			type_2_instructions(MOVI, R4, 9'd1);
			

			//final test for sweeps --> checking if Rin works for each register --> each value is checked against all registers to ensure it's working
			//Movi tests Rin writing for tick 2, Add tests Rin writing for tick 4
			//Add tests both reading functions (having values placed into the ALU and A registers), and the writing function (writing register G to the desired RX register)
			
			
		end
	
	
	
	
	
	
	
	
	endtask
	
	
	
	
	
	
	//starting the clock
	always begin
		#5;
		clk = ~clk;
	end
	
	
	initial begin
	//initialising all values
	pass_count = 0;
	fail_count = 0;
	clk = 0;
	seed = 4;
	RX = $random(seed);
	RY = $random(seed);
	immediate = $random(seed);
	
	
	//resetting the simple processor
	rst = 1;
	@(posedge clk);
	@(posedge clk); 
	#1
	rst = 0;
	
	//initialising all registers to 0
	
	for (iterator = 0; iterator < 8; iterator = iterator + 1) begin
		expected_registers[iterator] = 16'd0;	
	end
	
	

	
	
	for (iterator = 0; iterator < 2000; iterator = iterator  + 1) begin
		RX = $random(seed);
		RY = $random(seed);
		immediate = $random(seed);
		type_2_instructions(MOVI, RX, immediate);
		//setting the next register to a different value
		immediate = $random(seed);
		type_2_instructions(MOVI, RY, immediate);
		type_1_instructions(ADD, RX, RY);
		type_2_instructions(ADDI, RX, immediate);
		type_1_instructions(SUB, RX, RY);
	
	
	end
	
	
	



	
    // TODO: Implement the logic of your testbench here
	 
	 //instantiate inputs and outputs of processor --> array with the 4 required op codes, and a 6 bit array to increment by 1 for required values
	 
	 //instantiate processor
	 
	 //initial begin --> set values to 0/default --> test bench is uses blocking and no clock values
	 
	 
	 //for loop to initialise register values (default random ones by multiplying -i * 6'h1B
	 
	 
	 /*for loop testing all combinations in the 6 bits for each of the 4 ticks for the 4 op codes 
	 --> bus output value tested at each tick --> if(tick == x), calculate expected then compare at bottom of all loops
	 
	 */

endmodule