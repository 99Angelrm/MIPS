module control_tb();
    logic [5:0]	instruction;
    logic [5:0] instruction_2;
    logic 		jmp;
    logic		RegDst;
    logic 		Branch;
    logic 		MemRead;
    logic 		MemtoReg;
    logic [3:0] AluControl;
    logic 		MemWrite;
    logic 		ALUSrc;
    logic 		RegWrite;
    logic [31:0] fullinstruction;
    control control(.*);
    initial begin
        fullinstruction=32'b00000000010001000001000000100000;
        instruction=fullinstruction[31:26];
        instruction_2=fullinstruction[5:0];
        #10
        fullinstruction=32'b00010001000000000000000000000011;
        instruction=fullinstruction[31:26];
        instruction_2=fullinstruction[5:0];

    end
endmodule