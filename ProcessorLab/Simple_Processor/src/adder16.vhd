library ieee;
use ieee.std_logic_1164.all;	

-- Declare the signals for the 16-bit adder
entity adder16 is
	port (
		A:	 in	std_logic_vector(15 downto 0);	-- Input 1
		B:	 in 	std_logic_vector(15 downto 0);	-- Input 2
		CI: in	std_logic;								-- Carry In
		O:	 out	std_logic_vector(15 downto 0);	-- Output (sum)
		CO: out  std_logic								-- Carry out
	);
end entity adder16;

-- Declare the functionality of the 16-bit adder
architecture func of adder16 is

	-- Implement the FullAdder component of the 16-bit adder
	component FullAdder is
		port (
			A:     in 	std_logic;
			B:     in 	std_logic;
			Cin:   in	std_logic;
			sum:   out	std_logic;
			Cout:  out	std_logic
		);
	end component FullAdder;
	
	-- Internal carry signal
	signal carry_internal: std_logic_vector(16 downto 0);
	
begin
	
	-- Generate the 16 fullAdder components
	adders: for N in 0 to 15 generate
	
		-- Map the signals for each of the fullAdders
		myFullAdder: FullAdder
			port map (
				A    =>	A(N),
				B    =>	B(N),
				Cin  =>	carry_internal(N),
				Cout =>  carry_internal(N+1),
				sum  =>	O(N)
			);
			
	end generate;
	
	-- Set the carry signals appropriately.
	carry_internal(0) <= CI;
	CO <= carry_internal(16);
	
end func;