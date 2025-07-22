module DataMemory(
input [31:0] address, 
input [31:0] writeData, 
input memWrite, 
input memRead, 
output [31:0] readData, 
input startin, 
input clk);

reg [31:0] memory [63:0];
reg [31:0] wordAddress;
assign wordAddress = address >> 2;
assign readData = (memRead) ? memory[wordAddress] : 'x;
always @(posedge clk or startin)begin
  if (startin) 
    memory <= '{default: 0};
  else if (memWrite) 
    memory[wordAddress] <= writeData;
end
endmodule
// Test bench created by DeepSeek  
`timescale 1ns / 1ns  

module DataMemory_tb;  
  reg  [31:0] Address, WriteData;  
  reg  MemWrite, MemRead, clk;  
  wire [31:0] ReadData;  

  DataMemory uut (  
    .Address(Address),  
    .WriteData(WriteData),  
    .MemWrite(MemWrite),  
    .MemRead(MemRead),  
    .ReadData(ReadData),  
    .clk(clk)  
  );  

  // Clock generation  
  always #5 clk = ~clk;  

  initial begin  
    clk = 0;  
    // Write to memory  
    Address = 32'h1000;  
    WriteData = 32'hCAFEBABE;  
    MemWrite = 1;  
    #10;  

    // Read from memory  
    MemWrite = 0;  
    MemRead = 1;  
    #10;  
  end  
endmodule  
// Testbench created by ChatGPT
`timescale 1ns / 1ns

module DataMemory_tb;
  reg [31:0] address, writeData;
  reg memWrite, memRead, startin, clk;
  wire [31:0] readData;

  DataMemory uut (
    .address(address),
    .writeData(writeData),
    .memWrite(memWrite),
    .memRead(memRead),
    .readData(readData),
    .startin(startin),
    .clk(clk)
  );

  always #5 clk = ~clk;

  initial begin
    clk = 0;
    startin = 1; memWrite = 0; memRead = 0; #10;
    startin = 0;

    address = 32'd4;
    writeData = 32'hCAFEBABE;
    memWrite = 1; #10;
    memWrite = 0;

    memRead = 1; #10;
    memRead = 0;
  end
endmodule


