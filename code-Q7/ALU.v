module ALU (
    input clock,
    input operation,
    input [511 : 0] input_data_1, input_data_2,
    output reg [511 : 0] output_data_1, output_data_2
);
    
    localparam ADD = 1'b0;
    localparam MULL = 1'b1;

    integer i;

    always @(posedge clock) begin
        #3;
        case (operation)
            ADD: begin
                for (i = 1; i < 17; i = i + 1) begin
                    {output_data_2[32*i-1 -: 32], output_data_1[32*i-1 -: 32]} <=
                    input_data_1[32*i-1 -: 32] + input_data_2[32*i-1 -: 32];                   
                end
            end

            MULL: begin
                for (i = 1; i < 17; i = i + 1) begin
                    {output_data_2[32*i-1 -: 32], output_data_1[32*i-1 -: 32]} <=
                    input_data_1[32*i-1 -: 32] * input_data_2[32*i-1 -: 32];
                end
            end
    endcase
    end

endmodule

