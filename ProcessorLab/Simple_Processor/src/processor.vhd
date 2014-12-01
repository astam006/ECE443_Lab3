library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


-- R0 - R7, RA, RB and RC are shown as outputs to help with debugging

entity processor is 
Port(
instruction: IN std_logic_vector(15 downto 0);
clk: IN std_logic;
R0, R1, R2, R3, R4, R5, R6, R7: OUT std_logic_vector(15 downto 0);
RA, RB, RC: buffer std_logic_vector(15 downto 0)
);
end entity;

architecture behavioral of processor is
-- INCLUDE YOUR ALU COMPONENT
-- it should look something like the following
--
-- component ALU IS
-- PORT(X
--    Y: IN STD_LOGIC_VECTOR(15 DOWNTO 0);
--    S0
--    S1
--    S2 : IN STD_LOGIC;
--    C : BUFFER STD_LOGIC_VECTOR(15 DOWNTO 0);
--    CCR: OUT STD_LOGIC_VECTOR(2 DOWNTO 0));
-- end component;
component ALU is
	port(A		:	in std_logic_vector(15 downto 0);		  -- Input signal A
		 B		:	in std_logic_vector(15 downto 0);		  -- Input signal B
		 R      : 	out std_logic_vector(15 downto 0); 		  -- Result output Signal
		 S0     : 	in  std_logic;							  -- First bit of mux selector signal
		 S1     : 	in  std_logic;							  -- Second bit of mux selector signal
		 S2		: 	in  std_logic;							  -- Third bit of mux selector signal 
		 C		:	buffer std_logic_vector(15 downto 0);
		 status : 	out std_logic_vector(2 downto 0));        -- Status output signal
end component;

signal opCode : std_logic_vector(2 downto 0);

begin		  
-- Instruction Decoder
process(opCode)
begin
	case opCode is
	  when "000" =>   opCode <= "000"; --signed addition	R-type
	  when "001" =>   opCode <= "000"; --signed multiplication R-type
	  when "010" =>   opCode <= "000"; --passthrough A R-type
	  when "011" =>   opCode <= "000"; --passthrough B R-type
	  when "100" =>   opCode <= "000"; --signed subtraction R-type
	  when "101" =>   opCode <= "000"; --load immediate I-type
	  when "110" =>   opCode <= "000"; --store halfword I-type
	  when "111" =>   opCode <= "000"; --load halfword I-type
	  when others =>  opCode <= "000";
	end case;
end process;

-- PUT YOUR CODE HERE

end behavioral;
