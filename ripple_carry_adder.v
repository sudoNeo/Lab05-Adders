//=========================================================================
// Name & Email must be EXACTLY as in Gradescope roster!
// Name: Marlon Lopez 
// Email: mlope589@ucr.edu
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

module ripple_carry_adder # ( parameter NUMBITS = 16 ) (
    input  wire[NUMBITS-1:0] A, 
    input  wire[NUMBITS-1:0] B, 
    input wire carryin, 
    output reg [NUMBITS-1:0] result,  
    output reg carryout); 

wire [NUMBITS:0] carry;
    wire [NUMBITS-1:0] sum_w;
    assign carry[0] = carryin;
    genvar i;
    generate
        for (i = 0; i < NUMBITS; i = i + 1) begin
            full_adder fa (
                .a (A[i]),
                .b (B[i]),
                .c_in (carry[i]),
                .s (sum_w[i]),
                .c_out(carry[i+1])
            );
        end
    endgenerate

    always @(*) begin
        result = sum_w;
        carryout = carry[NUMBITS];
    end

endmodule