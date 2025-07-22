module Control(
input wire [5:0] instruction31_26, 
output reg regdst, 
output reg regwrite,
output reg alusrc, 
output reg [1:0] aluop, 
output reg memread, 
output reg memwrite, 
output reg memtoreg, 
output reg jump,
output reg branch);

wire [5:0] opcode;
assign opcode = instruction31_26;

always@ (*) 
  begin
    if (opcode == 6'b000000) // R-format
    begin
      regdst <= 1; 
      regwrite <= 1;
      alusrc <= 0; 
      aluop <= 2'b10;
      memread <= 0;
      memwrite <= 0;
      memtoreg <= 0;
      jump <= 0;
      branch <= 0;
    end

    else if (opcode == 6'b100011) // Load
    begin
      regdst <= 0; 
      regwrite <= 1;
      alusrc <= 1; 
      aluop <= 2'b00;
      memread <= 1;
      memwrite <= 0;
      memtoreg <= 1;
      jump <= 0;
      branch <= 0;
    end 

    else if (opcode == 6'b101011) // Save
    begin
      regdst <= 1'bx ; 
      regwrite <= 0;
      alusrc <= 1; 
      aluop <= 2'b00;
      memread <= 0;
      memwrite <= 1;
      memtoreg <= 1'bx;
      jump <= 0;
      branch <= 0;
    end 

    else if (opcode == 6'b000100) // Brach If Equal
    begin
      regdst <= 1'bx ; 
      regwrite <= 0;
      alusrc <= 0; 
      aluop <= 2'b01;
      memread <= 0;
      memwrite <= 0;
      memtoreg <= 1'bx;
      jump <= 0;
      branch <= 1;
    end 

    else if (opcode == 6'b000101) // Brach If Not Equal 
    begin
      regdst <= 1'bx ; 
      regwrite <= 0;
      alusrc <= 0; 
      aluop <= 2'b01;
      memread <= 0;
      memwrite <= 0;
      memtoreg <= 1'bx;
      jump <= 0;
      branch <= 1;
    end 

    else if (opcode == 6'b001000) // addi
    begin
      regdst <= 0 ; 
      regwrite <= 1;
      alusrc <= 1; 
      aluop <= 2'b00;
      memread <= 0;
      memwrite <= 0;
      memtoreg <= 1'b0;
      jump <= 0;
      branch <= 0;
    end 

    else if (opcode == 6'b001100) // andi
    begin
      regdst <= 0 ; 
      regwrite <= 1;
      alusrc <= 1; 
      aluop <= 2'b00;
      memread <= 0;
      memwrite <= 0;
      memtoreg <= 1'b0;
      jump <= 0;
      branch <= 0;
    end 

    else if (opcode == 6'b001101) // ori
    begin
      regdst <= 0 ; 
      regwrite <= 1;
      alusrc <= 1; 
      aluop <= 2'b00;
      memread <= 0;
      memwrite <= 0;
      memtoreg <= 1'b0;
      jump <= 0;
      branch <= 0;
    end 

    else if (opcode == 6'b000010) // jump
    begin
      regdst <= 1'bx ; 
      regwrite <= 0;
      alusrc <= 1'bx; 
      aluop <= 2'bxx;
      memread <= 0;
      memwrite <= 0;
      memtoreg <= 1'bx;
      jump <= 1;
      branch <= 0;
    end 

    else // default
    begin
      regdst <= 1'bx ; 
      regwrite <= 1'bx;
      alusrc <= 1'bx; 
      aluop <= 2'bxx;
      memread <= 1'bx;
      memwrite <= 1'bx;
      memtoreg <= 1'bx;
      jump <= 1'bx;
      branch <= 1'bx;
    end 

  end
		
endmodule

// Testbench written by ChatGPT
`timescale 1ns / 1ns

module Control_tb;

  reg [5:0] instruction31_26;
  wire regdst, regwrite, alusrc, memread, memwrite, memtoreg, jump, branch;
  wire [1:0] aluop;

  Control uut (
    .instruction31_26(instruction31_26),
    .regdst(regdst),
    .regwrite(regwrite),
    .alusrc(alusrc),
    .aluop(aluop),
    .memread(memread),
    .memwrite(memwrite),
    .memtoreg(memtoreg),
    .jump(jump),
    .branch(branch)
  );

  initial begin
    instruction31_26 = 6'b000000; #5; // R-type
    instruction31_26 = 6'b100011; #5; // lw
    instruction31_26 = 6'b101011; #5; // sw
    instruction31_26 = 6'b000100; #5; // beq
    instruction31_26 = 6'b000101; #5; // bne
    instruction31_26 = 6'b001000; #5; // addi
    instruction31_26 = 6'b001100; #5; // andi
    instruction31_26 = 6'b001101; #5; // ori
    instruction31_26 = 6'b000010; #5; // jump
  end

endmodule
