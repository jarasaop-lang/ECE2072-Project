// clk is an active-high button level (~KEY[1]), not a clock.
// At 50 MHz, 500000 stable samples debounce the button for 10 ms.
module tick_FSM_uart #(
    parameter integer DEBOUNCE_CYCLES = 500000
)(
    input rst,
    input clk,
    input clk_50,
    input enable,
    output reg [3:0] tick,
    output step
);
    reg button_meta, button_sync, button_down;
    reg press_pulse;
    reg [31:0] stable_count;

    assign step = press_pulse && enable && !rst;

    always @(posedge clk_50) begin
        if (rst) begin
            button_meta <= 1'b0;
            button_sync <= 1'b0;
            button_down <= 1'b0;
            stable_count <= 32'd0;
            press_pulse <= 1'b0;
            tick <= 4'b0001;
        end else begin
            button_meta <= clk;
            button_sync <= button_meta;
            press_pulse <= 1'b0;
            if (button_sync == button_down)
                stable_count <= 32'd0;
            else if (stable_count == DEBOUNCE_CYCLES - 1) begin
                stable_count <= 32'd0;
                button_down <= button_sync;
                if (button_sync) press_pulse <= 1'b1;
            end else
                stable_count <= stable_count + 1'b1;

            if (step) tick <= {tick[2:0], tick[3]};
        end
    end
endmodule
