// Task 3 board wrapper. SW9 enables execution; KEY0 reset is synchronous.
module simple_proc_ext_top(
    input [9:0] SW,
    input [1:0] KEY,
    output [9:0] LEDR,
    output [7:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5
);
    wire [15:0] bus;
    wire [15:0] display_value;
    wire [3:0] tick;
    wire [6:0] tick_segments;

    simple_procext p1(
        .clk(~KEY[1]), .rst(~KEY[0]), .enable(SW[9]),
        .din(SW[8:0]), .bus(bus), .display(display_value), .tick(tick)
    );
    display digits(
        .H_out(display_value),
        .val0(HEX0), .val1(HEX1), .val2(HEX2), .val3(HEX3), .val4(HEX4)
    );
    BCD_tickfsm tick_decoder(.tk(tick), .tkhex(tick_segments));
    assign LEDR = bus[9:0];
    assign HEX5 = {~display_value[15], ~tick_segments};
endmodule
