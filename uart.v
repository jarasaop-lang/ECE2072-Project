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
	 reg [15:0] data_saved; //incase data is changed after transmitting initiates




    initial begin
        busy       <= 1'b0;
        tx         <= 1'b1;
        baud_count <= 13'd0;
        bit_count  <= 4'd0;
		  data_saved <= 16'd0;
    end


    always @(posedge clk) begin

        // ---------------- RESET ----------------
        if (reset) begin

            busy       <= 1'b0;
            tx         <= 1'b1;
            baud_count <= 13'd0;
            bit_count  <= 4'd0;
				data_saved <= 16'd0;

        end


        // ---------------- IDLE ----------------
        else if (!busy) begin

            tx <= 1'b1;

            if (start) begin

                busy       <= 1'b1;
                tx         <= 1'b0;      // Start bit
                baud_count <= 13'd0;
                bit_count  <= 4'd0;
					 data_saved <= data;

            end

        end


        // ------------- TRANSMITTING -------------
        else begin

            if (baud_count == 13'd4999) begin

                if (bit_count < 16) begin

                    baud_count <= 13'd0;
                    tx         <= data_saved[bit_count];
                    bit_count  <= bit_count + 1'b1;

                end

                else if (bit_count == 16) begin

                    tx         <= 1'b1;      // Stop bit
                    bit_count  <= bit_count + 1'b1;
                    baud_count <= 13'd0;

                end

                else begin

                    busy <= 1'b0;

                end

            end

            else begin

                baud_count <= baud_count + 1'b1;

            end

        end

    end

endmodule