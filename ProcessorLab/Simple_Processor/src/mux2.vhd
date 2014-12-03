library ieee;
use ieee.std_logic_1164.all;
 
entity mux2 is
	port(
		A: in std_logic_vector(15 downto 0);
		B: in std_logic_vector(15 downto 0);
		S: in std_logic;
		Z: out std_logic_vector(15 downto 0)
	);
end entity mux2;
 
architecture behavioral of mux2 is
begin
	Z <= A when S = '0' else B;
end architecture behavioral;