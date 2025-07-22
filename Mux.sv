module Mux #(parameter N) (
input wire [N-1:0] input0, 
input wire [N-1:0] input1, 
input wire op, 
output wire [N-1:0] out);

assign out = (op) ? input1 : input0;
endmodule
// Test bench created by DeepSeek  
`timescale 1ns / 1ns  

module Mux_tb;  
  // Test both 5-bit and 32-bit Mux  
  reg  [4:0] in0_5, in1_5;  
  reg  [31:0] in0_32, in1_32;  
  reg  sel;  
  wire [4:0] out_5;  
  wire [31:0] out_32;  

  // Instantiate Mux (N=5)  
  Mux #(5) mux5 (  
    .input0(in0_5),  
    .input1(in1_5),  
    .op(sel),  
    .out(out_5)  
  );  

  // Instantiate Mux (N=32)  
  Mux #(32) mux32 (  
    .input0(in0_32),  
    .input1(in1_32),  
    .op(sel),  
    .out(out_32)  
  );  

  initial begin  
    // Test 5-bit Mux  
    in0_5 = 5'b10101;  
    in1_5 = 5'b01010;  
    sel = 0;  
    #10 sel = 1;  

    // Test 32-bit Mux  
    in0_32 = 32'hFFFF0000;  
    in1_32 = 32'h0000FFFF;  
    #10 sel = 0;  
    #10 sel = 1;  
  end  
endmodule  