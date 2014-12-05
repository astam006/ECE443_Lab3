library ieee;
use ieee.NUMERIC_STD.all;
use ieee.std_logic_1164.all;

	-- Add your library and packages declaration here ...

entity register_file_16x8_tb is
end register_file_16x8_tb;

architecture TB_ARCHITECTURE of register_file_16x8_tb is
	-- Component declaration of the tested unit
	component register_file_16x8
	port(
		RegWrite : in STD_LOGIC;
		Clk : in STD_LOGIC;
		WriteRegNum : in STD_LOGIC_VECTOR(2 downto 0);
		WriteData : in STD_LOGIC_VECTOR(15 downto 0);
		ReadRegNumA : in STD_LOGIC_VECTOR(2 downto 0);
		ReadRegNumB : in STD_LOGIC_VECTOR(2 downto 0);
		PortA : out STD_LOGIC_VECTOR(15 downto 0);
		PortB : out STD_LOGIC_VECTOR(15 downto 0) );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal RegWrite : STD_LOGIC;
	signal Clk : STD_LOGIC;
	signal WriteRegNum : STD_LOGIC_VECTOR(2 downto 0);
	signal WriteData : STD_LOGIC_VECTOR(15 downto 0);
	signal ReadRegNumA : STD_LOGIC_VECTOR(2 downto 0);
	signal ReadRegNumB : STD_LOGIC_VECTOR(2 downto 0);
	-- Observed signals - signals mapped to the output ports of tested entity
	signal PortA : STD_LOGIC_VECTOR(15 downto 0);
	signal PortB : STD_LOGIC_VECTOR(15 downto 0);

	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : register_file_16x8
		port map (
			RegWrite => RegWrite,
			Clk => Clk,
			WriteRegNum => WriteRegNum,
			WriteData => WriteData,
			ReadRegNumA => ReadRegNumA,
			ReadRegNumB => ReadRegNumB,
			PortA => PortA,
			PortB => PortB
		);

	-- Add your stimulus here ... 
	process
	begin
		Clk <= '0';
		wait for 250ns;
		Clk <= '1';
		wait for 250ns;
	end process;
	
	process
	begin
		RegWrite 	<= '1';
		WriteRegNum <= "000";
		WriteData 	<= x"0001";
		ReadRegNumA <= "000";
		ReadRegNumB <= "001";
		wait for 500ns;
	end process;
		

end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_register_file_16x8 of register_file_16x8_tb is
	for TB_ARCHITECTURE
		for UUT : register_file_16x8
			use entity work.register_file_16x8(behavioral);
		end for;
	end for;
end TESTBENCH_FOR_register_file_16x8;

