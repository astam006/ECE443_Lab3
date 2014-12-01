-- VHDL Code to implement a Full Adder

-- Implementing an OR Gate required for Full Adder
library ieee;
use ieee.std_logic_1164.all;

-- Assigning inputs and outputs
entity orGate is
	port(A, B : in std_logic;
			  F : out std_logic);
end orGate;

-- Implementing gate functionality
architecture func of orGate is
begin
	F <= A or B;
end func;

--\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

-- Implementing the Full Adder
library ieee;
use ieee.std_logic_1164.all;

entity FullAdder is
	port(A, B, Cin : in std_logic;
		  sum, Cout : out std_logic);
end FullAdder;

-- Implementing the Full Adder functionality
architecture func of fullAdder is

	-- Importing a halfAdder component
	component half_Adder is
		port(A, B : in std_logic;
				  sum, Cout : out std_logic);
	end component;
	
	-- Importing an OR gate component
	component orGate is
		port(A, B : in std_logic;
				  F : out std_logic);
	end component;
	
	signal halfAdder_to_halfAdder, halfAdder_to_Or1, halfAdder_to_Or2 : std_logic;
	
begin
	Gate_1: half_Adder port map(A, B, halfAdder_to_halfAdder, halfAdder_to_Or1);
	Gate_2: half_Adder port map(halfAdder_to_halfAdder, Cin, sum, halfAdder_to_Or2);
	Gate_3: orGate port map(halfAdder_to_Or1, halfAdder_to_Or2, Cout);
end func;