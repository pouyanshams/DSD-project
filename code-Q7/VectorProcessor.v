module VectorProcessor (
    input [1 : 0] opcode, rf_address,
    input [4 : 0] mem_address
);

    // Initializing upcodes:
    localparam ADDITION = 0;
    localparam MULTIPLY = 1;
    localparam LOAD = 2;
    localparam STORE = 3;

    // Control signals:
    reg clk, mem_read, mem_write, rf_read, rf_write, read_two_regs, write_two_regs;

    // Data :
    reg [511 : 0] rf_in_1, rf_in_2;
    wire [511 : 0] rf_out_1, rf_out_2;

    wire [511 : 0] mem_data_in, mem_data_out, rf_data_in, rf_data_out;

    // ALU Input & Outputs:
    reg [511 : 0] alu_in_1, alu_in_2;
    wire [511 : 0] alu_out_1, alu_out_2;

    // Instancing modules:
    ALU alu(clk, opcode[0], alu_in_1, alu_in_2, alu_out_1, alu_out_2);
    MainMemory main_memory (clk, mem_read, mem_write, mem_address, mem_data_in, mem_data_out);
    RegisterFile register_file (
        .clk(clk),
        .read(rf_read),
        .write(rf_write),
        .read_two(read_two_regs),
        .write_two(write_two_regs),
        .address(rf_address),
        .data_in(rf_data_in),
        .data_out(rf_data_out),
        .data_in_1(rf_in_1),
        .data_in_2(rf_in_2),
        .data_out_1(rf_out_1),
        .data_out_2(rf_out_2)
    );

    // Doing task:
    assign mem_data_in = opcode[1] ? rf_data_out : {512{1'bz}};
    assign rf_data_in = opcode[1] ? mem_data_out : {512{1'bz}};

    always @(posedge clk) begin
        case (opcode)

            ADDITION, MULTIPLY : begin
                mem_read = 0; mem_write = 0;
                rf_read = 0; rf_write = 0;
                read_two_regs = 1; write_two_regs = 1;
                #2; // 2 units delay for register_file
                alu_in_1 <= rf_out_1;
                alu_in_2 <= rf_out_2;
                #2; // 2 units delay for alu
                rf_in_1 <= alu_out_1;
                rf_in_2 <= alu_out_2;
                // now the data is ready for write in registerfile before negedge of clock
            end

            LOAD: begin
                mem_read = 1; mem_write = 0;
                rf_read = 0; rf_write = 1;
                read_two_regs = 0; write_two_regs = 0;
            end 

            STORE: begin
                mem_read = 0; mem_write = 1;
                rf_read = 1; rf_write = 0;
                read_two_regs = 0; write_two_regs = 0;
            end

        endcase
    end

    initial begin
        clk = 1;
        forever #5 clk = ~clk;
    end

endmodule