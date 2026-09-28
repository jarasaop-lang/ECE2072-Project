module BCD (
    input [15:0] data,
    output [6:0] X
);
wire A, B, C, D;

assign A= data[3];
assign B = data[2];
assign C = data[1];
assign D = data[0];

assign X[0] = (~A & B & ~C & ~D)|(~A & ~B & ~C & D);
assign X[1] = (~A & B & ~C & D)|(~A & B & C & ~D);
assign X[2] = (~A & ~B & C & ~D);
assign X[3] = (~A & ~B & ~C & D)|(B & ~C & ~D)|(B & C & D);
assign X[4] = (~C|D)&(B|D);
assign X[5] = (C & D)|(~A & ~B & C)|(~A & ~B & D); 
assign X[6] = (~A & ~B & ~C)|(B & C & D);
endmodule