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

begin

-- PUT YOUR CODE HERE

end behavioral;
