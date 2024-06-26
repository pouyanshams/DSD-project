library verilog;
use verilog.vl_types.all;
entity RegisterFile is
    port(
        clk             : in     vl_logic;
        read            : in     vl_logic;
        write           : in     vl_logic;
        read_two        : in     vl_logic;
        write_two       : in     vl_logic;
        address         : in     vl_logic_vector(1 downto 0);
        data_in         : in     vl_logic_vector(511 downto 0);
        data_out        : out    vl_logic_vector(511 downto 0);
        data_in_1       : in     vl_logic_vector(511 downto 0);
        data_in_2       : in     vl_logic_vector(511 downto 0);
        data_out_1      : out    vl_logic_vector(511 downto 0);
        data_out_2      : out    vl_logic_vector(511 downto 0)
    );
end RegisterFile;
