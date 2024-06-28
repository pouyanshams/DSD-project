library verilog;
use verilog.vl_types.all;
entity ALU is
    port(
        clock           : in     vl_logic;
        operation       : in     vl_logic;
        input_data_1    : in     vl_logic_vector(511 downto 0);
        input_data_2    : in     vl_logic_vector(511 downto 0);
        output_data_1   : out    vl_logic_vector(511 downto 0);
        output_data_2   : out    vl_logic_vector(511 downto 0)
    );
end ALU;
