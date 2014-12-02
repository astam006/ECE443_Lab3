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
signal inst_a, inst_b, inst_c : std_logic_vector(3 downto 0);
signal inst_d : std_logic_vector(3 downto 0);
signal inst_value : std_logic_vector(7 downto 0);

begin
--Get opCode from Instruction
process(instruction)
begin
	opCode <= instruction(14 downto 12);
end process;

-- Instruction Decoder
process(opCode)
begin
	case opCode is
	  when "000" => --signed addition	R-type  
	  	inst_c <= instruction(11 downto 8);
		inst_a <= instruction(7 downto 4);
		inst_b <= instruction(3 downto 0);
	  when "001" => --signed multiplication R-type
	    inst_c <= instruction(11 downto 8);
		inst_a <= instruction(7 downto 4);
		inst_b <= instruction(3 downto 0);
	  when "010" => --passthrough A R-type
	    inst_c <= instruction(11 downto 8);
		inst_a <= instruction(7 downto 4);
		inst_b <= instruction(3 downto 0);
	  when "011" =>  --passthrough B R-type
	    inst_c <= instruction(11 downto 8);
		inst_a <= instruction(7 downto 4);
		inst_b <= instruction(3 downto 0);
	  when "100" => --signed subtraction R-type
	    inst_c <= instruction(11 downto 8);
		inst_a <= instruction(7 downto 4);
		inst_b <= instruction(3 downto 0);
	  when "101" => --load immediate I-type
	  	inst_d <= instruction(11 downto 8);
	 	inst_value <= instruction(7 downto 0); 
	  when "110" => --store halfword I-type
	  	inst_d <= instruction(11 downto 8);
	 	inst_value <= instruction(7 downto 0);
	  when "111" => --load halfword I-type
	  	inst_d <= instruction(11 downto 8);
	 	inst_value <= instruction(7 downto 0);
	  when others =>  null;
	end case;
end process;

-- PUT YOUR CODE HERE

end behavioral;
