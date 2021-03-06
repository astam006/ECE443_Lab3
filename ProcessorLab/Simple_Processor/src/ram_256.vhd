library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity ram_256 is
	port ( 
		clock, rw, cs: in std_logic;
		address: in std_logic_vector(15 downto 0);
		DataIn: in std_logic_vector(15 downto 0);
		DataOut: out std_logic_vector(15 downto 0)
	);
end ram_256;

architecture behavioral of ram_256 is
type ram_array is array(0 to 255) of std_logic_vector(15 downto 0);
signal ram : ram_array;
begin
	process(clock,rw,cs)
	begin
		if (cs='1') then   --chip select (not necessary for this lab but may help with debugging)
			if (rising_edge(clock)) then
				if(rw='1') then
					ram(conv_integer(address))<= DataIn;
				end if;				  
			end if;
		end if;
	end process;
	DataOut <= ram(conv_integer(address));
end architecture behavioral;