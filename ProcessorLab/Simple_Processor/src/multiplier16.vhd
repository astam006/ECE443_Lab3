library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;	
use ieee.std_logic_unsigned.all;

--Define multiplier signals.
entity multiplier16 is
port 
	(
		A			: in std_logic_vector  (15 downto 0);
		B			: in std_logic_vector  (15 downto 0);
		product	: out std_logic_vector (31 downto 0)
	);

end entity;

--Architecture of a shift and add multiplier.
--Due to the extensive code required for using 16-bit adders,
--the following structure implements the same functionality.
architecture multiply of multiplier16 is

--Internal temporary signal.
signal x : std_logic_vector(31 downto 0);

begin

	--Internal process for multiplication.
	product <= A * B after 30ns;
		
end multiply;