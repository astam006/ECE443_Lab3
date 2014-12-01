library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity ram_256_byte is
	port ( 
		clock, rw, cs: in std_logic;
		address: in std_logic_vector(7 downto 0);
		PortIn: in std_logic_vector(7 downto 0);
		PortOut: out std_logic_vector(7 downto 0)
	);
end ram_256_byte;

architecture behavioral of ram_256_byte is
type ram_array is array(0 to 255) of std_logic_vector(7 downto 0);
signal ram : ram_array;
begin
	process(clock,rw,cs)
	begin
		if (cs='1') then
			if (rising_edge(clock)) then
				if(rw='1') then
					ram(conv_integer(address))<= PortIn;
				else				  
					PortOut <= ram(conv_integer(address));
				end if;
			end if;
		else
			PortOut <= "ZZZZZZZZ";
		end if;
	end process;
end architecture behavioral;