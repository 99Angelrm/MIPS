module registers(
	input  logic 		  clk,
	input  logic 		  rst,
	input  logic  		  RegWrite,
	input  logic [4:0]  Reg_1_addr,
	input  logic [4:0]  Reg_2_addr,
	input  logic [4:0]  Write_reg,
	input  logic [31:0] Write_data,
	output logic [31:0] Rd_data_1,
   	output logic [31:0] Rd_data_2
);	 
	 integer i;

	 logic [31:0] mem [0:31];
	 
		always_ff @(posedge clk or posedge rst)
			begin
				if (rst)
					for(i = 0; i <= 31; i = i+1)
						mem[i] <= 0;
				else if (RegWrite)
					mem[Write_reg] <= (Write_reg !='0) ? Write_data : '0;
			end
			
		always_comb begin
			Rd_data_1 = mem[Reg_1_addr];
			Rd_data_2 = mem[Reg_2_addr];
		end
		
endmodule
