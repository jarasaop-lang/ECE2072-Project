/*
Monash University ECE2072: Assignment 
This file contains Verilog code to implement individual components to be used in 
    the CPU.

Please enter your name and student ID:

*/
module sign_extend(in, ext);
	/* 
	 * This module sign extends the 9-bit Din to a 16-bit output.
	 */
	// TODO: Declare inputs and outputs
	input [8:0] in;
	output [15:0] ext;
	
	// TODO: implement logic
	assign ext = {{7{in[8]}}, {in}};
	
endmodule



module tick_FSM(rst, clk, enable, tick);
	 /*
	 * This module implements a tick FSM that will be used to
	 * control the actions of the control unit
	 */

	// TODO: Declare inputs and outputs
	input clk;
	input rst;
	input enable;
	output reg [3:0] tick;
	
    // TODO: implement FSM
	 
	 parameter t1 = 4'b0001;
	 
	 always @(posedge clk) begin
		 if (rst) tick <= t1;
		 
		 else if (enable) begin
		 
			 tick <= {tick[2:0], tick[3]};
		 end
		 
	 end
			 
endmodule

module multiplexer(SignExtDin, R0, R1, R2, R3, R4, R5, R6, R7, G, sel, Bus);
	/* 
	 * This module takes 10 inputs and places the correct input onto the bus.
	 */
	// TODO: Declare inputs and outputs
	
	// TODO: implement logic


endmodule


module ALU (input_a, input_b, alu_op, result);
	/* 
	 * This module implements the arithmetic logic unit of the processor.
	  */
	// TODO: declare inputs and outputs

    input [15:0] input_a;
    input [15:0] input_b;
    input [2:0] alu_op;
    output reg [15:0] result;

	// TODO: Implement ALU Logic:
    parameter add = 3'b001,
              sub = 3'b010,
              mul = 3'b000,
              ss  = 3'b011;

    reg [17:0] s;
    reg [3:0] ve;
    integer i;

    always @(*) begin

        case (alu_op)

            add:
                result = input_a + input_b;

            sub:
                result = input_a - input_b;

            mul:
                result = input_a * input_b;

            ss: begin

                // Negative -> shift right
                if (input_a[15]) begin

                    s = $signed(input_a) * -1;

                    if (s < 16) begin
                        ve = 15 - s;

                        for (i=0; i<16; i=i+1) begin
                            if (i > ve)
                                result[i] = 0;
                            else
                                result[i] = input_b[i+s];
                        end

                    end
                    else
                        result = 16'd0;

                end

                // Positive -> shift left
                else begin

                    s = $signed(input_a);

                    if (s < 16) begin

                        for (i=0; i<16; i=i+1) begin
                            if (i < s)
                                result[i] = 0;
                            else
                                result[i] = input_b[i-s];
                        end

                    end
                    else
                        result = 16'd0;

                end
            end

            default:
                result = 16'd0;

        endcase
    end

endmodule


module register_n(data_in, r_in, clk, Q, rst);


	// To set parameter N during instantiation, you can use:
	// register_n #(.N(num_bits)) reg_IR(.....), 
	// where num_bits is how many bits you want to set N to
	// and "..." is your usual input/output signals

	parameter N = 16;

	/* 
	 * This module implements registers that will be used in the processor.
	  */
	// TODO: Declare inputs, outputs, and parameter:
	
	// TODO: Implement register logic:
endmodule

