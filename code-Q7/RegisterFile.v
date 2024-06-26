module RegisterFile (
    input clk,
    input read, write,
    input read_two, write_two,
    input [1 : 0] address,
    input [511 : 0] data_in,
    output reg [511 : 0] data_out,
    input [511 : 0] data_in_1, data_in_2,
    output reg [511 : 0] data_out_1, data_out_2
);
    reg [511 : 0] registers [0 : 3];

    always @(posedge clk) begin
        #1;
        if (read) begin
            data_out <= registers[address];
        end

        if (read_two) begin
            data_out_1 <= registers[0];
            data_out_2 <= registers[1];
        end
    end

    always @(negedge clk) begin
        if (write) begin
            registers[address] <= data_in;
        end

        if (write_two) begin
            registers[2] <= data_in_1;
            registers[3] <= data_in_2;
        end
    end

endmodule
