`timescale 1ns/1ps

module uart_tb;

    reg clk;
    reg start;
    reg reset;

    wire tx;
    wire busy;


    // Instantiate YOUR UART transmitter
    uart_tx dut (
        .clk(clk),
        .start(start),
        .reset(reset),
        .tx(tx),
        .busy(busy)
    );


    // Generate 50 MHz clock
    // 50 MHz = 20 ns period
    // Therefore toggle every 10 ns
    always begin
        #10 clk = ~clk;
    end


    initial begin

        // Initial testbench inputs
        clk   = 0;
        start = 0;
        reset = 0;


        // Reset the UART
        #100;
        reset = 1;

        #20;
        reset = 0;


        // Wait a little
        #100;


        // Tell UART to transmit
        start = 1;

        #20;
        start = 0;


        // Wait long enough for entire UART frame
        #1200000;


        $stop;

    end

endmodule