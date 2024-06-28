library verilog;
use verilog.vl_types.all;
entity VectorProcessor is
    port(
        opcode          : in     vl_logic_vector(1 downto 0);
        regAddress      : in     vl_logic_vector(1 downto 0);
        memoryAddress   : in     vl_logic_vector(4 downto 0)
    );
end VectorProcessor;
