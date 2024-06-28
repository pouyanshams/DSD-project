module TB;
reg [1 : 0] opcode, regAddresss;
reg [4 : 0] memoryAddress;
integer i;

VectorProcessor vectorProcessor(opcode, regAddresss, memoryAddress);

initial begin
    for (i = 0; i < 32; i = i + 1) begin
        vectorProcessor.memory.mem[i] = i;
    end

    for (i = 32; i < 512; i = i + 1) begin
        vectorProcessor.memory.mem[i] = 2 ** (i % 32);
    end
    #100;

    //load
    opcode = 2; 
    regAddresss = 0; memoryAddress = 0;
    #10;
    regAddresss = 1; memoryAddress = 1;
    #10;
    //sum
    opcode = 0;
    #10;
    //store
    opcode = 3; 
    regAddresss = 2; memoryAddress = 31;
    #10;
    regAddresss = 3; memoryAddress = 30;
    #10;
    //load
    opcode = 2; 
    regAddresss = 0; memoryAddress = 20;
    #10;
    regAddresss = 1; memoryAddress = 21;
    #10;
    //multiply
    opcode = 1; 
    #10;
    //store
    opcode = 3;
    regAddresss = 2; memoryAddress = 16;
    #10;
    regAddresss = 3; memoryAddress = 15;
    #10;

    $display("\n\nReding the result of sum answer from adress:\n");

    for (i = 496; i < 512; i = i + 1) begin
        $display("ADDRESS %d: %d", i, vectorProcessor.memory.mem[i]);
    end

    $display("\n\nReading the result of multiplication answer from address :\n");

    for (i = 240; i < 272; i = i + 1) begin
        $display("ADDRESS %d: %b", i, vectorProcessor.memory.mem[i]);
    end

    $stop;

end

endmodule

