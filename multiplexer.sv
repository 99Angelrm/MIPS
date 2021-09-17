module multiplexer(
	input logic [31:0] A,
	input logic [31:0] B,
	input logic control_signal,
	output logic [31:0] muxout

);

always_comb muxout = (control_signal==0) ? A:
							(control_signal==1) ? B:
							1'bx;
							
endmodule