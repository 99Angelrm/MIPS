module ALU(
	input logic [31:0] read_data_1,
	input logic [31:0] mux_alu_src,
	input logic [3:0] control_input,
	output logic zero,
	output logic [31:0] alu_result
);



always_comb alu_result = (control_input==0) ? read_data_1 & mux_alu_src :
								 (control_input==1) ? read_data_1 | mux_alu_src :
								 (control_input==2) ? read_data_1 + mux_alu_src :
								 (control_input==6) ? read_data_1 - mux_alu_src :
								 (control_input==7) & (read_data_1 <= mux_alu_src) ? 32'h00000001:
								 (control_input==7) & ~(read_data_1 <= mux_alu_src) ? 32'h00000000:
								 (control_input==12) ? ~(read_data_1 | mux_alu_src) :
								 1'bx;
								 
always_comb zero = (alu_result==0) ? 1'b1:1'b0;
								 
endmodule