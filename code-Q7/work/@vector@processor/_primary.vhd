library verilog;
use verilog.vl_types.all;
entity VectorProcessor is
    port(
        opcode          : in     vl_logic_vector(1 downto 0);
        rf_address      : in     vl_logic_vector(1 downto 0);
        mem_address     : in     vl_logic_vector(4 downto 0)
    );
end VectorProcessor;
