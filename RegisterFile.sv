module RegisterFile(
input [4:0] read1, 
input [4:0] read2, 
input [4:0] writeReg, 
input [31:0] writeData, 
input regWrite, 
output [31:0] data1, 
output [31:0] data2, 
input startin, 
input clk, 
output [31:0] val, 
input [4:0] regNo);

reg [31:0] registers [31:0];

assign data1 = registers[read1];
assign data2 = registers[read2];
assign val = registers[regNo];

always @(posedge clk or startin)begin 
  if (startin)
    registers <= '{default: 0};
  else if (regWrite)
    registers[writeReg] <= writeData;
end

endmodule
// Testbench created by ChatGPT
`timescale 1ns / 1ns

module RegisterFile_tb;
  reg [4:0] read1, read2, writeReg, regNo;
  reg [31:0] writeData;
  reg regWrite, startin, clk;
  wire [31:0] data1, data2, val;

  RegisterFile uut (
    .read1(read1),
    .read2(read2),
    .writeReg(writeReg),
    .writeData(writeData),
    .regWrite(regWrite),
    .data1(data1),
    .data2(data2),
    .val(val),
    .startin(startin),
    .clk(clk),
    .regNo(regNo)
  );

  always #5 clk = ~clk;

  initial begin
    clk = 0;
    startin = 1; regWrite = 0; #10;
    startin = 0;

    writeReg = 5'd3;
    writeData = 32'hDEADBEEF;
    regWrite = 1; #10;
    regWrite = 0;

    read1 = 5'd3;
    read2 = 5'd0;
    regNo = 5'd3; #10;
  end
endmodule

