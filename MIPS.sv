module MIPS (

	input  logic 		clk,
	input  logic 		rst,
	input  logic		clr,
	output logic [31:0]	pc_out	

	);

	logic [31:0] addr,muxout_alusrc,datamem_out,alu_result;
	logic [31:0] inst;
	logic [4:0] WriteRegister;

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
	control control(
		.instruction(inst[31:26]),
		.instruction_2(inst[5:0]),
		.jmp(jmp),
		.RegDst(RegDst),
		.Branch(branch),
		.MemRead(MemRead),
		.MemtoReg(MemtoReg),
		.AluControl(AluControl),
		.MemWrite(MemWrite),
		.ALUSrc(ALUSrc),
		.RegWrite(RegWrite)
	);

	always_comb WriteRegister = RegDst ? inst[15:11] : inst[20:16];
	registers registers(
	.clk(clk),
	.rst(rst),
	.RegWrite(RegWrite),
	.Reg_1_addr(inst[25:21]),
	.Reg_2_addr(inst[20:16]),
	.Write_reg(	WriteRegister),
	.Write_data(WriteData),
	.Rd_data_1(ReadData_1),
   	.Rd_data_2(ReadData_2)
	);
	
	multiplexer mux_alusrc(
		.A(ReadData_2),
		.B(signExtend),
		.control_signal(ALUSrc),
		.muxout(muxout_alusrc)
	
	);
	
	ALU alu(
		.read_data_1(ReadData_1),
		.mux_alu_src(muxout_alusrc),
		.control_input(AluControl),
		.alu_result(alu_result)
	
	);
	
	datamem datamem(
		.clk(clk),
		.rst(rst),
		.address(alu_result),
		.rd(MemRead),
		.wr(MemWrite),
		.W_data(ReadData_2),
		.R_data(datamem_out)
	);
	
	multiplexer mux_datamem(
		.A(alu_result),
		.B(datamem_out),
		.control_signal(MemtoReg),
		.muxout(WriteData)
	
	);
	
	sign_extend sign_extend(
		.instruction(inst[15:0]),
		.sign_extend(signExtend)
	);
	
	

endmodule