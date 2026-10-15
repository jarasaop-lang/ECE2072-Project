// Receive bits 0 to 15 in order. Apply reset before use.
// Update data only after all 16 bits arrive and the stop bit is high.
module uart_rx (
    input clk,
	 output reg [15:0] data,
    input rx,
	 input reset,
	 output reg data_valid
	
);
    // The incoming signal can change between this board's clock edges.
    reg rx_meta, rx_sync;
    always @(posedge clk) begin
        if (reset) begin
            rx_meta <= 1'b1;
            rx_sync <= 1'b1;
        end else begin
            rx_meta <= rx;
            rx_sync <= rx_meta;
        end
    end
    reg active;
    reg [13:0] baud_count;
    reg [4:0] bit_count;
	 reg [15:0] data_rx;	
	always@(posedge clk) begin
        // Clear data_valid each cycle. Set it for one cycle when a full value is received.
		data_valid <= 1'b0;
		
      if (reset) begin
			 active <= 1'd0;
			 data <= 16'd0;
			 data_rx <= 16'd0;
          baud_count <= 14'd0;
          bit_count  <= 5'd0;
			
		end 

        // Wait for the input to stay low for half a bit before starting to receive.
        // Then read once per bit, near the middle of each bit.
		else if (!active) begin

			if (rx_sync == 1'b0) begin

				if (baud_count == 13'd4999/2) begin
					active     <= 1'b1;
					baud_count <= 14'd0;
					bit_count  <= 5'd0;
				end
				else begin
					baud_count <= baud_count + 1'b1;
				end

			end
			else begin
				baud_count <= 14'd0;
			end

		end
		
		
		else if (active) begin
            if (baud_count == 13'd4999) begin

                if (bit_count < 16) begin

                    baud_count <= 14'd0;
                    // Save each bit in data_rx. Keep data unchanged until the whole value arrives.
                    data_rx[bit_count] <= rx_sync;
                    bit_count  <= bit_count + 1'b1;

                end

                // Count 15 reads the last data bit. Count 16 checks the stop bit.
                // Finish receiving. Copy the new value to data only if the stop bit is high.
                else if (bit_count == 16) begin
						 
            
						bit_count  <= 5'd0;
						baud_count <= 14'd0;
						active <= 1'b0;
						
							if(rx_sync == 1'b1) begin
							
								data <= data_rx;
								data_valid <= 1'b1;
							end
					 end
							

            end

            else begin

                baud_count <= baud_count + 1'b1;

            end
		end 
	end 
endmodule 

			 
		
			 

			 
			 
			 
			
			