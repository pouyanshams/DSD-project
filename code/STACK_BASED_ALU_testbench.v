module STACK_BASED_ALU_testbench;
	reg clk;
	reg signed [31:0] input_data;
	reg [2:0] opcode;

	wire signed [31:0] output_data;
	wire overflow;
	wire invalid;

	STACK_BASED_ALU uut(
		.clk(clk),
		.input_data(input_data),
		.opcode(opcode),
		.output_data(output_data),
		.overflow(overflow),
		.invalid(invalid)
	);

	initial clk = 0;

	always #5 clk = ~clk;

	initial begin
		input_data = 0;
		opcode = 0;

		// Wait 10 pulses for initialization
		#100;
		
		input_data = 10;
		#50;
		opcode = 110;
		#10;
		opcode = 0;
		#50;
		opcode = 100;
		#10;
		opcode = 0;
		#50;
		input_data = 22;
		#50;
		opcode = 110;
		#10;
		opcode = 0;
		#50;
		opcode = 100;
		#10;
		opcode = 0;
		#50;
		input_data = 2000000000;
		#50;
		opcode = 110;
		#10;
		opcode = 0;
		#50;
		opcode = 110;
		#10;
		opcode = 0;
		#50;
		opcode = 100;
		#10;
		opcode = 0;
		#50;
		opcode = 111;
		#10;
		opcode = 0;
		#50;
		opcode = 111;
		#10;
		opcode = 0;
		#50;
		opcode = 111;
		#10;
		opcode = 0;
		#50;
		opcode = 111;
		#10;
		opcode = 0;
		#50;
		opcode = 111;
		#10;
		opcode = 0;
		#50;
		input_data = -3;
		#50;
		opcode = 110;
		#10;
		opcode = 0;
		#50;
		opcode = 101;
		#10;
		opcode = 0;
		#50;
		input_data = -5;
		#50;
		opcode = 110;
		#10;
		opcode = 0;
		#50;
		opcode = 101;
		#10;
		opcode = 0;
		#50;
		input_data = 2000000;
		#50;
		opcode = 110;
		#10;
		opcode = 0;
		#50;
		input_data = -1000000;
		#50;
		opcode = 110;
		#10;
		opcode = 0;
		#50;
		opcode = 101;
		#10;
		opcode = 0;
		#50;
	end
endmodule
