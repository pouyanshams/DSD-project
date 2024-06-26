module MainMemory (
    input clk,
    input read, write,
    input [4 : 0] address,
    input [511 : 0] data_in,
    output reg [511 : 0] data_out
);
    reg [31 : 0] mem [0 : 511];

    integer i;

    always @(posedge clk) begin
        #1;
        if (read) begin
            for (i = 1; i < 17; i = i + 1) begin
                data_out[32*i-1 -: 32] <= mem[16 * address + i - 1];
            end
        end
    end

    always @(negedge clk) begin
        if (write) begin
            for (i = 1; i < 17; i = i + 1) begin
                mem[16 * address + i - 1] <= data_in[32*i-1 -: 32];
            end
        end
    end

endmodule

