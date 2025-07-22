This project is an implementation of a mips Single-Cycle CPU in System-Verilog which can perform most of the basic mips instructins. 
there is a .sv file for each component which contains the module and the testbench. there is a Main.sv file which connencts all the modules together. 
the testbench in Main.sv runs 40 instructinos which store numbers 1-10 into memory and then load each number from the memory and sum them up. regNo and val signal are used for debugging. 
