//=========================================================================
//
// DO NOT CHANGE THIS FILE. IT IS PROVIDED TO MAKE SURE YOUR LAB IS 
// SUCCESSFULL. 
//
//=========================================================================

`timescale 1ns / 1ps

//  Constant definitions 

module slow_or # ( parameter NUMINPUTS = 2 ) (
  input wire [NUMINPUTS-1:0] a,
  output wire result
);

assign #2 result = |a;

endmodule