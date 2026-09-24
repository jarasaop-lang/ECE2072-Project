/*
Monash University ECE2072: Assignment 
This file contains Verilog code to implement individual the CPU.

Please enter your student ID:

*/
module simple_proc(clk, rst, din, bus, R0, R1, R2, R3, R4, R5, R6, R7);

    // Note: The skeleton you are provided with includes output ports to output the values of the internal registers R0 - R7, for the purpose of test benching. When instantiating the processor to program your DE10-lite, you can leave these ports unused.

    // TODO: Declare inputs and outputs:
	 
	 
	
	input clk, rst;
	input [8:0] din;
	
	
	output [15:0] R0, R1, R2, R3, R4, R5, R6, R7;	
	output [15:0] bus;

    // TODO: declare wires:
    
	 
	 reg Ain, Gin, IRin;
	 reg [7:0] Rin;
	 reg [3:0] select;
	 reg [2:0] ALUop;
	 
	 
	 wire sign_extended_Din;
	 wire [15:0] G_out, A_out, ALU_result, SignExtDin;
	 wire [3:0] tick;
	 wire [8:0] IR_out;
	 
	 //Intialising the IR register components into their own wires
	 wire [2:0] opcode, RX, RY;
	 
	 assign opcode = IR_out[8:6];
	 assign RX = IR_out[5:3];
	 assign RY = IR_out[2:0];
	 parameter ADD = 3'b001, SUB = 3'b011, ADDI = 3'b010, MOVI = 3'b111;
	 
	 localparam SEL_G=4'b1000, SEL_DIN=4'b1001;
	 

   // TODO: instantiate registers:

	 
	register_n R0 (
		.data_in(bus), .r_in(Rin[0]), .clk(clk), .Q(R0), .rst(rst)
	);
	
	register_n R1_reg (
		.data_in(bus), .r_in(Rin[1]), .clk(clk), .Q(R1), .rst(rst)
	);
	register_n R2_reg (
		.data_in(bus), .r_in(Rin[2]), .clk(clk), .Q(R2), .rst(rst)
	);
	register_n R3_reg (
		.data_in(bus), .r_in(Rin[3]), .clk(clk), .Q(R3), .rst(rst)
	);
	register_n R4_reg (
		.data_in(bus), .r_in(Rin[4]), .clk(clk), .Q(R4), .rst(rst)
	);
	register_n R5_reg (
		.data_in(bus), .r_in(Rin[5]), .clk(clk), .Q(R5), .rst(rst)
	);
	register_n R6_reg (
		.data_in(bus), .r_in(Rin[6]), .clk(clk), .Q(R6), .rst(rst)
	);
	register_n R7_reg (
		.data_in(bus), .r_in(Rin[7]), .clk(clk), .Q(R7), .rst(rst)
	);
	
	//Intialising the Instruction, A and G registers
	register_n A (
		.data_in(bus), .r_in(Ain), .clk(clk), .Q(A_out), .rst(rst)
	);
	
	register_n G (
		.data_in(ALU_result), .r_in(Gin), .clk(clk), .Q(G_out), .rst(rst)
	);
	register_n#(.N(9)) IR (
		.data_in(din), .r_in(IRin), .clk(clk), .Q(IR_out), .rst(rst)
	);
	

	 //Instantiating the Din Sign Extender
	 
	 sign_extend s1(
		 .in(din),
		 .ext(SignExtDin)
	 );
	 
	 
	 
    
    // TODO: instantiate Multiplexer:
	 
	
	multiplexer controlmult(
		.R0(R0), .R1(R1), .R2(R2), .R3(R3), .R4(R4), .R5(R5), .R6(R6), .R7(R7),
		.G(G_out),
		.SignExtDin(SignExtDin),
		.sel(select),
		.Bus(bus)	
	);
	
	

    
    
    // TODO: instantiate ALU:
    ALU controlALU(
	.input_a(A_out),
	.input_b(bus),	
	.alu_op(ALUop),
	.result(ALU_result)
	);
	 
	 
	 
    
    // TODO: instantiate tick counter:
	 
	tick_FSM tick1(
		 .rst(rst),
		 .clk(clk),
		 .enable(1'b1),
		 .tick(tick)
		 
	);
    
    
    // TODO: define control unit:
    always @(tick, IR_out) begin
        // TODO: Turn off all control signals:
		  
		  Ain = 1'b0;
		  Gin = 1'b0;
		  Rin = 8'b0;
		  IRin = 1'b0;
		  select = 4'bxxxx;
		  ALUop = 3'bxxx;
		  


        // TODO: Turn on specific control signals based on current tick:
        case (tick)
            4'b0001:
                begin
					 IRin = 1;
                end
            
            4'b0010:
                begin

					 
					 case(opcode)
						ADD, SUB: begin
							Ain = 1;
							select = RX;
							end
							
						MOVI: begin
							select = SEL_DIN;
							Rin[RX] = 1'b1;
							end
						ADDI: begin
							Ain = 1;
							select = SEL_DIN;
						end
						
						default: ;
						
					 endcase
						
					 
                    // TODO
                end
            
            4'b0100:
                begin
					 
                case(opcode)
						ADD: begin
							Gin = 1;
							select = RY;
							ALUop = 3'b001;
							end
						SUB: begin
							Gin = 1;
							select = RY;
							ALUop = 3'b010;
							end
						ADDI: begin
							Gin=1;
							select = RX;
							ALUop = 3'b001;
						end
						
					 default: ;
						
					 endcase
                end
            
            4'b1000:
                begin
                
					 case(opcode)
						ADD, SUB, ADDI: begin
							select = SEL_G;
							Rin[RX] = 1'b1;
							end

					   default: ;
						
					 endcase
					 
					 
					 
                end
            
            default:
                begin
                    // TODO
                end

        endcase

    end

endmodule