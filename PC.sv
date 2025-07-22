module PC(
  output reg [31:0] out, 
  input wire [31:0] in, 
  input wire clk, 
  input wire startin);
  
  always_ff @(posedge clk)begin
    if (startin) out <= 32'b0;
    else out <= in;
  end
endmodule
// Testbench for PC written by ChatGPT
`timescale 1ns / 1ns
module tb_PC;
  reg clk;
  reg [31:0] in, startin;
  wire [31:0] out;

  PC uut (.out(out), .in(in), .clk(clk), .startin(startin));

  initial begin
    in = 32'd0;
    startin = 1'b0;

    #5 in = 32'd100;
    #5 startin = 1'b1;
    #10 in = 32'd200;
    #5 startin = 1'b0;
    #10 in = 32'd300;
    #10 ;
  end

  initial begin
    clk = 1'b0;
    forever #5 clk = ~clk ;
  end
endmodule
