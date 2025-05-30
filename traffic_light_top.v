`timescale 1ns / 1ps

module traffic_light_top (
    input wire clk,
    input wire reset,
    input wire start,
    output wire red_led,
    output wire green_led,
    output wire yellow_led,
    output wire [6:0] seg
);

// === Internal signals ===
wire timer_done;
wire blinking_enable;
wire blink_toggle;
wire [3:0] timer_value;
wire [3:0] display_digit_raw;
wire [1:0] current_state;
reg [3:0] load_value;
reg timer_enable;
reg [1:0] prev_state; // <-- Added to detect state transitions

// === FSM Controller ===
fsm_controller fsm (
    .clk(clk),
    .reset(reset),
    .start(start),
    .timer_done(timer_done),
    .timer_value(timer_value),
    .red_led(red_led),
    .green_led(green_led),
    .yellow_led(yellow_led),
    .blinking_enable(blinking_enable),
    .display_digit(display_digit_raw),
    .state(current_state)
);

// === Timer ===
wire reload; // <-- New signal to trigger reload on state change
assign reload = (prev_state != current_state);

timer tmr (
    .clk(clk),
    .reset(reset),
    .enable(timer_enable),
    .reload(reload), // <-- Connect reload signal
    .load_value(load_value),
    .count(timer_value),
    .done(timer_done)
);

// === Update previous state on clock edge ===
always @(posedge clk) begin
    if (reset)
        prev_state <= 2'b00;
    else
        prev_state <= current_state; // <-- Track previous FSM state
end

// === Blinker ===
blinker blink_unit (
    .clk(clk),
    .reset(reset),
    .enable(blinking_enable),
    .blink(blink_toggle)
);

// === Segment Output (with optional blinking override) ===
wire [3:0] display_digit;
assign display_digit = (blinking_enable && !blink_toggle) ? 4'b1111 : display_digit_raw;

// === 7-Segment Decoder ===
seven_seg_decoder decoder (
    .digit(display_digit),
    .seg(seg)
);

// === Timer Control Logic ===
always @(*) begin
    timer_enable = 0;
    case (current_state)
        2'b01: begin timer_enable = 1; load_value = 4'd9; end   // RED
        2'b10: begin timer_enable = 1; load_value = 4'd6; end   // GREEN
        2'b11: begin timer_enable = 1; load_value = 4'd3; end   // YELLOW
        default: begin timer_enable = 0; load_value = 4'd0; end
    endcase
end

endmodule
