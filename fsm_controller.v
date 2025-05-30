`timescale 1ns / 1ps

module fsm_controller(
    input wire clk,
    input wire reset,
    input wire start,
    input wire timer_done,
    input wire [3:0] timer_value,
    output reg red_led,
    output reg green_led,
    output reg yellow_led,
    output reg blinking_enable,
    output reg [3:0] display_digit,
    output reg [1:0] state //2-bit wide signal (since we have 4 states)
    );
    
 //definte state encodings
 parameter IDLE = 2'b00;
 parameter RED = 2'b01;
 parameter GREEN = 2'b10;
 parameter YELLOW = 2'b11;
 
 reg [1:0] next_state;
 
 always @(posedge clk) begin
    if (reset)
        state <= IDLE;
    else
        state <= next_state;
 end
//STATE TRANSITION LOGIC
always @(*) begin
    case (state)
        IDLE: begin
            if (start)
                next_state = RED;
            else
                next_state = IDLE;
         end
         
         RED: begin
            if (!start)
                next_state = IDLE;
            else if (timer_done)
                next_state = GREEN;
            else
                next_state = RED;
         end
                
         GREEN: begin
            if (!start)
                next_state = IDLE;
            else if (timer_done)
                next_state = YELLOW;
            else
                next_state = GREEN;
          end
          
          YELLOW: begin
            if (!start)
                next_state = IDLE;
            else if (timer_done)
                next_state = RED;
            else
                next_state = YELLOW;
           end
           
           default: next_state = IDLE;
    endcase
end       

//OUTPUT LOGIC
always @(*) begin
    red_led = 0;
    green_led = 0;
    yellow_led = 0;
    blinking_enable = 0;
    display_digit = 4'b1111;
    
    case (state)
        IDLE: begin //No LEDs on, blank 7
        end
        
        RED: begin
            red_led = 1;
            display_digit = timer_value;
            if (timer_value <= 4'd3 && timer_value > 0)
                blinking_enable = 1;
         end
         
        GREEN: begin
             green_led = 1;
             display_digit = timer_value;
             if (timer_value <= 4'd3 && timer_value > 0)
                 blinking_enable = 1;
         end
         
        YELLOW: begin
              yellow_led = 1;
              display_digit = timer_value;
              blinking_enable = 0;
         end
     endcase
end
        
endmodule
