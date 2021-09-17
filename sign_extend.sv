module sign_extend(
	input logic [15:0] instruction,
	output logic [31:0] sign_extend

);

always_comb sign_extend = instruction[15] ? 32'hFFFF0000 + instruction : 32'h00000000 + instruction;

endmodule