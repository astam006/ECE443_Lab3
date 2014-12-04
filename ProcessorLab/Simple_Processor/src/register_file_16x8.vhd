library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity register_file_16x8 is
    port (
        RegWrite, Clk:  in  std_logic;
        WriteRegNum:    in  std_logic_vector (2 downto 0);
        WriteData:      in  std_logic_vector (15 downto 0);
        ReadRegNumA:    in  std_logic_vector (2 downto 0);
        ReadRegNumB:    in  std_logic_vector (2 downto 0);
        PortA:          out std_logic_vector (15 downto 0);
        PortB:          out std_logic_vector (15 downto 0)
    );
end entity;

architecture behavioral of register_file_16x8 is

    type register_array is array (0 to 7) of std_logic_vector(15 downto 0);
    signal register_file: register_array;

    begin 
    process(Clk)
    begin
		if(rising_edge(Clk))then
	        if RegWrite='1' then
	            register_file(to_integer(unsigned(WriteRegNum))) <= WriteData;
	        end if;
		end if;
    end process;

    PortA <= register_file(to_integer(unsigned(ReadRegNumA)));

    PortB  <= register_file(to_integer(unsigned(ReadRegNumB)));

end architecture;