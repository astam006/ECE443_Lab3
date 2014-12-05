library ieee;
use ieee.NUMERIC_STD.all;
use ieee.STD_LOGIC_UNSIGNED.all;
use ieee.std_logic_1164.all;

	-- Add your library and packages declaration here ...

entity inst_decoder_tb is
end inst_decoder_tb;

architecture TB_ARCHITECTURE of inst_decoder_tb is
	-- Component declaration of the tested unit
	component inst_decoder
	port(
		instruction : in STD_LOGIC_VECTOR(15 downto 0);
		A : out STD_LOGIC_VECTOR(2 downto 0);
		B : out STD_LOGIC_VECTOR(2 downto 0);
		D : out STD_LOGIC_VECTOR(2 downto 0);
		V : out STD_LOGIC_VECTOR(15 downto 0);
		aluSrc : out STD_LOGIC;
		regWrite : out STD_LOGIC;
		memToReg : out STD_LOGIC;
		cs : out STD_LOGIC;
		rw : out STD_LOGIC );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal instruction : STD_LOGIC_VECTOR(15 downto 0);
	-- Observed signals - signals mapped to the output ports of tested entity
	signal A : STD_LOGIC_VECTOR(2 downto 0);
	signal B : STD_LOGIC_VECTOR(2 downto 0);
	signal D : STD_LOGIC_VECTOR(2 downto 0);
	signal V : STD_LOGIC_VECTOR(15 downto 0);
	signal aluSrc : STD_LOGIC;
	signal regWrite : STD_LOGIC;
	signal memToReg : STD_LOGIC;
	signal cs : STD_LOGIC;
	signal rw : STD_LOGIC;

	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : inst_decoder
		port map (
			instruction => instruction,
			A => A,
			B => B,
			D => D,
			V => V,
			aluSrc => aluSrc,
			regWrite => regWrite,
			memToReg => memToReg,
			cs => cs,
			rw => rw
		);

	-- Add your stimulus here ...
	process
	begin
		instruction <= x"0201";
		wait for 500ns;
		instruction <= x"500A";
		wait for 500ns;
		instruction <= x"760A";
		wait for 500ns;
	end process;

end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_inst_decoder of inst_decoder_tb is
	for TB_ARCHITECTURE
		for UUT : inst_decoder
			use entity work.inst_decoder(behavioral);
		end for;
	end for;
end TESTBENCH_FOR_inst_decoder;

