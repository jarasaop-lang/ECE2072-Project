module uart_rx (
    input clk,
	 output reg [15:0] data,
    input rx,
	 input reset,
	 output reg data_valid
	
);
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
	
	 
    initial begin


		  data <= 15'd0;
		  data_rx <= 15'd0;
        baud_count <= 13'd0;
        bit_count  <= 4'd0;
		  active <= 1'b0;
		  data_valid <= 1'b0;
		  
    end	
	always@(posedge clk) begin
		data_valid <= 1'b0;
		
      if (reset) begin
			 active <= 1'd0;
			 data <= 15'd0;
			 data_rx <= 15'd0;
          baud_count <= 13'd0;
          bit_count  <= 4'd0;
			
		end 

		else if (!active) begin

			if (rx_sync == 1'b0) begin

				if (baud_count == 13'd4999/2) begin
					active     <= 1'b1;
					baud_count <= 25'd0;
					bit_count  <= 4'd0;
				end
				else begin
					baud_count <= baud_count + 1'b1;
				end

			end
			else begin
				baud_count <= 25'd0;
			end

		end
		
		
		else if (active) begin
            if (baud_count == 13'd4999) begin

                if (bit_count < 16) begin

                    baud_count <= 13'd0;
                    data_rx[bit_count] <= rx_sync;
                    bit_count  <= bit_count + 1'b1;

                end

                else if (bit_count == 16) begin
						 
            
						bit_count  <= 1'b0;
						baud_count <= 13'd0;
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

			 
		
			 

			 
			 
			 
			
			