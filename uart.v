/*
Monash University ECE2072: Assignment 
This file contains Verilog code to implement UART transmission of 16 bits.

Please enter your student ID: 34977635

*/

// Send a low start bit, then bits 0 to 15, then a high stop bit. Stay high when idle.
// With a 50 MHz input and 5000 clocks per bit, the bit rate is 10000 bits/s.
// Apply reset before use. start is accepted only while busy is low.
module uart_tx (
    input clk,
    input start,
    input reset,
	 input [15:0] data,
    output reg tx,
    output reg busy
);

    reg [13:0] baud_count;
    reg [4:0] bit_count;
    // Save the input so changing it later does not change the value being sent.
	 reg [15:0] data_saved; //incase data is changed after transmitting initiates


    always @(posedge clk) begin

        // ---------------- RESET ----------------
        if (reset) begin

            busy       <= 1'b0;
            tx         <= 1'b1;
            baud_count <= 14'd0;
            bit_count  <= 5'd0;
				data_saved <= 16'd0;

        end


        // ---------------- IDLE ----------------
        else if (!busy) begin

            tx <= 1'b1;

            if (start) begin

                busy       <= 1'b1;
                tx         <= 1'b0;      // Start bit
                baud_count <= 14'd0;
                bit_count  <= 5'd0;
					 data_saved <= data;

            end

        end


        // ------------- TRANSMITTING -------------
        else begin

            if (baud_count == 13'd4999) begin

                if (bit_count < 16) begin

                    baud_count <= 14'd0;
                    tx         <= data_saved[bit_count];
                    bit_count  <= bit_count + 1'b1;

                end

                // All 16 data bits have been sent. Hold the output high for one stop bit.
                else if (bit_count == 16) begin

                    tx         <= 1'b1;      // Stop bit
                    bit_count  <= bit_count + 1'b1;
                    baud_count <= 14'd0;

                end

                else begin

                    // The stop bit is finished. The transmitter is ready for another value.
                    busy <= 1'b0;

                end

            end

            else begin

                baud_count <= baud_count + 1'b1;

            end

        end

    end

endmodule