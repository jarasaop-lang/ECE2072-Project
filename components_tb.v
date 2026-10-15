`timescale 1ns/1ns
/*
Monash University ECE2072: Assignment 
This file contains a Verilog test bench to test the correctness of the individual 
    components used in the processor.

Please enter your student ID:

*/
// Each test uses the same clock and sets its own flag when finished.
// The final summary waits for every section and reports each component's error count.
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
	parameter T1 = 4'b0001, T2= 4'b0010, T3= 4'b0100, T4= 4'b1000;
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
	
	//alu
	reg [21:0] alu; // Includes the loop termination value 2097152.
	wire [15:0] alu_out;
	reg [15:0] alu_exp;
	reg [15:0] in_a, in_b;
	reg [2:0] alu_c;
	integer alu_err;
	
	//stop flag
	reg [4:0] st;
	parameter SIGN_STOP = 0, TICK_STOP = 1, ALU_STOP = 2, MULTI_STOP = 3, REGI_STOP = 4; 
	
	
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
	
	ALU a1(
	.input_a(in_a),
	.input_b(in_b),	
	.alu_op(alu_c),
	.result(alu_out)
	);
	

		 
	

	always begin
		#5;
		clk = ~clk;
	end
	

//sign_ext
	 initial begin
		 in = 0;
		 cnt_sign =0;		 
		 err_sign = 0;
		 st[SIGN_STOP] = 0;

		 for (cnt_sign = 0; cnt_sign < 512; cnt_sign = cnt_sign + 1) begin
			 #9;
			 exp = $signed(in);

			 if (exp !== ext) begin
					 // synopsys translate_off
			       $display("[FAIL] Sign Extender | Test %0d | Input: %b | Expected: %b | Actual: %b | Time: %0t ns",
                         cnt_sign + 1, in, exp, ext, $time);
					 // synopsys translate_on
					 err_sign = err_sign + 1;
			 end

			 #1;
			 in = in + 9'd1;
		 end

		 if (err_sign == 0) begin
			  $display("PASS Sign Extender | 512/512 input combinations passed");
			  st[SIGN_STOP] = 1;
		 end
		 else begin
			 $display("FAIL Sign Extender | %0d errors out of 512 tests", err_sign);
			 st[SIGN_STOP] = 1;
		 end 

	 end

	
//tick_fsm

	initial begin
		 clk = 0;
		 val_en = 4'd0;
		 val_rst = 4'd0;
		 err_tick = 0;
		 st[TICK_STOP] = 0;
		 
		 for(i=0; i< 16; i = i+1) begin
			 val_en = i[3:0];
			 
			 for(j= 0; j<16; j=j+1) begin
				 val_rst = j[3:0];
				 rst = 1;
				 enable = 0;
				 @(posedge clk);
				 #1;
				 tick_exp = T1;				 
				 
				 
				 for(k=0; k< 4; k = k+1) begin
					enable = val_en[k];
					rst = val_rst[k];
				
					@(posedge clk);
					#1;
					
					if(!rst) begin
						case(tick_exp)
							T1:
								if (enable) tick_exp = T2;
								else tick_exp = T1;
							T2: 
								if (enable) tick_exp = T3;
								else tick_exp = T2;
							T3: 
								if (enable) tick_exp = T4;
								else tick_exp = T3;
							T4:
								if (enable) tick_exp = T1;
								else tick_exp = T4;
							default: tick_exp = T1;
						endcase 
					end 
					else tick_exp = T1;
			
					if(tick_exp !== tick) begin
						err_tick = err_tick+1;
						// synopsys translate_off
						$display("FAIL Tick FSM | Test Sequence %0d | Clock Cycle %0d | Enable seq: %b | Rst seq: %b | EN: %b | RST: %b | Expected: %b | Actual: %b | Time: %0t ns",
									(i*16)+j+1, k+1, val_en, val_rst,
									enable, rst, tick_exp, tick, $time);
						// synopsys translate_on
					end
				end 
			end
		end
			if(err_tick == 0 ) begin
				$display("success");
				st[TICK_STOP] = 1;
			end
			else begin
				 $display("Fail had %0d errors", err_tick);		
				 st[TICK_STOP] = 1;
			end 

		end 
		
	
		
		
	
	
	
	//alu
	
	initial begin
		 in_a = 16'd0;
		 in_b = 16'd0;
		 alu_c = 3'd0;
		 alu_err = 0;
		 st[ALU_STOP] = 0;
		 
        // Try every pair of signed nine-bit numbers with all eight operation codes.
        // This does not test every possible pair of 16-bit numbers.
		  
		 // synopsys translate_off
		 for(alu = 0; alu<2097152; alu = alu+1) begin
		 
			 in_a = {{7{alu[8]}}, {alu[8:0]}};
			 in_b = {{7{alu[17]}}, {alu[17:9]}};
			 alu_c =  alu[20:18];
			 
				 
				 case(alu_c) 
				 
					 3'd0: alu_exp = in_a *in_b;
					 
					 3'b001: alu_exp = in_a + in_b;
					 
					 3'b010: alu_exp = in_a - in_b;
					 
					 3'b011: 
								if(in_a[15]) begin 
								alu_exp = in_b >> $signed(in_a)*-1;
								end 
								else begin
								alu_exp = in_b << $signed(in_a);
								end
								
					 default: alu_exp = 16'b0;
				 endcase
			 
			 #9;
			 
			 if (alu_exp !== alu_out) begin
                 alu_err = alu_err + 1;
                 if (alu_err <= 10)
                     $display("FAIL ALU: op=%0d a=%h b=%h expected=%h actual=%h", alu_c, in_a, in_b, alu_exp, alu_out);
             end
         end
			// synopsys translate_on
			
         $display("ALU summary: 2097152 cases, %0d errors", alu_err);
         st[ALU_STOP] = 1'b1;
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
		  st[MULTI_STOP] = 0;

		  
		  //initialising the multiplexer values
		  for (mi = 0; mi < 10; mi = mi + 1) begin
				//get random, legal, values by multiplying a 16 bit hex value
				registers[mi] = (mi[15:0]+16'd1) * 16'h1111;	
		  end
		  
    

    

			
		  //Go through each select line, calculate the expected output, compare and increment
		  for (mi = 0; mi < 16; mi = mi+1) begin
				#10
				
				sel = mi[3:0];
				mult_expected_output = (sel < 10) ? registers[mi] : 16'b0;
				
				#9;
				if (mult_expected_output === Bus) begin
					$display("Pass: Select Line = %b: Multiplexer Expected = %b, Bus = %b", sel, mult_expected_output, Bus);
					mult_pass = mult_pass + 1;
				end
				
				else if (mult_expected_output !== Bus) begin
					$display("Fail: Select Line = %b: Multiplexer Expected = %b, Bus = %b, Test Sequence: %d", sel, mult_expected_output, Bus, mi+1);
					
					mult_errors = mult_errors + 1; 
				end
				#1;
			end
			
			
			
			if ((mult_errors + mult_pass) == 16) begin
			
				if (mult_errors == 0) begin
					$display("Success. No errors were detected in the Multiplexer Component");
					st[MULTI_STOP] = 1;
				end
				
				else begin
					$display("Failure. Multiplexer Testbench Statistics are: Errors = %d, Passes = %d", mult_errors, mult_pass);
					st[MULTI_STOP] = 1;
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
		  st[REGI_STOP] = 0;
		  
		  
		
			
		  control_bits = 2'b10;
		  //skips from t=0 --> t=11-15 period (negative edge)
		  @(posedge clk);
		  #1;
		  control_bits = 2'b00;
		 
		
		  // synopsys translate_off
		  for(ri =0; ri < 4; ri = ri + 1) begin
		  
				@(negedge clk);
				control_bits = ri[1:0];
				data_in_16 = 16'h11EB + ri[15:0];
				data_in_9 = 9'h0E1 + ri[8:0];
				
				
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
				if (expected_16 === Q_16) begin
					$display("Pass R16: rst = %b, r_in = %b: Register16 Expected = %b, Q_16 = %b", control_bits[1], control_bits[0], expected_16, Q_16);
					r16_pass = r16_pass + 1;
				end
				
				else if (expected_16 !== Q_16) begin
					// synopsys translate_off
					$display("Fail R16: rst = %b, r_in = %b: Register16 Expected = %b, Q_16 = %b, count failed: %d, Time failed: %d", control_bits[1], control_bits[0], expected_16, Q_16, ri + 1, $time);
					// synopsys translate_on
					r16_error = r16_error + 1;
				end
				
				//register 9/IR checks
				if (expected_9 === Q_9) begin
					$display("Pass R9: rst = %b, r_in = %b: Register9 Expected = %b, Q_9 = %b, ", control_bits[1], control_bits[0], expected_9, Q_9);
					r9_pass = r9_pass + 1;
				end
				
				else if (expected_9 !== Q_9) begin
					// synopsys translate_off
					$display("Fail R9: rst = %b, r_in = %b: Register9 Expected = %b, Q_9 = %b, count failed: %d, Time failed: %d", control_bits[1], control_bits[0], expected_9, Q_9, ri + 1, $time);
					// synopsys translate_on
					r9_error = r9_error + 1;
				end
		  
		  end
		  // synopsys translate_on
		  
				if (r9_error == 0 & r16_error == 0) begin
					$display("Success. No errors were detected in the Register Component");
					st[REGI_STOP] = 1;
				end
				
				else begin
					$display("Failure. Register Testbench Statistics are: Errors_R16 = %d, Passes_R16 = %d, Errors_R9 = %d, Passes_R9 = %d", r16_error, r16_pass, r9_error, r9_pass);
					st[REGI_STOP] = 1 ;
				end		  
		 
    end
	   
	 
	 initial begin
		 

		 wait(st == 5'b11111);

		 $display("All tests finished: sign=%0d tick=%0d alu=%0d mux=%0d reg9=%0d reg16=%0d errors",
             err_sign, err_tick, alu_err, mult_errors, r9_error, r16_error);
		 $stop;
		 
	 end


		
endmodule