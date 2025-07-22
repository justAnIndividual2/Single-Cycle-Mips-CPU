module ALU(
input wire [31:0] in1, 
input wire [31:0] in2, 
input wire [3:0] operation, 
output reg [31:0] out, 
output reg zero);

always_comb begin
  case (operation)
    4'b0000 : begin out <= in1 & in2; zero <= 0; end //AND
    4'b0001 : begin out <= in1 | in2; zero <= 0; end //OR
    4'b0010 : begin out <= in1 + in2; zero <= 0; end //add
    4'b0110 : begin out <= in1 - in2; zero <= (out == 0) ? 1 : 0; end //sub
    4'b0111 : begin out <= in1 & in2; zero <= 0; end //slt
    4'b1100 : begin out <= ~(in1 | in2); zero <= 0; end //NOR
    default : out <= 32'bx;
  endcase
end
endmodule
`timescale 1ns / 1ns
// Testbench for ALU written by ChatGPT
module tb_ALU;
  reg [31:0] in1, in2;
  reg [3:0] op;
  wire [31:0] out;
  wire zero;

  ALU uut (.in1(in1), .in2(in2), .operation(op), .out(out), .zero(zero));

  initial begin
    in1 = 32'd10; in2 = 32'd5; op = 4'b0010; // ADD
    #5 op = 4'b0110; // SUB
    #5 op = 4'b0000; // AND
    #5 op = 4'b0001; // OR
    #5 op = 4'b0111; // SLT
    #5 op = 4'b1100; // NOR
  end
endmodule
