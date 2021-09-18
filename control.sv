typedef enum logic [3:0]
{
	ADD	= 4'b0000,
	ADDI	= 4'b0001,
	SUB	= 4'b0010,
	AND	= 4'b0011,
	OR		= 4'b0100,
	SLT	= 4'b0101,	
	LW		= 4'b0110,
	SW		= 4'b0111,
	BEQ	= 4'b1000,
	JMP	= 4'b1001,
	ERROR	= 4'bxXXX

} t_cntrl_operation;


module control(		input  logic [5:0]	instruction,
					input  logic [5:0]   instruction_2,
					output logic 			jmp,
					output logic			RegDst,
					output logic 			Branch,
					output logic 			MemRead,
					output logic 			MemtoReg,
					output logic [3:0]  	AluControl,
					output logic 			MemWrite,
					output logic 			ALUSrc,
					output logic 			RegWrite
					);

t_cntrl_operation	operation;   	// Enumerated Defined type variable for operation
	always_comb begin
		operation = ERROR;
		case(instruction)
				6'h0	: 	begin
							case(instruction_2)
							6'b100000 : operation = ADD;
							6'b100010 : operation = SUB;
							6'b100100 : operation = AND;
							6'b100101 : operation = OR;
							6'b101010 : operation = SLT;
		 					endcase
							end
				6'h8	: operation = ADDI;
				6'h23 : operation = LW;
				6'h2B : operation = SW;
				6'h4  : operation = BEQ;
				6'h2 	: operation = JMP;
		endcase
	end
	
	always_comb begin
		RegDst     = 1'b0;
		Branch     = 1'b0;
		MemRead    = 1'b0;
		MemtoReg   = 1'b0;
		AluControl = 4'h0;  
		MemWrite   = 1'b0;
		ALUSrc     = 1'b0;
		RegWrite   = 1'b0;
		jmp		  = 1'b0;
		case(operation)
			ADD	: 	begin
							RegDst     = 1'b1;
							RegWrite   = 1'b1;
							AluControl = 4'h2;
						end
		   ADDI	:	begin
							
						end
		   SUB	: 	begin
							RegDst     = 1'b1;
							RegWrite   = 1'b1;
							AluControl = 4'h6;
						end
		   AND	: 	begin
							RegDst   = 1'b1;
							RegWrite = 1'b1;
						end
		   OR		: 	begin
							RegDst     = 1'b1;
							RegWrite   = 1'b1;
							AluControl = 4'h1;
						end
	      SLT	:	begin
							RegDst     = 1'b1;
							RegWrite   = 1'b1;
							AluControl = 4'h7;
						end
         LW		:	begin
							RegWrite   = 1'b1;
							ALUSrc 	  = 1'b1;
							AluControl = 4'h2;
							MemRead    = 1'b1;
							MemtoReg   = 1'b1;
						end
         SW		:	begin
							ALUSrc     = 1'b1;	  
							AluControl = 4'h2;
							MemWrite   = 1'b1;
						end
         BEQ 	:	begin
							AluControl = 4'h6;
							Branch=1'b1;
						end
         JMP	:	begin
							jmp=1'b1;
						end
		endcase
	end
endmodule