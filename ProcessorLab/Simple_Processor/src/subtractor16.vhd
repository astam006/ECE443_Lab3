library ieee;
use ieee.std_logic_1164.all;

-- Declare the 16-bit subtractor entity
entity subtractor16 is
	port (
		A:      in  std_logic_vector(15 downto 0); --Input 1
		B: 	  in  std_logic_vector(15 downto 0); --Input 2
		borrow: out std_logic;							 --Borrow bit
		diff:	  out std_logic_vector(15 downto 0)  --Difference Signal
		);
end subtractor16;

--Declare functionality of the 16-bit subtractor
architecture subtract of subtractor16 is

--Declare the 16-bit adder to be used 
component adder16 is
	port (
	   A:	 in	std_logic_vector(15 downto 0);	-- Input 1
		B:	 in 	std_logic_vector(15 downto 0);	-- Input 2
		CI: in	std_logic;								-- Carry In
		O:	 out	std_logic_vector(15 downto 0);	-- Output (sum)
		CO: out  std_logic								-- Carry out
	
	);
end component adder16;

signal temp : std_logic_vector(15 downto 0);		-- Temporary signal used for 2's complement

-- To implement the subtractor, the 2's complement of signal B is taken, then it is passed
-- with signal A into a 16-bit adder with a carry-in signal of 1, and the 16-bit adder will
-- then compute a subtraction and store the result in diff.
begin
	temp <= not B;
	
	G_1:	adder16 port map(A, temp, '1', diff, borrow);	-- Mapping the signals to the 16-bit adder.
end subtract;

