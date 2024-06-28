library verilog;
use verilog.vl_types.all;
entity Memory is
    port(
        clk             : in     vl_logic;
        read            : in     vl_logic;
        write           : in     vl_logic;
        address         : in     vl_logic_vector(4 downto 0);
        data_in         : in     vl_logic_vector(511 downto 0);
        data_out        : out    vl_logic_vector(511 downto 0)
    );
end Memory;
