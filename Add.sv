module Add(
  input [31:0] digit1, 
  input [31:0] digit2, 
  output [31:0] result);

  assign result = digit1 + digit2;

endmodule
`timescale 1ns / 1ns
// Testbench for Add written by ChatGPT
module tb_Add;
  reg [31:0] d1, d2;
  wire [31:0] result;

  Add uut (.digit1(d1), .digit2(d2), .result(result));

  initial begin
    d1 = 32'd10;
    d2 = 32'd15;
    #5 d1 = 32'd100; d2 = 32'd4;
    #5 d1 = 32'd1; d2 = 32'd4;
  end
endmodule
