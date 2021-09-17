module MIPS (

	input  logic 		clk,
	input  logic 		rst,
	input  logic		clr,
	output logic [31:0]	pc_out	

	);

	logic [31:0] addr;
	logic [31:0] inst;

	always_comb pc_out = addr;

	pc pc (

		.clk(clk), //input clock
		.rst(rst), //input reset
		.clr(clr), //input clear
		.signExtend(signExtend), //input signExtend offset or address
		.branch(branch), //input control signal branch
		.zero(zero), //input control signal zero
		.jmp(jmp), //input control signal jmp
		.progcntr(addr) //output progcntr to instructionmem addr

		);

	instructionmem instructionmem (

		.raddr(addr), 
		.ren('0), 
		.data_out(inst), 
		.waddr('0), 
		.data_in('0), 
		.we(1'b0), 
		.clk('0)

		);

endmodule