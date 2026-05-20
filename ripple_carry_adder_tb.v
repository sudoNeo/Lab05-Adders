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

module ripple_carry_adder_tb;
    parameter NUMBITS = 8;

    // Inputs
    reg clk;
    reg reset;
    reg [NUMBITS-1:0] A;
    reg [NUMBITS-1:0] B;
    
    // Outputs
    wire [NUMBITS-1:0] result;
    reg [NUMBITS-1:0] expected_result;
    wire carryout;
    reg [15:0] A16, B16;
    wire[15:0] result16_rca, result16_cla;
    wire carryout16_rca, carryout16_cla;

    reg [31:0] A32, B32;
    wire [31:0] result32_rca, result32_cla;
    wire carryout32_rca, carryout32_cla;

    reg [63:0] A64, B64;
    wire [63:0] result64_rca, result64_cla;
    wire carryout64_rca, carryout64_cla;


    // -------------------------------------------------------
    // Setup output file for possible debugging uses
    // -------------------------------------------------------
    initial
    begin
        $dumpfile("lab02.vcd");
        $dumpvars(0);
    end

    // -------------------------------------------------------
    // Instantiate the Unit Under Test (UUT)
    // -------------------------------------------------------
    ripple_carry_adder #(.NUMBITS(8)) uut (
        .A(A), .B(B), .carryin(1'b0),
        .result(result), .carryout(carryout)
    );
    // -------------------------------------------------------
    // Instantiate the 16-bit Unit Under Test (UUT)
    // -------------------------------------------------------
    ripple_carry_adder #(.NUMBITS(16)) rca16 (.A(A16), .B(B16), .carryin(1'b0), .result(result16_rca), .carryout(carryout16_rca));
    carry_look_ahead_adder #(.NUMBITS(16)) cla16 (.A(A16), .B(B16), .carryin(1'b0), .result(result16_cla), .carryout(carryout16_cla));

    // -------------------------------------------------------
    // Instantiate the 32-bit Unit Under Test (UUT)
    // -------------------------------------------------------
    ripple_carry_adder #(.NUMBITS(32)) rca32 (.A(A32), .B(B32), .carryin(1'b0), .result(result32_rca), .carryout(carryout32_rca));
    carry_look_ahead_adder #(.NUMBITS(32)) cla32 (.A(A32), .B(B32), .carryin(1'b0), .result(result32_cla), .carryout(carryout32_cla));

    // -------------------------------------------------------
    // Instantiate the 64-bit Unit Under Test (UUT)
    // -------------------------------------------------------
    ripple_carry_adder #(.NUMBITS(64)) rca64 (.A(A64), .B(B64), .carryin(1'b0), .result(result64_rca), .carryout(carryout64_rca));
    carry_look_ahead_adder #(.NUMBITS(64)) cla64 (.A(A64), .B(B64), .carryin(1'b0), .result(result64_cla), .carryout(carryout64_cla));
    
    initial begin 
    
        clk = 0; reset = 1; #50; 
        clk = 1; reset = 1; #50; 
        clk = 0; reset = 0; #50; 
        clk = 1; reset = 0; #50; 
         
        forever begin 
            clk = ~clk; #50; 
        end 
    end 
    
    integer totalTests = 0;
    integer failedTests = 0;
    
    initial begin // Test suite
        // Reset
        @(negedge reset); // Wait for reset to be released (from another initial block)
        @(posedge clk);   // Wait for first clock out of reset 
        #10; // Wait 10 cycles 

        // ---------------------------------------------
        // Test Group for Addition Behavior Verification 
        // --------------------------------------------- 
        $write("Test Group 1: Addition Behavior Verification ... \n");

        // Code necessary for each test case 
        totalTests = totalTests + 1;
        $write("\tTest Case 1.1:   0+  0 =   0, c_out = 0 ... ");
        A = 8'h00;
        B = 8'h00;
        expected_result = 8'h00;

        #100; // Wait 
        if (expected_result !== result || carryout !== 1'b0) begin
            $write("failed\n");
            failedTests = failedTests + 1;
        end else begin
            $write("passed\n");
        end
        #10; // Wait 
        totalTests = totalTests + 1;
        $write("\tTest Case 1.2:   5+  3 =   8, c_out = 0 ... ");
        A = 8'd5;
        B = 8'd3;
        expected_result = 8'd8;
        #100;
        if (expected_result !== result || carryout !== 1'b0) begin
            $write("failed\n");
            failedTests = failedTests + 1;
        end else begin
            $write("passed\n");
        end
        #10;

        totalTests = totalTests + 1;
        $write("\tTest Case 1.3: 100+ 50 = 150, c_out = 0 ... ");
        A = 8'd100;
        B = 8'd50;
        expected_result = 8'd150;
        #100;
        if (expected_result !== result || carryout !== 1'b0) begin
            $write("failed\n");
            failedTests = failedTests + 1;
        end else begin
            $write("passed\n");
        end
        #10;

        totalTests = totalTests + 1;
        $write("\tTest Case 1.4: 127+  1 = 128, c_out = 0 ... ");
        A = 8'd127;
        B = 8'd1;
        expected_result = 8'd128;
        #100;
        if (expected_result !== result || carryout !== 1'b0) begin
            $write("failed\n");
            failedTests = failedTests + 1;
        end else begin
            $write("passed\n");
        end
        #10;

        totalTests = totalTests + 1;
        $write("\tTest Case 1.5: 255+  1 =   0, c_out = 1 ... ");
        A = 8'd255;
        B = 8'd1;
        expected_result = 8'd0;
        #100;
        if (expected_result !== result || carryout !== 1'b1) begin
            $write("failed\n");
            failedTests = failedTests + 1;
        end else begin
            $write("passed\n");
        end
        #10;

        // ----------------------------------------
        // Tests group for Increasing Number of Bits 
        // ----------------------------------------
        $write("Test Group 2: Increasing Number of Bits ...\n");

        totalTests = totalTests + 1;
        $write("\tTest Case 2.1: 16-bit -1 + 1 = 0, c_out = 1 ... ");
        A16 = -16'd1;
        B16 = 16'd1;
        #100;
        if (result16_rca !== 16'd0 || carryout16_rca !== 1'b1) begin
            $write("failed\n");
            failedTests = failedTests + 1;
        end else begin
            $write("passed\n");
        end
        #10;

        totalTests = totalTests + 1;
        $write("\tTest Case 2.2: 32-bit -1 + 1 = 0, c_out = 1 ... ");
        A32 = -32'd1;
        B32 = 32'd1;
        #100;
        if (result32_rca !== 32'd0 || carryout32_rca !== 1'b1) begin
            $write("failed\n");
            failedTests = failedTests + 1;
        end else begin
            $write("passed\n");
        end
        #10;

        totalTests = totalTests + 1;
        $write("\tTest Case 2.3: 64-bit -1 + 1 = 0, c_out = 1 ... ");
        A64 = -64'd1;
        B64 = 64'd1;
        #100;
        if (result64_rca !== 64'd0 || carryout64_rca !== 1'b1) begin
            $write("failed\n");
            failedTests = failedTests + 1;
        end else begin
            $write("passed\n");
        end
        #10;
        // -------------------------------------------------------
        // End testing
        // -------------------------------------------------------
        $write("\n-------------------------------------------------------");
        $write("\nTesting complete\nPassed %0d / %0d tests", totalTests-failedTests,totalTests);
        $write("\n-------------------------------------------------------\n");
        $finish;
    end
endmodule