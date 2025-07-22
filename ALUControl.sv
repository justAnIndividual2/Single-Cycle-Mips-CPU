module ALUControl(
input wire [5:0] Funct, 
input wire [1:0] Aluop, 
output reg [3:0]Alucontrol);

always@(*)begin
  if (Aluop == 2'b10)begin // R-Format
    if (Funct == 6'b100000)begin // add
      Alucontrol <= 4'b0010;
    end

    else if (Funct == 6'b100010)begin // sub
      Alucontrol <= 4'b0110;
    end

    else if (Funct == 6'b100100)begin // and
      Alucontrol <= 4'b0000;
    end

    else if (Funct == 6'b100101)begin // or
      Alucontrol <= 4'b0001;
    end

    else if (Funct == 6'b101010)begin // slt
      Alucontrol <= 4'b0111;
    end

    else begin // default
      Alucontrol <= 4'bxxxx;
    end
  end

  else if(Aluop == 2'b00)begin // lw/sw
    Alucontrol <= 4'b0010;
  end

  else if(Aluop == 2'b01)begin // beq
    Alucontrol <= 4'b0110;
  end

  else begin  Alucontrol <= 4'bxxxx; end


end

endmodule

// Testbench written by ChatGPT
`timescale 1ns / 1ns

module ALUControl_tb;

  reg [5:0] Funct;
  reg [1:0] Aluop;
  wire [3:0] Alucontrol;

  ALUControl uut (
    .Funct(Funct),
    .Aluop(Aluop),
    .Alucontrol(Alucontrol)
  );

  initial begin
    Aluop = 2'b10; Funct = 6'b100000; #5; // add
    Funct = 6'b100010; #5; // sub
    Funct = 6'b100100; #5; // and
    Funct = 6'b100101; #5; // or
    Funct = 6'b101010; #5; // slt

    Aluop = 2'b00; Funct = 6'bxxxxxx; #5; // lw/sw
    Aluop = 2'b01; Funct = 6'bxxxxxx; #5; // beq
  end

endmodule
