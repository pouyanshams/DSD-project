module VectorProcessor (
    input [1 : 0] opcode, regAddress,
    input [4 : 0] memoryAddress
);
    localparam ADD = 0; localparam MUL = 1; localparam LOAD = 2; localparam STORE = 3;
    reg clk, mem_read, mem_write, reg_read, reg_write, readTwo, writeTwo;

    reg [511 : 0] registerin1, registerin2; wire [511 : 0] registerout1, registerout2; wire [511 : 0] memoryDataIn, memoryDataOut, registerDataIn, registerDataOut;
    reg [511 : 0] AluIN1, AluIN2;
    wire [511 : 0] AluOut1, AluOut2;

    ALU alu(clk, opcode[0], AluIN1, AluIN2, AluOut1, AluOut2);
    Memory memory (clk, mem_read, mem_write, memoryAddress, memoryDataIn, memoryDataOut);
    RegisterFile register_file (
        .clk(clk), .read(reg_read), .write(reg_write),.read_two(readTwo),.write_two(writeTwo),
        .address(regAddress),.data_in(registerDataIn),.data_out(registerDataOut),.data_in_1(registerin1),.data_in_2(registerin2),
         .data_out_1(registerout1),.data_out_2(registerout2)
    );

    assign memoryDataIn = opcode[1] ? registerDataOut : {512{1'bz}};
    assign registerDataIn = opcode[1] ? memoryDataOut : {512{1'bz}};

    always @(posedge clk) begin
        case (opcode)

            ADD, MUL : begin
                mem_read = 0; mem_write = 0;
                reg_read = 0; reg_write = 0;
                readTwo = 1; writeTwo = 1;
                #2; 
                AluIN1 <= registerout1;
                AluIN2 <= registerout2;
                #2; 
                registerin1 <= AluOut1;
                registerin2 <= AluOut2;
            end

            LOAD: begin
                mem_read = 1; mem_write = 0;
                reg_read = 0; reg_write = 1;
                readTwo = 0; writeTwo = 0;
            end 
            STORE: begin
                mem_read = 0; mem_write = 1;
                reg_read = 1; reg_write = 0;
                readTwo = 0; writeTwo = 0;
            end

        endcase
    end

    initial begin
        clk = 1;
        forever #5 clk = ~clk;
    end

endmodule