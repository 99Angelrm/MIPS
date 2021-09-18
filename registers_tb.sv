module registers_tb();

    logic           clk;
    logic           rst;
    logic           RegWrite;
    logic [4:0]     Reg_1_addr;
    logic [4:0]     Reg_2_addr;
    logic [4:0]     Write_reg;
    logic [31:0]    Write_data;
    logic [31:0]    Rd_data_1;
    logic [31:0]    Rd_data_2;
    integer  i;
    logic [15:0] randdata;
    registers registers(.*);

initial begin
    clk=0;
    rst=1;
    #10;
      	rst = 0;
        for ( i=0 ; i<31 ;i = i + 1) begin
        randdata = $random();
        registers.mem[i] = {24'h0,randdata[7:0]};  
        end
    #2
        RegWrite=1'b1;
        Write_reg=5'h0_0;
        Write_data=32'h1;
    #2
        RegWrite=1'b0;
        Write_data=32'h2;
    #2
        Reg_1_addr='0;
        Reg_2_addr=32'h1;
    #2
        RegWrite=1'b1;

    
end

always forever #1 clk = ~clk;
endmodule