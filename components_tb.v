`timescale 1ns/1ns
/*
Monash University ECE2072: Assignment 
This file contains a Verilog test bench to test the correctness of the individual 
    components used in the processor.

Please enter your student ID:

*/
module components_tb;
    // TODO: Implement the logic of your testbench here
	// TODO: Declare inputs and outputs
	//sign extend
	reg [8:0] in;
	wire [15:0] ext;
	reg [15:0] exp;
	integer cnt_sign, err_sign;
	
	//tick fsm
	reg clk, rst, enable;
	wire [3:0] tick;
	reg [3:0] val_en, val_rst, tick_exp;
	integer i, j, k;
	parameter t1 =1, t2=2, t3=4, t4=8;
	integer err_tick;
	
	//Multiplexer
	reg [15:0] registers [0:9]; 
	reg [3:0] sel;
	wire [15:0] Bus;
	
	
	//Register
	parameter NR = 16, NIR = 9;
	
	reg [2:0] control_bits; //First bit = rst, second = r_in
	
	reg [NR-1:0] data_in_16;
	wire [NR-1:0] Q_16;
	
	reg [NIR-1:0] data_in_9;
	wire [NIR-1:0] Q_9;
	
	
	
	
	sign_extend s1(
		 .in(in),
		 .ext(ext)
	);
	
	tick_FSM tick1(
		 .rst(rst),
		 .clk(clk),
		 .enable(enable),
		 .tick(tick)
		 
	);
	
	multiplexer mult1(
		.R0(registers[0]),
		.R1(registers[1]),
		.R2(registers[2]),
		.R3(registers[3]),
		.R4(registers[4]),
		.R5(registers[5]),
		.R6(registers[6]),
		.R7(registers[7]),
		.G(registers[8]),
		.SignExtDin(registers[9]),
		.sel(sel),
		.Bus(Bus)
		
	);
	
	
	register_n#(.N(NR)) register_16 (
		.data_in(data_in_16),
		.r_in(control_bits[0]),
		.clk(clk),
		.Q(Q_16),
		.rst((control_bits[1]))
	);
	
	register_n#(.N(NIR)) register_9 (
		.data_in(data_in_9),
		.r_in(control_bits[0]),
		.clk(clk),
		.Q(Q_9),
		.rst((control_bits[1]))
	);
	
	
	
	
	/*
	AI paragraph that justifies why a 4 bit register sufficiently tests the tick_FSM
	module. (For when we write the project)
	
Four-bit test vectors represent the values of enable and reset over four consecutive
clock cycles. A four-cycle window is used because the Tick FSM contains four states,
allowing a full state traversal when enabled continuously. Iterating both vectors 
from 0000 to 1111 tests all 256 possible enable/reset sequences over this window,
resulting in 1024 individual clock-cycle checks.

	*/
		 
	

	always begin
		#5;
		clk = ~clk;
	end
	

//sign_ext
	 initial begin
		 in = 0;
		 cnt_sign =0;		 
		 err_sign = 0;

		 for (cnt_sign = 0; cnt_sign < 512; cnt_sign = cnt_sign + 1) begin
			 #9;
			 exp = $signed(in);

			 if (exp != ext) begin
			       $display("[FAIL] Sign Extender | Test %0d | Input: %b | Expected: %b | Actual: %b | Time: %0t ns",
                         cnt_sign + 1, in, exp, ext, $time);
				
					 err_sign = err_sign + 1;
			 end

			 #1;
			 in = in + 1;
		 end

		 if (err_sign == 0)
			  $display("PASS Sign Extender | 512/512 input combinations passed");
		 else
			 $display("FAIL Sign Extender | %0d errors out of 512 tests", err_sign);

	 end

	
//tick_fsm

	initial begin
		 clk = 0;
		 val_en = 4'd0;
		 val_rst = 4'd0;
		 err_tick = 0;
		 
		 for(i=0; i< 16; i = i+1) begin
			 val_en = i;
			 
			 for(j= 0; j<16; j=j+1) begin
				 val_rst = j;
				 rst = 1;
				 enable = 0;
				 @(posedge clk);
				 #1;
				 tick_exp = t1;				 
				 
				 
				 for(k=0; k< 4; k = k+1) begin
					enable = val_en[k];
					rst = val_rst[k];
				
					@(posedge clk);
					#1;
					
					if(!rst) begin
						case(tick_exp)
							t1:
								if (enable) tick_exp = t2;
								else tick_exp = t1;
							t2: 
								if (enable) tick_exp = t3;
								else tick_exp = t2;
							t3: 
								if (enable) tick_exp = t4;
								else tick_exp = t3;
							t4:
								if (enable) tick_exp = t1;
								else tick_exp = t4;
							default: tick_exp = t1;
						endcase 
					end 
					else tick_exp = t1;
			
					if(tick_exp != tick) begin
						err_tick = err_tick+1;
						$display("FAIL Tick FSM | Test Sequence %0d | Clock Cycle %0d | Enable seq: %b | Rst seq: %b | EN: %b | RST: %b | Expected: %b | Actual: %b | Time: %0t ns",
									(i*16)+j+1, k+1, val_en, val_rst,
									enable, rst, tick_exp, tick, $time);
					end
				end 
			end
			if(err_tick == 0 ) begin
				$display("success");
			end
			else $display("Fail had %0d errors", err_tick);			

		end 
		
		
	end 
	
	
	
	//Multiplexer TB

	
	 integer mult_errors, mult_pass;
	 integer mi;
	 reg [15:0] mult_expected_output;
	 
	 // create and initialize your testbench statistics
    initial begin
        sel = 4'b0000;
		  mult_errors = 32'b0;
		  mult_pass = 32'b0;

		  
		  //initialising the multiplexer values
		  for (mi = 0; mi < 10; mi = mi + 1) begin
				//get random, legal, values by multiplying a 16 bit hex value
				registers[mi] = (mi+1) * 16'h1111;	
		  end
		  
    

    

			
		  //Go through each select line, calculate the expected output, compare and increment
		  for (mi = 0; mi < 16; mi = mi+1) begin
				#10
				
				sel = mi[3:0];
				mult_expected_output = (sel < 10) ? registers[mi] : 16'b0;
				
				#9;
				if (mult_expected_output == Bus) begin
					$display("Pass: Select Line = %b: Multiplexer Expected = %b, Bus = %b", sel, mult_expected_output, Bus);
					mult_pass = mult_pass + 1;
				end
				
				else if (mult_expected_output != Bus) begin
					$display("Fail: Select Line = %b: Multiplexer Expected = %b, Bus = %b, Test Sequence: %d", sel, mult_expected_output, Bus, mi+1);
					
					mult_errors = mult_errors + 1; 
				end
				#1;
			end
			
			
			
			if ((mult_errors + mult_pass) == 16) begin
			
				if (mult_errors == 0) begin
					$display("Success. No errors were detected in the Multiplexer Component");
				end
				
				else begin
					$display("Failure. Multiplexer Testbench Statistics are: Errors = %d, Passes = %d", mult_errors, mult_pass);
				end
		   end
		
		end

		
		
		//Register Taskbench
		
		
		integer r9_pass, r16_pass, r9_error, r16_error;
		reg [15:0] expected_16; 
		reg [8:0] expected_9;
		
		integer ri;
		
		initial begin 
		  r9_pass = 0;
		  r16_pass = 0;
		  r9_error = 0;
		  r16_error = 0;
		  expected_16 = 16'b0;
		  expected_9 = 9'b0;
		  data_in_16 = 16'b0;
		  data_in_9 = 9'b0;
		  
		  
		
			
		  control_bits = 2'b10;
		  //skips from t=0 --> t=11-15 period (negative edge)
		  @(posedge clk);
		  #1;
		  control_bits = 2'b00;
		 
		
	
		  for(ri =0; ri < 4; ri = ri + 1) begin
		  
				@(negedge clk);
				control_bits = ri[1:0];
				data_in_16 = 16'h11EB + ri;
				data_in_9 = 9'h0E1 + ri;
				
				
				if (control_bits[1]) begin
					expected_16 = 16'b0;
					expected_9 = 9'b0;
				
				end
				else if (control_bits[0]) begin
					expected_16 = data_in_16;
					expected_9 = data_in_9;
				end
				
				//00 will hold the previous value
				
				
				//Update to next reading
				@(posedge clk);
			   #1;
				
				//register 16 checks
				if (expected_16 == Q_16) begin
					$display("Pass R16: rst = %b, r_in = %b: Register16 Expected = %b, Q_16 = %b", control_bits[1], control_bits[0], expected_16, Q_16);
					r16_pass = r16_pass + 1;
				end
				
				else if (expected_16 != Q_16) begin
					$display("Fail R16: rst = %b, r_in = %b: Register16 Expected = %b, Q_16 = %b, count failed: %d, Time failed: %d", control_bits[1], control_bits[0], expected_16, Q_16, ri + 1, $time);
					r16_error = r16_error + 1;
				end
				
				//register 9/IR checks
				if (expected_9 == Q_9) begin
					$display("Pass R9: rst = %b, r_in = %b: Register9 Expected = %b, Q_9 = %b, ", control_bits[1], control_bits[0], expected_9, Q_9);
					r9_pass = r9_pass + 1;
				end
				
				else if (expected_9 != Q_9) begin
					$display("Fail R9: rst = %b, r_in = %b: Register9 Expected = %b, Q_9 = %b, count failed: %d, Time failed: %d", control_bits[1], control_bits[0], expected_9, Q_9, ri + 1, $time);
					r9_error = r9_error + 1;
				end
		  
		  end
		  
				if (r9_error == 0 & r16_error == 0) begin
					$display("Success. No errors were detected in the Register Component");
				end
				
				else begin
					$display("Failure. Register Testbench Statistics are: Errors_R16 = %d, Passes_R16 = %d, Errors_R9 = %d, Passes_R9 = %d", r16_error, r16_pass, r9_error, r9_pass);
				end		  
		  $stop
    end
		
		

		
	 
	
							
						

				 
	
		 
endmodule