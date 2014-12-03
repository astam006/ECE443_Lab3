library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

--Declare the 16-bit multiplexer signals
entity mux16 is
	port (A : in  std_logic_vector(15 downto 0);	--Signal A
			B : in  std_logic_vector(15 downto 0); --Signal B
			C : in  std_logic_vector(15 downto 0); --Addition Input
			D : in  std_logic_vector(15 downto 0); --Multiplication Input
			E : in  std_logic_vector(15 downto 0); --Subtraction Input
			F : in  std_logic_vector(15 downto 0); --Undefined Input
			G : in  std_logic_vector(15 downto 0); --Undefined Input
			H : in  std_logic_vector(15 downto 0); --Undefined Input
			S : in  std_logic_vector(2 downto 0);  --Selector input
			Y : out std_logic_vector(15 downto 0)	--Output
	);
end mux16;

--Implement the functionality of the multiplexer
architecture mux of mux16 is
begin
	process(A,B,C,D,E,F,G,H,S)
	begin
		if(S="000") then
			Y <= C;					--Addition
		elsif(S="001") then
			Y <= E;					--Subtraction
		elsif(S="010") then
			Y <= A;					--Pass through A
		elsif(S="011") then
			Y <= B;					--Undefined
		elsif(S="100") then
			Y <= D;					--Multiplication
		elsif(S="101") then
			Y <= B;					--Pass through B
		elsif(S="110") then
			Y <= B;					--Pass through B
		elsif(S="111") then
			Y <= H;					--Undefined
		end if;
	end process;	
end mux;