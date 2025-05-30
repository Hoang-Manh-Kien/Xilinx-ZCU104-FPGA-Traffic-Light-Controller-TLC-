`timescale 1ns / 1ps

module seven_seg_decoder (
    input wire [3:0] digit, //input D3->D0
    output reg [6:0] seg //output sf->sa
);
//COMMON CATHODE (có 2 d?ng 7-segment displayer: cathode v?i anode. Nh? t ?ang set là cathode ngh?a là kh?p led c?a 7-segment display s? on khi = 1. Check l?i v?i hardware cái này)

always @(*) begin
    case (digit)
        4'd0: seg = 7'b0111111;
        4'd1: seg = 7'b0000110;
        4'd2: seg = 7'b1011011;
        4'd3: seg = 7'b1001111;
        4'd4: seg = 7'b1100110;
        4'd5: seg = 7'b1101101;
        4'd6: seg = 7'b1111101;
        4'd7: seg = 7'b0000111;
        4'd8: seg = 7'b1111111;
        4'd9: seg = 7'b1101111;
        default: seg = 7'b0000000; //default khi l?i là ko có s? nào
    endcase
end

endmodule