`timescale 1ns / 1ps

module blinker (
    input wire clk,
    input wire reset,
    input wire enable,  //enables blinking
    output reg blink    
);

reg [25:0] counter; //2^26 = s? gì ?ó r?t to > 50 tri?u
parameter HALF_SECOND = 500; //nh?p nháy 0.5s (n?u ?ang tr?n simulation có th? ?? 500, nh?ng là FPGAs thì s? là 50 tri?u ticks theo lý thuy?t)

always @(posedge clk) begin //synchronous design
    if (reset || !enable) begin
        counter <= 0;
        blink <= 0;
    end 
    else begin
    //có th? dùng ki?u counter == HALF_SECOND nma hên xui vì vivado prefer >, < nên dùng nh? này)
        if (counter < HALF_SECOND - 1) //n?u counter bé h?n 499 (498 nó s? ???c +1 thành 499)
            counter <= counter + 1; //499 là h?t 500 ticks (vì ??m t? 0) nên s? trigger l?i ?i?u ki?n bên trên và ?i xu?ng cái else begin bên d??i
        else begin
            counter <= 0; //reset v? 0 và ??m counter m?i
            blink <= ~blink; //nh?p nháy thành sóng hình vuông
        end //l?p l?i sau m?i 0.5s
    end
end

endmodule
