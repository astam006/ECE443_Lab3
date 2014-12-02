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

component register_file_16x8 is
    port (
        RegWrite:       in  std_logic;
        WriteRegNum:    in  std_logic_vector (2 downto 0);
        WriteData:      in  std_logic_vector (15 downto 0);
        ReadRegNumA:    in  std_logic_vector (2 downto 0);
        ReadRegNumB:    in  std_logic_vector (2 downto 0);
        PortA:          out std_logic_vector (15 downto 0);
        PortB:          out std_logic_vector (15 downto 0)
    );
end component;

component ram_256_byte is
	port ( 
		clock, rw, cs: in std_logic;
		address: in std_logic_vector(7 downto 0);
		DataIn: in std_logic_vector(15 downto 0);
		DataOut: out std_logic_vector(15 downto 0)
	);
end component ram_256_byte;

-- signals for instruction decoding
signal opCode : std_logic_vector(2 downto 0);
signal inst_a, inst_b: std_logic_vector(3 downto 0);
signal inst_dest : std_logic_vector(3 downto 0);
signal inst_value : std_logic_vector(7 downto 0);
-- signals for register file
signal regWrite : std_logic;
signal regNewData : std_logic_vector(15 downto 0);
--signals for ALU
signal aluOutput : std_logic_vector(15 downto 0);
signal C : std_logic_vector(15 downto 0);
signal status : std_logic_vector(2 downto 0);
--signals for RAM
signal ramOutput : std_logic_vector(15 downto 0);

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
	  	inst_dest <= instruction(11 downto 8);
		inst_a <= instruction(7 downto 4);
		inst_b <= instruction(3 downto 0);
		regWrite <= '1';
	  when "001" => --signed multiplication R-type
	    inst_dest <= instruction(11 downto 8);
		inst_a <= instruction(7 downto 4);
		inst_b <= instruction(3 downto 0);
		regWrite <= '1';
	  when "010" => --passthrough A R-type
	    inst_dest <= instruction(11 downto 8);
		inst_a <= instruction(7 downto 4);
		inst_b <= instruction(3 downto 0);
		regWrite <= '1';
	  when "011" =>  --passthrough B R-type
	    inst_dest <= instruction(11 downto 8);
		inst_a <= instruction(7 downto 4);
		inst_b <= instruction(3 downto 0);
		regWrite <= '1';
	  when "100" => --signed subtraction R-type
	    inst_dest <= instruction(11 downto 8);
		inst_a <= instruction(7 downto 4);
		inst_b <= instruction(3 downto 0);
		regWrite <= '1';
	  when "101" => --load immediate I-type
	  	inst_dest <= instruction(11 downto 8);
	 	inst_value <= instruction(7 downto 0);
		regWrite <= '1';
	  when "110" => --store halfword I-type
	  	inst_a <= instruction(11 downto 8);
	 	inst_value <= instruction(7 downto 0);
		regWrite <= '0';
	  when "111" => --load halfword I-type
	  	inst_dest <= instruction(11 downto 8);
	 	inst_value <= instruction(7 downto 0);
		regWrite <= '1';
	  when others =>  null;
	end case;
end process;

reg_file: register_file_16x8 port map(regWrite,inst_dest(2 downto 0),regNewData,inst_a(2 downto 0),inst_b(2 downto 0),RA,RB); 
alu1: ALU port map(RA,RB, aluOutput,opCode(0),opCode(1),opCode(2),C,status);
ram1: ram_256_byte port map(clk, (not regWrite), '1', inst_value, RA, ramOutput);
--regNewData from load or alu

end behavioral;																	   
