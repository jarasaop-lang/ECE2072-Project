`timescale 1ns/1ns
/*
Monash University ECE2072: Assignment 
This file contains a Verilog test bench to test the correctness of the extended processor.

Please enter your student ID: 36138568

*/
module proc_extension_tb;
    // TODO: Implement the logic of your testbench here
	
	wire [15:0] actual_registers [0:7];
	wire [15:0] actual_display;
	wire [7:0] bcd_registers [0:4];
	wire [6:0] bcd_tick;
	wire [3:0] tick;
	wire [15:0] bus;
	
	reg clk, rst, enable;
	reg [8:0] din;
	
 

	
	//instantiate the module here
	simple_procext testing_processor(
		.R0(actual_registers[0]), .R1(actual_registers[1]), .R2(actual_registers[2]), .R3(actual_registers[3]), .R4(actual_registers[4]), .R5(actual_registers[5]), .R6(actual_registers[6]), .R7(actual_registers[7]),
		.val0(bcd_registers[0]), .val1(bcd_registers[1]), .val2(bcd_registers[2]), .val3(bcd_registers[3]), .val4(bcd_registers[4]), .val5(bcd_tick),
		.enable(enable),
		.bus(bus),
		.rst(rst),
		.clk(clk),
		.tick(tick),
		.din(din),
		.display(actual_display)
	);
	

	//initialise the shadow variables
	reg [15:0] expected_registers [0:7];
	reg [15:0] expected_display;
	reg [8:0] immediate;
	reg [15:0] sign_extended_immediate;
	
	//initialising the parameters
	parameter ADD = 3'b001, SUB = 3'b011, ADDI = 3'b010, MOVI = 3'b111, DISP = 3'b000, SSI = 3'd5, MUL = 3'd4;
	localparam R1 = 3'd1, R2 = 3'd2, R3 = 3'd3, R4 = 3'd4, R5 = 3'd5, R6 = 3'd6, R7 = 3'd7;
	
	
	//initialise the seed and pass registers
	integer seed; 
	integer pass_count, fail_count;
	integer iterator;
	integer accept_pass_messages;
	
	
	
	
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
				MUL: expected_registers[rx] = expected_registers[rx] * expected_registers[ry];
				DISP: expected_display = expected_registers[rx];
				
				default: begin
					$display("Fail Type 1: invalid OPCODE used: %d. Expected opcodes = %d, %d, %d, %d", opcode,ADD, SUB, MUL, DISP);
				end
				
			endcase
			
			
			//tick 1
			@(negedge clk);
			din = {opcode, rx, ry};
			@(posedge clk);
					
			//tick 2 
			// synopsys translate_off
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
			// synopsys translate_on
			@(posedge clk);
			
			
			#1;
			
			
			//register checks --> cycle through all the registers 
			
			for (type_1_i = 0; type_1_i < 8; type_1_i = type_1_i + 1) begin
				if (expected_registers[type_1_i] !== actual_registers[type_1_i]) begin
					$display("Fail Type 1: opcode = %d, RY = %d: Selected RX Register: %d Register Expected = %b, Register Actual = %b", opcode, ry, rx, expected_registers[type_1_i], actual_registers[type_1_i] );
					fail_count = fail_count + 1;	
				end
					
				else begin
					//only Accept pass messages for edge cases
					if (accept_pass_messages) begin
						$display("Pass Type 1: opcode = %d, RY = %d: Selected RX Register: %d Register Expected = %b, Register Actual = %b", opcode, ry, rx, expected_registers[type_1_i], actual_registers[type_1_i]);
						end
					pass_count = pass_count + 1;
				end			
			end
			
			
			//Check for the Display vs Expected_delay register
			if (expected_display !== actual_display) begin
				$display("Fail Type 1 Display: opcode = %d, RY = %d: Selected RX Register: %d, Display Expected = %b, Display Actual = %b", opcode, ry, rx, expected_display, actual_display);
				fail_count = fail_count + 1;
			end else begin
				if (accept_pass_messages) begin
					$display("Pass Type 1 Display: opcode = %d, RY = %d: Selected RX Register: %d Display Expected = %b, Display Actual = %b", opcode, ry, rx, expected_display, actual_display);
				end
				pass_count = pass_count + 1;
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
				SSI: begin	
							if(sign_extended_immediate[15]) begin 
								expected_registers[rx] = expected_registers[rx] >> $signed(sign_extended_immediate) * -1;
							end 
							else begin
								expected_registers[rx] = expected_registers[rx] << $signed(sign_extended_immediate);
							end
					  end
							
				default: begin
					$display("Fail Type 2: invalid OPCODE used: %d. Expected opcodes = %d, %d, %d", opcode, MOVI, ADDI, SSI);
				end
				
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
			// synopsys translate_off
			@(negedge clk);
			din = $random(seed);
			@(posedge clk);
					
			//tick 4
			@(negedge clk);
			din = $random(seed);
			// synopsys translate_on
			@(posedge clk);
			
			
			#1;
			
			//register checks --> cycle through all the registers 
			for (type_2_i = 0; type_2_i < 8; type_2_i = type_2_i + 1) begin
				if (expected_registers[type_2_i] !== actual_registers[type_2_i]) begin
					$display("Fail Type 2: opcode = %d, immediate = %d: Selected Register: %d Register Expected = %b, Register Actual = %b", opcode, immediate, rx, expected_registers[type_2_i], actual_registers[type_2_i]);
					fail_count = fail_count + 1;
				end
					
				else begin
					//only Accept pass messages for edge cases
					if (accept_pass_messages) begin
						$display("Pass Type 2: opcode = %d, immediate = %d: Selected Register: %d Register Expected = %b, Register Actual = %b", opcode, immediate, rx, expected_registers[type_2_i], actual_registers[type_2_i]);
					end
					pass_count = pass_count + 1;
				end			
			end
			
			//Check for the Display vs Expected_delay register
			if (expected_display !== actual_display) begin
				$display("Fail Type 2 Display: opcode = %d, immediate = %d: Selected Register: %d Display Expected = %b, Display Actual = %b", opcode, immediate, rx, expected_display, actual_display);
				fail_count = fail_count + 1;
			end else begin
				if (accept_pass_messages) begin
					$display("Pass Type 2 Display: opcode = %d, immediate = %d: Selected Register: %d Display Expected = %b, Display Actual = %b", opcode, immediate, rx, expected_display, actual_display);
				end
				pass_count = pass_count + 1;
			end
		end
	
	endtask
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	//logic for all the edge cases
	task edge_cases;
	
		integer edge_iterator;
		
		begin
			accept_pass_messages = 1;
			
			
			//DIRECTED EDGE 
			
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
			type_1_instructions(SUB, R2, R2); //result should be -4 - (-4) = 0
			
			
			//Testing a single wrap around instance (FFFF to 0000)
			type_2_instructions(MOVI, R4, 9'h1FF);
			type_2_instructions(MOVI, R4, 9'd1);
			

			//final test for sweeps --> checking if Rin works for each register --> each value is checked against all registers to ensure it's working
			//Movi tests Rin writing for tick 2, Add tests Rin writing for tick 4
			//Add tests both reading functions (having values placed into the ALU and A registers), and the writing function (writing register G to the desired RX register)
			for (edge_iterator = 0; edge_iterator < 8; edge_iterator = edge_iterator + 1) begin
				type_2_instructions(MOVI, edge_iterator[2:0], {edge_iterator[2:0], 6'h15}); //tests random, unique, immediate values and each register
			
			end
			
			for (edge_iterator = 0; edge_iterator < 8; edge_iterator = edge_iterator + 1) begin
				type_1_instructions(ADD, edge_iterator[2:0], edge_iterator[2:0] + 3'b1) ; //Making Rin work for Tick 3 and 4; reading and writing register actions checked 
			
			end
			
			
			
			//DISPLAY EDGE CASES/CHECKS
			
			//sweep to check expected_delay = actual_delay for every register; also checking RY is ignored 
			for (edge_iterator = 0; edge_iterator < 8; edge_iterator = edge_iterator + 1) begin
				type_1_instructions(DISP, edge_iterator[2:0], edge_iterator[2:0] + 3'b1);
			end
			
			
			//explicit check Display doesnt get changed after the register value changes: move 7 into R1, display R1, move 20 into R1  
			type_2_instructions(MOVI, 3'd1, 9'd7);
			type_1_instructions(DISP, 3'd1, 3'd5);
			type_2_instructions(MOVI, 3'd1, 9'd20);
			
			//check a negative value is displayed correctly and - again - a non-zero RY
			type_2_instructions(MOVI, 3'd3, -9'd5);
			type_1_instructions(DISP, 3'd3, 3'd4); //should display -5
			
			
			
			//SHIFT TESTS
			
			//check of a positive shift and a manual check that R1 is now 12 (3 shifted twice left is 12)
			type_2_instructions(MOVI, 3'd1, 9'd3);
			type_2_instructions(SSI, 3'd1, 9'd2);
			if (actual_registers[1] !== 16'd12) begin
				$display("Explicit Shift Test Fail: Chosen Register: %d, Expected Value: %d, Actual Value: %d", 3'd1, 16'd12, actual_registers[1]);
				fail_count = fail_count + 1;
			end
			else begin
				pass_count = pass_count + 1;
			end
			
			//negative shift: value from go from 12 back to 3 
			type_2_instructions(SSI, 3'd1, -9'd2);
			
			
			
			//MULTIPLCATION TESTS
			
			
			//Explicit Multiplication Routing: output should yeild 3 * 5 = 15
			type_2_instructions(MOVI, 3'd0, 9'd3);
			type_2_instructions(MOVI, 3'd1, 9'd5);
			type_1_instructions(MUL, 3'd0, 3'd1);
			
			
			//Signed Multiplcation Test and a manual check that R2 is now -36; output should yeild -3*12 = -36
			type_2_instructions(MOVI, 3'd2, -9'd3);
			type_2_instructions(MOVI, 3'd3, 9'd12);
			type_1_instructions(MUL, 3'd2, 3'd3);
			if (actual_registers[2] !== -16'd36) begin
				$display("Explicit Multiplication Test Fail: Chosen Register: %d, Expected Value: %d, Actual Value: %d", 3'd2, -16'd36, actual_registers[2]);
				fail_count = fail_count + 1;
			end
			else begin
				pass_count = pass_count + 1;
			end
			
			
			
			//turning off pass messaging so we can validate failed attempts better
			accept_pass_messages = 0;
		end
	
	endtask
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	//Initialisation sections, running the edge cases and random seed sweep
	
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
	RX = 3'd0;
	RY = 3'd0;
	immediate = 9'd0;
	accept_pass_messages = 0;
	expected_display = 16'd0;
	
	
	//resetting the simple processor
	rst = 1'd1;
	enable = 1'd1;
	@(posedge clk);
	@(posedge clk); 
	#1
	rst = 0;
	
	//initialising all registers to 0
	
	for (iterator = 0; iterator < 8; iterator = iterator + 1) begin
		expected_registers[iterator] = 16'd0;	
	end
	
	
	edge_cases();
	
	// synopsys translate_off
	for (iterator = 0; iterator < 2000; iterator = iterator  + 1) begin
		RX = $random(seed);
		RY = $random(seed);
		immediate = $random(seed);
		type_2_instructions(MOVI, RX, immediate);
		
		//setting the next register to a different value
		immediate = $random(seed);
		type_2_instructions(MOVI, RY, immediate);
		type_1_instructions(ADD, RX, RY);
		
		//Adding another random value as an immediate; different immediates are used to test type 2 instructions
		immediate = $random(seed);
		
		type_2_instructions(ADDI, RX, immediate);
		type_1_instructions(SUB, RX, RY);
		type_1_instructions(MUL, RX, RY);
		type_1_instructions(DISP, RX, RY);
		
		//Setting a new immediate for the shift instruction
		immediate = $random(seed);
		type_2_instructions(SSI, RX, immediate);
		
	end
	// synopsys translate_on
	
	//Summary of Cases
	if (fail_count == 0) begin
		$display("Success. No errors were detected in the Extended Processor. Extended Processor Statistics are: Errors = %d, Passes = %d", fail_count, pass_count);
		end		
	else begin
		$display("Failure. Extended Processor Statistics are: Errors = %d, Passes = %d", fail_count, pass_count);
	end	
	
	$stop;
	end

endmodule
<<<<<<< HEAD

=======
>>>>>>> 0a4c2dc4a3db508e6d7e66666e728dc23f58c3d2
