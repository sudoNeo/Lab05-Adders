//=========================================================================
//
// DO NOT CHANGE THIS FILE. IT IS PROVIDED TO MAKE SURE YOUR LAB IS 
// SUCCESSFULL. 
//
//=========================================================================

`timescale 1ns / 1ps

//  Constant definitions 

module half_adder (
  input wire a,
  input wire b,
  output reg s,
  output reg c_out
);

  wire [2:0] level1;
  wire [2:0] level2;
  wire c_out_w;
  wire s_w;

  slow_and and1(.a({a, b}), .result(c_out_w));
  slow_xor xor1(.a({a, b}), .result(s_w));

  always @(*) begin
    c_out <= c_out_w;
    s <= s_w;
  end

endmodule