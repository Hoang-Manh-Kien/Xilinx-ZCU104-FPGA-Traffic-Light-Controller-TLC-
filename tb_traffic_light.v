`timescale 1ns / 1ps

`timescale 1ns / 1ps

module tb_traffic_light;

reg clk = 0;
reg reset = 1;
reg start = 0;
wire red_led, green_led, yellow_led;
wire [6:0] seg;

traffic_light_top dut (
    .clk(clk),
    .reset(reset),
    .start(start),
    .red_led(red_led),
    .green_led(green_led),
    .yellow_led(yellow_led),
    .seg(seg)
);

// Clock: 100 MHz (10 ns period)
always #5 clk = ~clk;

initial begin
    $display("Starting traffic light simulation...");
    $dumpfile("traffic_light.vcd");
    $dumpvars(0, tb_traffic_light);

    #20 reset = 0;

    #30 start = 1;

    #300000000;

    $display("Simulation complete.");
    $finish;
end

endmodule