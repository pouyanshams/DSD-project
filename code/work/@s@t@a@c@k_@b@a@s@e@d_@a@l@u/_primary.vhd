library verilog;
use verilog.vl_types.all;
entity STACK_BASED_ALU is
    port(
        clk             : in     vl_logic;
        input_data      : in     vl_logic_vector(31 downto 0);
        opcode          : in     vl_logic_vector(2 downto 0);
        output_data     : out    vl_logic_vector(31 downto 0);
        overflow        : out    vl_logic;
        invalid         : out    vl_logic
    );
end STACK_BASED_ALU;
