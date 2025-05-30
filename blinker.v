`timescale 1ns / 1ps

module blinker (
    input wire clk,
    input wire reset,
    input wire enable,  //enables blinking
    output reg blink    
);

reg [25:0] counter; //2^26 = s? g� ?� r?t to > 50 tri?u
parameter HALF_SECOND = 500; //nh?p nh�y 0.5s (n?u ?ang tr?n simulation c� th? ?? 500, nh?ng l� FPGAs th� s? l� 50 tri?u ticks theo l� thuy?t)

always @(posedge clk) begin //synchronous design
    if (reset || !enable) begin
        counter <= 0;
        blink <= 0;
    end 
    else begin
    //c� th? d�ng ki?u counter == HALF_SECOND nma h�n xui v� vivado prefer >, < n�n d�ng nh? n�y)
        if (counter < HALF_SECOND - 1) //n?u counter b� h?n 499 (498 n� s? ???c +1 th�nh 499)
            counter <= counter + 1; //499 l� h?t 500 ticks (v� ??m t? 0) n�n s? trigger l?i ?i?u ki?n b�n tr�n v� ?i xu?ng c�i else begin b�n d??i
        else begin
            counter <= 0; //reset v? 0 v� ??m counter m?i
            blink <= ~blink; //nh?p nh�y th�nh s�ng h�nh vu�ng
        end //l?p l?i sau m?i 0.5s
    end
end

endmodule
