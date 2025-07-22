module Main(
input wire clk, 
input wire startin, 
input wire [4:0] regNo, 
output reg [31:0] val);

//------PC
wire [31:0] program_counter;
wire [31:0] PC_next;
PC PC_uut (.out(program_counter), .in(PC_next), .clk(clk), .startin(startin));

//------Instruction Memory
wire [31:0] instruction;
InstructionMemory InstructionMemory_uut (.address(program_counter), .instruction(instruction), .startin(startin));

//------Control
wire regdst;
wire regwrite;
wire alusrc;
wire [1:0] aluop;
wire memread;
wire memwrite;
wire memtoreg;
wire jump;
wire branch;
Control Control_uut (
  .instruction31_26(instruction[31:26]),
  .regdst(regdst),
  .regwrite(regwrite),
  .alusrc(alusrc),
  .aluop(aluop),
  .memread(memread),
  .memwrite(memwrite),
  .memtoreg(memtoreg),
  .jump(jump),
  .branch(branch));

//-----Mux_5 rd
wire [4:0] mux_rd;
Mux #(5) Mux_rd_uut (.input0(instruction[20:16]), .input1(instruction[15:11]), .op(regdst), .out(mux_rd));

//-----RegisterFile
wire [31:0] data1;
wire [31:0] data2;
wire [31:0] mux_memtoreg;
RegisterFile RegisterFile_uut (
  .read1(instruction[25:21]),
  .read2(instruction[20:16]),
  .writeReg(mux_rd),
  .writeData(mux_memtoreg),
  .regWrite(regwrite),
  .data1(data1),
  .data2(data2),
  .val(val),
  .startin(startin),
  .clk(clk),
  .regNo(regNo));

//------SignExtend
wire [31:0] extended_result;
SignExtend SignExtend_uut (.in(instruction[15:0]), .result(extended_result));

//------Mux_32 alusrc
wire [31:0] mux_src;
Mux #(32) Mux_src_uut (.input0(data2), .input1(extended_result), .op(alusrc), .out(mux_src));

//------Alu Control
wire [3:0] alucontrol;
ALUControl ALUControl_uut (.Funct(instruction[5:0]), .Aluop(aluop), .Alucontrol(alucontrol));

//------Alu 
wire [31:0] alu_result;
wire zero;
ALU ALU_uut (.in1(data1), .in2(mux_src), .operation(alucontrol), .out(alu_result), .zero(zero));

//------Data Memory
wire [31:0] read_data;
DataMemory DataMemory_uut (
  .address(alu_result),
  .writeData(data2),
  .memWrite(memwrite),
  .memRead(memread),
  .readData(read_data),
  .startin(startin),
  .clk(clk));

//------Mux memtoreg
Mux #(32) Mux_memtoreg_uut (.input0(alu_result), .input1(read_data), .op(memtoreg), .out(mux_memtoreg));

//------sll 2
wire [31:0] shifted_branch;
Shiftleft2 #(32, 32) Shiftleft2_branch_uut (.in(extended_result), .out(shifted_branch));

//------add PC+4
wire [31:0] PC_plus_4;
Add Add_PC4_uut (.digit1(program_counter), .digit2(32'd4), .result(PC_plus_4));

//------add
wire [31:0] add_result;
Add Add_uut (.digit1(PC_plus_4), .digit2(shifted_branch), .result(add_result));

//------Mux branch
wire [31:0] branch_selector;
assign branch_selector = branch & zero;
wire [31:0] mux_branch;
Mux #(32) Mux_branch_uut (.input0(PC_plus_4), .input1(add_result), .op(branch_selector), .out(mux_branch));

//-----jump address
wire [27:0] shifted_jump;
Shiftleft2 #(26, 28) Shiftleft2_jump_uut (.in(instruction[25:0]), .out(shifted_jump));
wire [31:0] jump_address;
assign jump_address = {PC_plus_4[31:28], shifted_jump};

//------Mux jump

Mux #(32) Mux_PC_uut (.input0(mux_branch), .input1(jump_address), .op(jump), .out(PC_next));

endmodule 

// Testbench created by ChatGPT
`timescale 1ns / 1ns

module Main_tb;

  reg clk, startin;
  reg [4:0] regNo;
  wire [31:0] val;

  Main uut (
    .clk(clk),
    .startin(startin),
    .regNo(regNo),
    .val(val)
  );

  // Generate clock: 10 ns period (100 MHz)
  always #5 clk = ~clk;

  initial begin
    clk = 0;
    startin = 1; #10; // Assert startin for reset
    startin = 0;
    regNo = 5'd17;

  end

endmodule


