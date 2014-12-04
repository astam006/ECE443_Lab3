library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity inst_decoder is
	port ( 
		instruction: in std_logic_vector(15 downto 0);
		A: out std_logic_vector(2 downto 0);
		B: out std_logic_vector(2 downto 0);
		D: out std_logic_vector(2 downto 0);
		V: out std_logic_vector(15 downto 0);
		aluSrc, regWrite, memToReg, cs, rw: out std_logic
	);
end inst_decoder;

architecture behavioral of inst_decoder is
signal opCode : std_logic_vector(2 downto 0);
begin
	opCode <= instruction(14 downto 12);
	A <= instruction(6 downto 4);
	B <= instruction (10 downto 8) when opCode = "110" else instruction(2 downto 0);
	D <= instruction(10 downto 8);
	V <= std_logic_vector(resize(signed(instruction(7 downto 0)), 16));
	aluSrc <= 	'1' when opCode = "101" else
				'1' when opCode = "110" else
				'1' when opCode = "111" else '0';
	regWrite <= '0' when opCode = "110" else '1';
	memToReg <= '1' when opCode = "111" else '0';
	cs <= '1' when opCode = "110" else 
			'1' when opCode = "111" else '0';
	rw <= '1' when opCode = "110" else '0';
end architecture behavioral;