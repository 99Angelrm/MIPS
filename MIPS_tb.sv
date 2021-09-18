`timescale 1ns / 1ps
module MIPS_tb;

  logic 		clk;
	  logic 		rst;
	  logic		clr;
	 integer i;
	 logic [31:0]	pc_out;
	 logic [31:0] randdata;

MIPS uut(
	.clk(clk),
	.rst(rst),
	.clr(clr),
	.pc_out(pc_out)

);

	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 1;

		// Wait 100 ns for global reset to finish
		#11;
      		rst = 0; 
		
		// INIT 
		//for ( i=0 ; i<32 ;i = i + 1)begin
			//uut.dpt.registros.mem[i] = i;
			//end
		for ( i=0 ; i<10 ;i = i + 1)begin
			uut.registers.mem[i] = i;
		end
		
		for ( i=0 ; i<256 ;i = i + 1) begin
			randdata = $random();
			uut.datamem.mem_array[i] = {8'h0,randdata[7:0]};  
			end	

uut.instructionmem.mem_array[0] = 32'b00100000010000010000000000000011;


		
end
		
always forever #2 clk = ~clk;

endmodule