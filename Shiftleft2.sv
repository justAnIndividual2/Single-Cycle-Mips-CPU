module Shiftleft2 #(parameter N, M)(
input wire [N-1:0] in, 
output wire [M-1:0] out);

assign out = in << 2;
endmodule
// Test bench created by DeepSeek  
`timescale 1ns / 1ns  

module Shiftleft2_tb;  
  reg  [25:0] in_26;  
  reg  [31:0] in_32;  
  wire [27:0] out_28;  
  wire [31:0] out_shifted;  

  // Instantiate Shift_26_28  
  Shiftleft2 #(26, 28) shift26_28 (  
    .in(in_26),  
    .out(out_28)  
  );  

  // Instantiate ShiftLeft2 (32-bit)  
  Shiftleft2 #(32, 32) shift32 (  
    .in(in_32),  
    .out(out_shifted)  
  );  

  initial begin  
    // Test 26-to-28 shift  
    in_26 = 26'b11_1111_1111_1111_1111_1111_1111;  
    #10;  

    // Test 32-bit shift  
    in_32 = 32'h0000000F;  
    #10;  
  end  
endmodule  