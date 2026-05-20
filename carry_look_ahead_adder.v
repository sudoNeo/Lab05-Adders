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

module carry_look_ahead_adder # ( parameter NUMBITS = 16 ) (
  input  wire[NUMBITS-1:0] A, 
  input  wire[NUMBITS-1:0] B, 
  input wire carryin, 
  output reg [NUMBITS-1:0] result,  
  output reg carryout
);

  wire [NUMBITS-1:0] p;
  wire [NUMBITS-1:0] g;
  wire [NUMBITS:0] carries;
  wire [NUMBITS-1:0] result_w;

  carry_look_ahead_logic # (.NUMBITS(NUMBITS)) cla_logic (
    .p(p),
    .g(g),
    .c_in(carryin),
    .c(carries)
  );

  assign carries[0] = carryin;

  always @(*) begin
    carryout <= carries[NUMBITS];
    result <= result_w;
  end

  genvar i;

  generate
    for (i = 0; i < NUMBITS; i = i+ 1) begin
      spg_block stage(.a(A[i]), .b(B[i]), .c_in(carries[i]), .g(g[i]), .p(p[i]), .s(result_w[i]));
    end
  endgenerate

endmodule