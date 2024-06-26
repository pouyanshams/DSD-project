module STACK_BASED_ALU(
	input clk,
	input signed[31:0] input_data,
	input[2:0] opcode,
	output reg signed[31:0] output_data,
	output reg overflow,
	output reg invalid
);
	reg signed[31:0] stack[1023:0];

	integer i, index, temp;
	reg negative;

	initial begin
		output_data = 0;
		overflow = 0;
		invalid = 0;
		index = 0;
		for (i = 0; i < 1024; i = i + 1)
			stack[i] = 0;
	end

	always @ (posedge clk) begin
		if (opcode[2] == 1) begin
			if (opcode == 3'b100) begin
				if (index < 2) begin
					invalid = 1;
					output_data = 0;
					overflow = 0;
				end
				else begin
					invalid = 0;
					output_data = stack[index - 1] + stack[index - 2];
					overflow = (((stack[index - 1] > 0) == (stack[index - 2] > 0)) && (output_data > 0 != stack[index - 1] > 0));
				end
			end
			else if (opcode == 3'b101) begin
				if (index < 2) begin
					invalid = 1;
					output_data = 0;
					overflow = 0;
				end
				else begin
					invalid = 0;
					output_data = 0;
					overflow = 0;
					if (stack[index - 2] != 0) begin
						negative = stack[index - 2] < 0;
						if (negative)
							stack[index - 2] = -stack[index - 2];
						for (i = 0; i < stack[index - 2]; i = i + 1) begin
							temp = stack[index - 1] + output_data;
							overflow = overflow | (((stack[index - 1] > 0) == (output_data > 0)) && (temp > 0 != output_data > 0));
							output_data = temp;
						end
						if (negative) begin
							stack[index - 2] = -stack[index - 2];
							output_data = -output_data;
						end
					end
				end
			end
			else if (opcode == 3'b110) begin
				output_data = 0;
				overflow = 0;
				if (index < 1024) begin
					stack[index] = input_data;
					index = index + 1;
					invalid = 0;
				end
				else
					invalid = 1;
			end
			else if (opcode == 3'b111) begin
				output_data = 0;
				overflow = 0;
				if (index > 0) begin
					index = index - 1;
					invalid = 0;
				end
				else
					invalid = 1;
			end
		end
	end
endmodule
