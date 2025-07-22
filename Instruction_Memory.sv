module InstructionMemory(
  input wire [31:0] address, 
  output reg [31:0] instruction, 
  input wire startin);
  reg [31:0] memory [63:0];
  reg [31:0] wordAddress;
  assign wordAddress = address >> 2;
  always @(*)begin
    if (startin)begin
//store 1-10 in memory cells
    memory[0] <= 32'b00100000000010000000000000000001;  // addi $t0, $0, 1
    memory[1] <= 32'b10101100000010000000000000000000;  // sw $t0, 0($0)

    memory[2] <= 32'b00100000000010000000000000000010;  // addi $t0, $0, 2
    memory[3] <= 32'b10101100000010000000000000000100;  // sw $t0, 4($0)

    memory[4] <= 32'b00100000000010000000000000000011;  // addi $t0, $0, 3
    memory[5] <= 32'b10101100000010000000000000001000;  // sw $t0, 8($0)

    memory[6] <= 32'b00100000000010000000000000000100;  // addi $t0, $0, 4
    memory[7] <= 32'b10101100000010000000000000001100;  // sw $t0, 12($0)

    memory[8] <= 32'b00100000000010000000000000000101;  // addi $t0, $0, 5
    memory[9] <= 32'b10101100000010000000000000010000;  // sw $t0, 16($0)

    memory[10] <= 32'b00100000000010000000000000000110; // addi $t0, $0, 6
    memory[11] <= 32'b10101100000010000000000000010100; // sw $t0, 20($0)

    memory[12] <= 32'b00100000000010000000000000000111; // addi $t0, $0, 7
    memory[13] <= 32'b10101100000010000000000000011000; // sw $t0, 24($0)

    memory[14] <= 32'b00100000000010000000000000001000; // addi $t0, $0, 8
    memory[15] <= 32'b10101100000010000000000000011100; // sw $t0, 28($0)

    memory[16] <= 32'b00100000000010000000000000001001; // addi $t0, $0, 9
    memory[17] <= 32'b10101100000010000000000000100000; // sw $t0, 32($0)

    memory[18] <= 32'b00100000000010000000000000001010; // addi $t0, $0, 10
    memory[19] <= 32'b10101100000010000000000000100100; // sw $t0, 36($0) 



//read 10 memory cells and put sum in $8. result should be 55
    memory[20] <= 32'b10001110000010000000000000000000;
    memory[21] <= 32'b00000010001010001000100000100000;

    memory[22] <= 32'b10001110000010000000000000000100;
    memory[23] <= 32'b00000010001010001000100000100000;

    memory[24] <= 32'b10001110000010000000000000001000;
    memory[25] <= 32'b00000010001010001000100000100000;

    memory[26] <= 32'b10001110000010000000000000001100;
    memory[27] <= 32'b00000010001010001000100000100000;

    memory[28] <= 32'b10001110000010000000000000010000;
    memory[29] <= 32'b00000010001010001000100000100000;

    memory[30] <= 32'b10001110000010000000000000010100;
    memory[31] <= 32'b00000010001010001000100000100000;

    memory[32] <= 32'b10001110000010000000000000011000;
    memory[33] <= 32'b00000010001010001000100000100000;

    memory[34] <= 32'b10001110000010000000000000011100;
    memory[35] <= 32'b00000010001010001000100000100000;

    memory[36] <= 32'b10001110000010000000000000100000;
    memory[37] <= 32'b00000010001010001000100000100000;

    memory[38] <= 32'b10001110000010000000000000100100;
    memory[39] <= 32'b00000010001010001000100000100000;

    memory[40] <= 32'b10101110000100010000000000101000;
    end

    else begin
    instruction <= memory[wordAddress];
    end
  end
endmodule


`timescale 1ns / 1ns
// Testbench for InstructionMemory written by ChatGPT
module tb_Instruction_Memory;
  reg [31:0] address;
  reg startin;
  wire [31:0] instruction;

  InstructionMemory uut (.address(address), .instruction(instruction), .startin(startin));

  initial begin
    startin = 1; // initialize memory
    address = 0;
    #5 startin = 0;

    #5 address = 0;
    #5 address = 1;
    #5 address = 2;
    #5 address = 10;
    #5 address = 20;
    #5 address = 21;
  end
endmodule



