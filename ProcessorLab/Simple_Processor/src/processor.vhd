library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity processor is 
	Port(
		instruction: IN std_logic_vector(15 downto 0);
		clk: IN std_logic;
		R0, R1, R2, R3, R4, R5, R6, R7: OUT std_logic_vector(15 downto 0);
		RA, RB, RC: buffer std_logic_vector(15 downto 0)
	);
end entity;

architecture behavioral of processor is

component inst_decoder is
	port ( 
		instruction: in std_logic_vector(15 downto 0);
		A: out std_logic_vector(2 downto 0);
		B: out std_logic_vector(2 downto 0);
		D: out std_logic_vector(2 downto 0);
		V: out std_logic_vector(15 downto 0);
		aluSrc, regWrite, memToReg, cs: out std_logic
	);
end component;

component mux2 is
	port(
		A: in std_logic_vector(15 downto 0);
		B: in std_logic_vector(15 downto 0);
		S: in std_logic;
		Z: out std_logic_vector(15 downto 0)
	);
end component;

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
        RegWrite, Clk:  in  std_logic;
        WriteRegNum:    in  std_logic_vector (2 downto 0);
        WriteData:      in  std_logic_vector (15 downto 0);
        ReadRegNumA:    in  std_logic_vector (2 downto 0);
        ReadRegNumB:    in  std_logic_vector (2 downto 0);
        PortA:          out std_logic_vector (15 downto 0);
        PortB:          out std_logic_vector (15 downto 0)
    );
end component;

component ram_256 is
	port ( 
		clock, rw, cs: in std_logic;
		address: in std_logic_vector(15 downto 0);
		DataIn: in std_logic_vector(15 downto 0);
		DataOut: out std_logic_vector(15 downto 0)
	);
end component ram_256;

-- signals for instruction decoding					   
signal inst_a, inst_b: std_logic_vector(2 downto 0):= "000";
signal inst_dest : std_logic_vector(2 downto 0) := "000";
signal inst_value : std_logic_vector(15 downto 0):= x"0000";
-- signals for control
signal regWrite : std_logic := '0';
signal memToReg : std_logic := '0';
signal aluSrc : std_logic := '0';
-- signals for register file
signal regNewData : std_logic_vector(15 downto 0) := x"0000";
--signals for ALU
signal aluSrcOutput : std_logic_vector(15 downto 0) := x"0000";
signal aluOutput : std_logic_vector(15 downto 0) := x"0000";
signal C : std_logic_vector(15 downto 0) := x"0000";
signal status : std_logic_vector(2 downto 0) := "000";
--signals for RAM
signal ramOutput : std_logic_vector(15 downto 0) := x"0000";
signal chipSelect : std_logic := '0';

begin
 

-- Port mapping components to processor signals
id: inst_decoder port map(instruction, inst_a, inst_b, inst_dest, inst_value, aluSrc, regWrite, memToReg, chipSelect);
reg_file: register_file_16x8 port map(regWrite,clk,inst_dest,regNewData,inst_a,inst_b,RA,RB); 
alu1: ALU port map(RA,aluSrcOutput, aluOutput,instruction(14),instruction(13),instruction(12),C,status);
ram1: ram_256 port map(clk, (not regWrite), chipSelect, aluOutput, RB, ramOutput);
muxAluSrc: mux2 port map(RB,inst_value,aluSrc,aluSrcOutput);
muxMemToReg: mux2 port map(aluOutput,ramOutput,memToReg,regNewData);



end behavioral;																	   
