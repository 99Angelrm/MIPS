module datamem (
	input logic clk,
	input logic rst,
	input logic [31:0] address,
	input logic rd,
	input logic wr,
	input logic [31:0] W_data,
	output logic [31:0] R_data
);

logic [31:0] mem_array [0:255];

	always_ff @ (posedge clk)
		begin
			if(wr)
				mem_array[address]<=W_data;
		end
		
	
	always_comb R_data = rd ? mem_array[address] : 'Z;
	
endmodule