`timescale 1ns / 1ps

module timer (
    input wire clk,
    input wire reset,
    input wire enable,
    input wire reload,
    input wire [3:0] load_value,
    output reg [3:0] count,
    output reg done
);

reg [25:0] tick_counter;
parameter TICKS_PER_SECOND = 1000;

always @(posedge clk) begin
    if (reset) begin
        count <= 0;
        tick_counter <= 0;
        done <= 0;
    end else if (reload) begin
        count <= load_value;
        tick_counter <= 0;
        done <= 0;
    end else if (enable) begin
        if (count == 0 && !done) begin
            count <= load_value; // reload timer
            tick_counter <= 0;
            done <= 0;
        end else if (tick_counter < TICKS_PER_SECOND - 1) begin
            tick_counter <= tick_counter + 1;
        end else begin
            tick_counter <= 0;
            if (count > 0) count <= count - 1;
            if (count == 1) done <= 1;
        end
    end else begin
        tick_counter <= 0;
        done <= 0;
    end
end

endmodule
