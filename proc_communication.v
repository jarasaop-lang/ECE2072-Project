/*
Monash University ECE2072: Assignment 
This file contains Verilog code to implement UART communication to the extended version of CPU.

Please enter your student ID: 34977635

*/
// All registers use clk_50. The input named clk is the step button.
// The CPU can write to R0-R6. R7 receives data even when the CPU is paused.
module simple_proc_communication(clk, clk_50, rst, din, bus, R0, R1, R2, R3, R4, R5, R6, R7, val0, val1, val2, val3, val4, val5, enable, tick, display, RXin, tx, TX_on); 

    // Note: The skeleton you are provided with includes output ports to output the values of the internal registers R0 - R7, for the purpose of test benching. When instantiating the processor to program your DE10-lite, you can leave these ports unused.

    // TODO: Declare inputs and outputs:
	 
	 
	
	input clk, clk_50, rst;
	input enable;
    input RXin;
    output tx, TX_on;
	input [8:0] din;
	
	
	output [15:0] R0, R1, R2, R3, R4, R5, R6, R7;	
	output [15:0] bus;
	output [7:0] val0, val1, val2, val3, val4;
	output [6:0] val5;
	
	output [3:0] tick;
    output [15:0] display;

    // TODO: declare wires:
    
	 wire [15:0] disp;
	 reg Ain, Gin, IRin, Hin, TXin;
	 reg [7:0] Rin;
	 reg [3:0] select;
	 reg [2:0] ALUop;
	 wire uart_valid;
    reg TX_start;
    wire cpu_step;
    // Stall a TX instruction at tick 2 if the transmitter is occupied.
    wire tx_wait;

	 
	 
	 wire [15:0] G_out, A_out, H_out, TX_out, ALU_result, SignExtDin;
     assign disp = H_out;
     assign display = disp;

	 wire [8:0] IR_out;
	 
	 //Intialising the IR register components into their own wires
	 wire [2:0] opcode, RX, RY;
	 
    // IR holds the instruction while din changes to an immediate value.
    // RX and RY are register numbers. The multiplexer puts the chosen value on the bus.
	 assign opcode = IR_out[8:6];
	 assign RX = IR_out[5:3];
	 assign RY = IR_out[2:0];
	 parameter ADD = 3'b001, SUB = 3'b011, ADDI = 3'b010, MOVI = 3'b111, DISP = 3'b000, SSI = 3'b101, MUL = 3'b100, TX = 3'b110;
	  
	 localparam SEL_G=4'b1000, SEL_DIN=4'b1001;
    assign tx_wait = (tick == 4'b0010) && (opcode == TX) && (TX_on || TX_start);
	 

   // TODO: instantiate registers:

	 
	register_n R0_reg (
		.data_in(bus), .r_in(Rin[0] && cpu_step), .clk(clk_50), .Q(R0), .rst(rst)
	);
	
	register_n R1_reg (
		.data_in(bus), .r_in(Rin[1] && cpu_step), .clk(clk_50), .Q(R1), .rst(rst)
	);
	register_n R2_reg (
		.data_in(bus), .r_in(Rin[2] && cpu_step), .clk(clk_50), .Q(R2), .rst(rst)
	);
	register_n R3_reg (
		.data_in(bus), .r_in(Rin[3] && cpu_step), .clk(clk_50), .Q(R3), .rst(rst)
	);
	register_n R4_reg (
		.data_in(bus), .r_in(Rin[4] && cpu_step), .clk(clk_50), .Q(R4), .rst(rst)
	);
	register_n R5_reg (
		.data_in(bus), .r_in(Rin[5] && cpu_step), .clk(clk_50), .Q(R5), .rst(rst)
	);
	register_n R6_reg (
		.data_in(bus), .r_in(Rin[6] && cpu_step), .clk(clk_50), .Q(R6), .rst(rst)
	);
    // R7 is read-only to the CPU; uart_rx owns its stored value.

	
	//Intialising the Instruction, A, G and Display registers
    // A saves the first number while the bus carries the second number.
    // G saves the answer, H saves the displayed number, and IR saves the instruction.
	register_n A (
		.data_in(bus), .r_in(Ain && cpu_step), .clk(clk_50), .Q(A_out), .rst(rst)
	);
	
	register_n G (
		.data_in(ALU_result), .r_in(Gin && cpu_step), .clk(clk_50), .Q(G_out), .rst(rst)
	);
	
	register_n H (
		.data_in(bus), .r_in(Hin && cpu_step), .clk(clk_50), .Q(H_out), .rst(rst)
	);
	
	register_n#(.N(9)) IR (
		.data_in(din), .r_in(IRin && cpu_step), .clk(clk_50), .Q(IR_out), .rst(rst)
	);
	
    // Save the value to send when moving from tick 2 to tick 3.
    // Start sending on the next clock edge, after the value has been saved.
	register_n TX_reg (
		.data_in(bus), .r_in(TXin && cpu_step), .clk(clk_50), .Q(TX_out), .rst(rst)
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
	 
	tick_FSM_uart tick1(
		 .rst(rst),
		 .clk(clk),
		 .clk_50(clk_50),
		 .enable(enable && !tx_wait),
         .step(cpu_step),
		 .tick(tick)
		 
	);
	
// TX loads on one edge; UART sees this registered pulse on the next.
    // This runs independently of further button presses and enable changes.
    always @(posedge clk_50) begin
        if (rst) TX_start <= 1'b0;
        else TX_start <= TXin && cpu_step;
    end

	//instantiate uart communication:
	
	uart_tx tx1(
		 .clk(clk_50),
		 .start(TX_start),
		 .reset(rst),
		 .data(TX_out),
		 .tx(tx),
		 .busy(TX_on)
	);
		 
    // Keep receiving data even when the CPU is paused.
    // uart_valid goes high when a full value arrives. The receiver saves that value in R7.
	uart_rx rx1(
		 .clk(clk_50),
		 .reset(rst),
		 .rx(RXin),
		 .data_valid(uart_valid),
		 .data(R7)
	);
		 
		 
    
    
    // TODO: define control unit:
    // Choose which value goes on the bus and which registers should save it.
    // Registers save their inputs on a rising clk_50 edge only when cpu_step is high.
    // Tick 1: save the instruction. Tick 2: save numbers for the chosen instruction.
    // Tick 3: save the ALU answer in G. Tick 4: copy G into the chosen register.
    // Turn off all write controls first, then turn on only those needed below.
    always @(*) begin
        // TODO: Turn off all control signals:
		  
		  Ain = 1'b0;
		  Gin = 1'b0;
		  Hin = 1'b0;
		  Rin = 8'b0;
		  TXin = 1'b0;
		  IRin = 1'b0;
		  select = 4'b0000;
		  ALUop = 3'b000;
		  


        // TODO: Turn on specific control signals based on current tick:
        // Freeze register writes as well as the tick when disabled.
        if (enable) begin
        case (tick)
            4'b0001:
                begin
					 IRin = 1;
                end
            
            4'b0010:
                begin

					 
					 case(opcode)
						ADD, SUB, MUL: begin
							Ain = 1;
							select = RX;
							end
							
						MOVI: begin
							select = SEL_DIN;
							Rin[RX] = 1'b1;
							end
						ADDI, SSI: begin
							Ain = 1;
							select = SEL_DIN;
						end
						
						DISP: begin
							Hin = 1;
							select = RX;
						end
						
						TX: begin
							TXin = 1;
							select = RX;
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
						MUL: begin
							Gin = 1;
							select = RY;
							ALUop = 3'd0;
							end							
						ADDI: begin
							Gin=1;
							select = RX;
							ALUop = 3'b001;
						end
						SSI: begin
							Gin=1;
							select = RX;
							ALUop = 3'd3;
						end
						
					 default: ;
						
					 endcase
                end
            
            4'b1000:
                begin
                
					 case(opcode)
						ADD, SUB, ADDI, MUL, SSI: begin
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
        end // if (enable)
    end // always @(*) -- module instances must follow this end.

		  
		  //Display functionality
		  
		  display dis1(
				.H_out(disp),
				.val0(val0),
				.val1(val1),
				.val2(val2),
				.val3(val3),
				.val4(val4)
		  );
		  
		  // Tick FSM functionality
		 BCD_tickfsm b1(
			  .tk(tick),
		     .tkhex(val5)
	    );
	 		  
		  
endmodule