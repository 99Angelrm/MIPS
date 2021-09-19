// `timescale 1ns / 1ps
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
		#10;
      		rst = 0; 
		
		// INIT 
		//for ( i=0 ; i<32 ;i = i + 1)begin
			//uut.dpt.registros.mem[i] = i;
			//end
		for ( i=0 ; i<10 ;i = i + 1)begin
			uut.registers.mem[i] = '0;
		end
		
		for ( i=0 ; i<256 ;i = i + 1) begin
			randdata = $random();
			uut.datamem.mem_array[i] = {8'h0,randdata[7:0]};
			uut.datamem.mem_array[i+256] = uut.datamem.mem_array[i];
			end	

			uut.datamem.mem_array[1] = 100;
			uut.datamem.mem_array[1+256] = 60;
			
			uut.datamem.mem_array[2] = 40;
			uut.datamem.mem_array[2+256] = 100;
			
			uut.datamem.mem_array[3] = -2;
			uut.datamem.mem_array[3+256] = 2;
			
			uut.datamem.mem_array[4] = 40;
			uut.datamem.mem_array[4+256] = 20;
			
			uut.datamem.mem_array[5] = 60;
			uut.datamem.mem_array[5+256] = 0;
			
			uut.datamem.mem_array[6] = 0;
			uut.datamem.mem_array[6+256] = -1;
			
			uut.datamem.mem_array[7] = -50;
			uut.datamem.mem_array[7+256] = -25;
			
			uut.datamem.mem_array[8] = 50;
			uut.datamem.mem_array[8+256] = -25;
			
			uut.datamem.mem_array[9] = -69;
			uut.datamem.mem_array[9+256] = -0;

			uut.instructionmem.mem_array[1]  = 32'b001000_00110_00110_0000000000000001;
			uut.instructionmem.mem_array[2]  = 32'b100011_00001_00010_0000000000000000;
			uut.instructionmem.mem_array[3]  = 32'b100011_00001_00011_0000000100000000;
			uut.instructionmem.mem_array[4]  = 32'b000000_00010_00011_0010000000100010;
			uut.instructionmem.mem_array[5]  = 32'b000000_00100_00000_0010100000101010;
			uut.instructionmem.mem_array[6]  = 32'b000100_00110_00101_0000000000000100;
			uut.instructionmem.mem_array[7]  = 32'b000000_00111_00100_0011100000100000;
			uut.instructionmem.mem_array[8]  = 32'b001000_00001_00001_0000000000000001;
			uut.instructionmem.mem_array[9]  = 32'b000010_00000_00000_0000000000000010;
			uut.instructionmem.mem_array[10] = 32'b000000_00000_00100_0010000000100010;
			uut.instructionmem.mem_array[11] = 32'b000010_00000_00000_0000000000000111;

		
end
		
always forever #2 clk = ~clk;

endmodule