library ieee;
use ieee.STD_LOGIC_UNSIGNED.all;
use ieee.std_logic_1164.all;

	-- Add your library and packages declaration here ...

entity ram_256_tb is
end ram_256_tb;

architecture TB_ARCHITECTURE of ram_256_tb is
	-- Component declaration of the tested unit
	component ram_256
	port(
		clock : in STD_LOGIC;
		rw : in STD_LOGIC;
		cs : in STD_LOGIC;
		address : in STD_LOGIC_VECTOR(15 downto 0);
		DataIn : in STD_LOGIC_VECTOR(15 downto 0);
		DataOut : out STD_LOGIC_VECTOR(15 downto 0) );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal clock : STD_LOGIC;
	signal rw : STD_LOGIC;
	signal cs : STD_LOGIC;
	signal address : STD_LOGIC_VECTOR(15 downto 0);
	signal DataIn : STD_LOGIC_VECTOR(15 downto 0);
	-- Observed signals - signals mapped to the output ports of tested entity
	signal DataOut : STD_LOGIC_VECTOR(15 downto 0);

	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : ram_256
		port map (
			clock => clock,
			rw => rw,
			cs => cs,
			address => address,
			DataIn => DataIn,
			DataOut => DataOut
		);

	-- Add your stimulus here ...
	process
	begin
		clock <= '0';
		wait for 250ns;
		clock <= '1';
		wait for 250ns;
	end process;
	
	process
	begin
		rw <= '1';
		cs <= '1';
		address <= x"000B";
		DataIn <= x"0003";
		wait for 500ns;
		rw <= '0';
		cs <= '0';
		address <= x"000B";
		wait for 500ns;
	end process;

end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_ram_256 of ram_256_tb is
	for TB_ARCHITECTURE
		for UUT : ram_256
			use entity work.ram_256(behavioral);
		end for;
	end for;
end TESTBENCH_FOR_ram_256;

