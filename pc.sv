module pc (

	input  logic 		clk,
	input  logic 		rst,
	input  logic		clr,
	input  logic [31:0]	signExtend,
	input  logic 		branch,
	input  logic		zero,
	input  logic		jmp,
	output logic [31:0]	progcntr
	
);
	//Wires
	logic		and_BZ;
	logic [31:0]	newProgcntr;

	always_comb and_BZ = branch & zero; //AND for branch and zero

	// Program counter hardware description
	always_ff @ (posedge clk)
		if (rst|clr)
			progcntr <= '0;
		else if (and_BZ)
			progcntr <= newProgcntr;
		else if (jmp)
			progcntr <= signExtend; //jump to the specfified address
		else	//always done, no need for fetch
			progcntr <= progcntr + 1'b1; //Add 1, instructions are 32 bits wide

	always_comb begin
	newProgcntr <= (signExtend[31]==1'b0) ? progcntr + signExtend : progcntr - ~signExtend + 1;//{8'hff,instruction_reg[7:0]}-1'b1 ;
	end

endmodule