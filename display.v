module display(H_out, val0, val1, val2, val3, val4);

	 input [15:0] H_out;
	 
	 output [7:0] val0, val1, val2, val3, val4;
	 
	 wire [7:0] seg0, seg1, seg2, seg3, seg4;
	 
	 wire [15:0] hex_units, hex_tens, hex_huns, hex_thou, hex_tenthou;

	 wire [15:0] hex0, hex1, hex2, hex3, hex4;
	 
	 wire [15:0] magnitude;

	 assign magnitude  = (H_out[15]) ? (~H_out + 1'b1) : H_out;
	 
	 
	 display_divide h0(
		 .numer(magnitude[15:0]),
		 .denom(16'd10),
		 .quotient(hex0),
		 .remain(hex_units)
		 );
		 
	 display_divide h1(
		 .numer(hex0),
		 .denom(16'd10),
		 .quotient(hex1),
		 .remain(hex_tens)
		 );

	 display_divide h2(
		 .numer(hex1),
		 .denom(16'd10),
		 .quotient(hex2),
		 .remain(hex_huns)
		 );
		 
	 display_divide h3(
		 .numer(hex2),
		 .denom(16'd10),
		 .quotient(hex3),
		 .remain(hex_thou)
		 );

	 display_divide h4(
		 .numer(hex3),
		 .denom(16'd10),
		 .quotient(hex4),
		 .remain(hex_tenthou)
		 );
		 
		 
	 BCD v0(
		 .data(hex_units[3:0]),
		 .neg(H_out[15]),
		 .X(seg0)
		 );

	 BCD v1(
		 .data(hex_tens[3:0]),
		 .neg(H_out[15]),
		 .X(seg1)
		 );
		 
	 BCD v2(
		 .data(hex_huns[3:0]),
		 .neg(H_out[15]),
		 .X(seg2)
		 );
		 
	 BCD v3(
		 .data(hex_thou[3:0]),
		 .neg(H_out[15]),
		 .X(seg3)
		 );
		 
	 BCD v4(
		 .data(hex_tenthou[3:0]),
		 .neg(H_out[15]),
		 .X(seg4)
		 );
	
	 assign val0 = {~H_out[15], seg0[6:0]};
	 assign val1 = {~H_out[15], seg1[6:0]};
	 assign val2 = {~H_out[15], seg2[6:0]};
	 assign val3 = {~H_out[15], seg3[6:0]};
	 assign val4 = {~H_out[15], seg4[6:0]};
	
	 
	
endmodule 