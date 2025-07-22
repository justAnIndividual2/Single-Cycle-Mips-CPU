module SignExtend(
input wire [15:0] in, 
output wire [31:0] result);
assign result = {{16{in[15]}}, in};
endmodule
// Test bench created by DeepSeek  
`timescale 1ns / 1ns  

module SignExtend_tb;  
  reg  [15:0] in;  
  wire [31:0] result;  

  SignExtend uut (  
    .in(in),  
    .result(result)  
  );  

  initial begin  
    // Test positive (MSB=0)  
    in = 16'h7FFF;  
    #10;  

    // Test negative (MSB=1)  
    in = 16'h8000;  
    #10;  
  end  
endmodule  