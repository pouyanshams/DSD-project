module TestBenchProcessor;

reg [1 : 0] opcode, rf_address;
reg [4 : 0] mem_address;

integer i;

VectorProcessor vectorProcessor(opcode, rf_address, mem_address);

initial begin
    for (i = 0; i < 32; i = i + 1) begin
        vectorProcessor.main_memory.mem[i] = i;
    end

    for (i = 32; i < 512; i = i + 1) begin
        vectorProcessor.main_memory.mem[i] = 2 ** (i % 32);
    end
    #100;

    $monitor("Time: %t | opcode = %b | rf_address = %d | mem_address = %d"
    , $time, opcode, rf_address, mem_address);

    $display("Doing sum on first two vectors and write Results on last two vectors :\n");

    opcode = 2; // Load
    rf_address = 0; mem_address = 0;
    #10;
    rf_address = 1; mem_address = 1;
    #10;

    opcode = 0; // Sum
    #10;

    opcode = 3; // Store
    rf_address = 2; mem_address = 31;
    #10;
    rf_address = 3; mem_address = 30;
    #10;

    $display("\nDoing multiply on second and third vectors and write Results on 15th and 16th vectors :\n");

    opcode = 2; // Load
    rf_address = 0; mem_address = 20;
    #10;
    rf_address = 1; mem_address = 21;
    #10;

    opcode = 1; // Multiply
    #10;

    opcode = 3; // Store
    rf_address = 2; mem_address = 16;
    #10;
    rf_address = 3; mem_address = 15;
    #10;

    $display("\n Results of msb sum :\n");

    for (i = 480; i < 496; i = i + 1) begin
        $display("Reading data from address %d: %d", i, vectorProcessor.main_memory.mem[i]);
    end

    $display("\n Results of lsb sum :\n");

    for (i = 496; i < 512; i = i + 1) begin
        $display("Reading data from address %d: %d", i, vectorProcessor.main_memory.mem[i]);
    end

    $display("\n Results of msb multiply :\n");

    for (i = 240; i < 256; i = i + 1) begin
        $display("Reading data from address %d: %b", i, vectorProcessor.main_memory.mem[i]);
    end

    $display("\n Results of lsb multiply :\n");

    for (i = 256; i < 272; i = i + 1) begin
        $display("Reading data from address %d: %b", i, vectorProcessor.main_memory.mem[i]);
    end

    $stop;

end

endmodule

