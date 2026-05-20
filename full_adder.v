//=========================================================================
//
// DO NOT CHANGE THIS FILE. IT IS PROVIDED TO MAKE SURE YOUR LAB IS 
// SUCCESSFULL. 
//
//=========================================================================

`timescale 1ns / 1ps

//  Constant definitions 

module full_adder (
  input wire a,
  input wire b,
  input wire c_in,
  output reg s,
  output reg c_out
);

  wire [2:0] level1;
  wire [2:0] level2;
  wire c_out_w;

  slow_and and1(.a({a, b}),    .result(level1[0]));
  slow_and and2(.a({a, c_in}), .result(level1[1]));
  slow_and and3(.a({b, c_in}), .result(level1[2]));

  slow_or #(.NUMINPUTS(3)) or1(.a(level1), .result(c_out_w));

  always @(*) begin
    s <= (~a & ~b &  c_in) |
         (~a &  b & ~c_in) |
         ( a &  b &  c_in) |
         ( a & ~b & ~c_in);

    c_out <= c_out_w;
  end

endmodule