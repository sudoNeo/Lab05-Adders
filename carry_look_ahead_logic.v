//=========================================================================
// Name & Email must be EXACTLY as in Gradescope roster!
// Name: 
// Email: 
// 
// Assignment name: 
// Lab section: 
// TA: 
// 
// I hereby certify that I have not received assistance on this assignment,
// or used code, from ANY outside source other than the instruction team
// (apart from what was provided in the starter file).
//
//=========================================================================

`timescale 1ns / 1ps

//  Constant definitions 

module carry_look_ahead_logic # (parameter NUMBITS = 4) (
    input  wire [NUMBITS-1:0] p, 
    input  wire [NUMBITS-1:0] g,
    input  wire c_in,
    output reg  [NUMBITS:0] c
);

wire [NUMBITS:0] c_w;

genvar i, j; 

generate
  for (i = 1; i <= NUMBITS; i = i +1) begin
    wire [i-1:0] stage_w;
    for (j = 0; j < i; j = j + 1) begin
      slow_and #(.NUMINPUTS(i+1-j)) and_stage(.a({j===0?c_in:g[j-1], p[i - 1:j]}), .result(stage_w[j]));
    end
    slow_or #(.NUMINPUTS(i+1)) or_stage(.a({g[i-1], stage_w}), .result(c_w[i]));
  end
endgenerate

always @(*) begin
  c <= c_w;
end

endmodule