module instructionmem(
	input logic [31:0] 	raddr,
	input logic [31:0] 	waddr,
	input logic [31:0] 	data_in,
	input logic 		we,    // Write Enable
	input logic  		ren,   // Read  Enable
	input logic  		clk,
	output logic [31:0] data_out
);

	logic [31:0] mem_array [0:4095]; //mem_array with 32 bits wide and 4096 elements

      	always_ff @(posedge clk)
        begin
        if (we)
		mem_array[waddr] = data_in;
        end

	always_comb data_out = ren ? mem_array[raddr] : 'Z;
		
endmodule