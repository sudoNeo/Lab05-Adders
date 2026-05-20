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

module spg_block (
    input  wire a, 
    input  wire b,
    input  wire c_in,
    output reg g,  
    output reg p,
    output reg s
);

  wire g_w;
  wire p_w;
  wire s_w;

  half_adder ha1(.a(a), .b(b), .c_out(g_w), .s(p_w));
  slow_xor xor1(.a({p_w, c_in}), .result(s_w));

  always @(*) begin
    g <= g_w;
    p <= p_w;
    s <= s_w;
  end

endmodule