module display(H_out, val0, val1, val2, val3, val4);

	 input [15:0] H_out;
	 
	 output [7:0] val0, val1, val2, val3, val4;
	 
	 wire [3:0] hex_units, hex_tens, hex_huns, hex_thou, hex_tenthou;

	 wire [15:0] hex0, hex1, hex2, hex3, hex4;
	 
	 wire [15:0] magnitude;

	 assign magnitude  = (H_out[15]) ? (~H_out + 1'b1) : H_out;
	 
	 
	 display_divide h0(
		 .numer(magnitude[15:0]),
		 .denom(4'd10),
		 .quotient(hex0),
		 .remain(hex_units)
		 );
		 
	 display_divide h1(
		 .numer(hex0),
		 .denom(4'd10),
		 .quotient(hex1),
		 .remain(hex_tens)
		 );

	 display_divide h2(
		 .numer(hex1),
		 .denom(4'd10),
		 .quotient(hex2),
		 .remain(hex_huns)
		 );
		 
	 display_divide h3(
		 .numer(hex2),
		 .denom(4'd10),
		 .quotient(hex3),
		 .remain(hex_thou)
		 );

	 display_divide h4(
		 .numer(hex3),
		 .denom(4'd10),
		 .quotient(hex4),
		 .remain(hex_tenthou)
		 );
		 
		 
	 BCD v0(
		 .data(hex_units),
		 .neg(H_out[15]),
		 .X(val0)
		 );

	 BCD v1(
		 .data(hex_tens),
		 .neg(H_out[15]),
		 .X(val1)
		 );
		 
	 BCD v2(
		 .data(hex_huns),
		 .neg(H_out[15]),
		 .X(val2)
		 );
		 
	 BCD v3(
		 .data(hex_thou),
		 .neg(H_out[15]),
		 .X(val3)
		 );
		 
	 BCD v4(
		 .data(hex_tenthou),
		 .neg(H_out[15]),
		 .X(val4)
		 );	 
endmodule 