library ieee;
use ieee.NUMERIC_STD.all;
use ieee.std_logic_1164.all;

	-- Add your library and packages declaration here ...

entity processor_tb is
end processor_tb;

architecture TB_ARCHITECTURE of processor_tb is
	-- Component declaration of the tested unit
	component processor
	port(
		instruction : in STD_LOGIC_VECTOR(15 downto 0);
		clk : in STD_LOGIC;
		R0 : out STD_LOGIC_VECTOR(15 downto 0);
		R1 : out STD_LOGIC_VECTOR(15 downto 0);
		R2 : out STD_LOGIC_VECTOR(15 downto 0);
		R3 : out STD_LOGIC_VECTOR(15 downto 0);
		R4 : out STD_LOGIC_VECTOR(15 downto 0);
		R5 : out STD_LOGIC_VECTOR(15 downto 0);
		R6 : out STD_LOGIC_VECTOR(15 downto 0);
		R7 : out STD_LOGIC_VECTOR(15 downto 0);
		RA : buffer STD_LOGIC_VECTOR(15 downto 0);
		RB : buffer STD_LOGIC_VECTOR(15 downto 0);
		RC : buffer STD_LOGIC_VECTOR(15 downto 0) );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal instruction : STD_LOGIC_VECTOR(15 downto 0);
	signal clk : STD_LOGIC;
	-- Observed signals - signals mapped to the output ports of tested entity
	signal R0 : STD_LOGIC_VECTOR(15 downto 0);
	signal R1 : STD_LOGIC_VECTOR(15 downto 0);
	signal R2 : STD_LOGIC_VECTOR(15 downto 0);
	signal R3 : STD_LOGIC_VECTOR(15 downto 0);
	signal R4 : STD_LOGIC_VECTOR(15 downto 0);
	signal R5 : STD_LOGIC_VECTOR(15 downto 0);
	signal R6 : STD_LOGIC_VECTOR(15 downto 0);
	signal R7 : STD_LOGIC_VECTOR(15 downto 0);
	signal RA : STD_LOGIC_VECTOR(15 downto 0);
	signal RB : STD_LOGIC_VECTOR(15 downto 0);
	signal RC : STD_LOGIC_VECTOR(15 downto 0);

	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : processor
		port map (
			instruction => instruction,
			clk => clk,
			R0 => R0,
			R1 => R1,
			R2 => R2,
			R3 => R3,
			R4 => R4,
			R5 => R5,
			R6 => R6,
			R7 => R7,
			RA => RA,
			RB => RB,
			RC => RC
		);

	-- Add your stimulus here ...
	process
	begin
		clk <= '0';
		wait for 250ns;
		clk <= '1';
		wait for 250ns;
	end process;
	
	process
	begin
		wait for 10ns;
		instruction <= x"500A";
		wait for 500ns;
		instruction <= x"5105"; 
		wait for 500ns;
		instruction <= x"5200";
		wait for 500ns;
		instruction <= x"5300";
		wait for 500ns;
		instruction <= x"5400";
		wait for 500ns;
		instruction <= x"5500";
		wait for 500ns;
		instruction <= x"5600";
		wait for 500ns;
		instruction <= x"5700";
		wait for 500ns;
		instruction <= x"0201";
		wait for 500ns;
		instruction <= x"1301";
		wait for 500ns;
		instruction <= x"4401";
		wait for 500ns;
		instruction <= x"630B";
		wait for 500ns;
		instruction <= x"640A";
		wait for 500ns;
		instruction <= x"760A";
		wait for 500ns;
		instruction <= x"770B";
		wait for 500ns;
	end process;

end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_processor of processor_tb is
	for TB_ARCHITECTURE
		for UUT : processor
			use entity work.processor(behavioral);
		end for;
	end for;
end TESTBENCH_FOR_processor;

