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
	
	//alu
	reg [15:0] in_a, in_b;
	reg [2:0] alu;
	wire [15:0] alu_out;
	
	
	
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
	.alu_op(alu),
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
		$stop;
		end 
		
		
	end 
	
	
	//alu
	
	initial begin
		 in_a = 16'd0;
		 in_b = 16'd0;
		 alu = 3'd0;
		 
		 for(i_alu = 0; i_alu<512; i_alu = i_alu+1) begin
		 
			 in_a = {{7{i_alu[8]}}, {i_alu}};
			 
	 		 for(j_alu = 0; j_alu<512; j_alu = j_alu+1) begin
			 
			 in_b = {{7{j_alu[8]}}, {j_alu}};
			 
		 	 for(k_alu = 0; k_alu<16; k_alu = k_alu+1) begin
			 
				 alu = k_alu;
				 
				 case(alu) begin 
				 
					 3'd0: alu_out = in_a *in_b;
					 
					 3'b001: alu_out = in_a + in_b;
					 
					 3'b010: alu_out = in_a - in_b;
					 
					 3'b011: 
								if(in[15]) alu_out = in_b >> $signed(in_a);
								else alu_out = in_b << $signed(in_a);
								
					 default: 
				 endcase
				 
					 
						   
					 
					 
	
	

			 
	

							
						

				 
	
		 
endmodule