--VHDL Code for implementing a half-adder
library ieee;
use ieee.std_logic_1164.all;

--Creating the AND gate required for the half-adder
entity andGate is
	port(A, B : in std_logic;
		     F : out std_logic);
end andGate;

--Implementing the functionality of the gate.
architecture func of andGate is
begin
	F <= A and B after 30ns;	--Compute the output after an appropriate gate delay.
end func;

--\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

library ieee;
use ieee.std_logic_1164.all;

-- Defining the XOR requried for the half-adder
entity xorGate is
	port(A, B : in std_logic;
			  F : out std_logic);
end xorGate;

--Implementing the functionality of the gate
architecture func of xorGate is
begin
	F <= A xor B after 30ns; --Compute the output after an appropriate gate delay.
end func;

--\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

library ieee;
use ieee.std_logic_1164.all;

--Creating the Half Adder uaing the previously defined gates
entity half_adder is
	port(A, B : in std_logic;
			sum, Cout : out std_logic);
end half_adder;

--Implement the functionality of the half adder
architecture adder of half_adder is

	component andGate is					-- Importing the AND gate.
		port(A, B : in std_logic;
				  F : out std_logic);
	end component;
	
	component xorGate is					-- Importing the XOR gate.
		port(A, B : in std_logic;
				  F : out std_logic);
	end component;

begin
	Gate_1 : xorGate port map(A, B, sum);		-- Mapping inputs and outputs to xorGate
	Gate_2 : andGate port map(A, B, Cout);		-- Mapping inputs and outputs to andGate
end adder;