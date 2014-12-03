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
        RegWrite:       in  std_logic;
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
		address: in std_logic_vector(7 downto 0);
		DataIn: in std_logic_vector(15 downto 0);
		DataOut: out std_logic_vector(15 downto 0)
	);
end component ram_256;

-- signals for instruction decoding
signal opCode : std_logic_vector(2 downto 0);
signal inst_a, inst_b: std_logic_vector(3 downto 0);
signal inst_dest : std_logic_vector(3 downto 0);
signal inst_value : std_logic_vector(15 downto 0);
-- signals for control
signal regWrite : std_logic;
signal memToReg : std_logic;
signal aluSrc : std_logic;
-- signals for register file
signal regNewData : std_logic_vector(15 downto 0);
--signals for ALU
signal aluSrcOutput : std_logic_vector(15 downto 0);
signal aluOutput : std_logic_vector(15 downto 0);
signal C : std_logic_vector(15 downto 0);
signal status : std_logic_vector(2 downto 0);
--signals for RAM
signal ramOutput : std_logic_vector(15 downto 0);

begin
--Get opCode from Instruction
process(clk)   
begin
	if(rising_edge(clk)) then
		opCode <= instruction(14 downto 12);
	end if;
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
	 	inst_value <= std_logic_vector(resize(signed(instruction(7 downto 0)), 16));
		regWrite <= '1';
		aluSrc <= '1';
		memToReg <= '0';
	  when "110" => --store halfword I-type
	  	inst_a <= instruction(11 downto 8);
	 	inst_value <= std_logic_vector(resize(signed(instruction(7 downto 0)), 16));
		regWrite <= '0';
	  when "111" => --load halfword I-type
	  	inst_dest <= instruction(11 downto 8);
	 	inst_value <= std_logic_vector(resize(signed(instruction(7 downto 0)), 16));
		regWrite <= '1';
	  when others =>  null;
	end case;
end process;

-- Port mapping components to processor signals
reg_file: register_file_16x8 port map(regWrite,inst_dest(2 downto 0),regNewData,inst_a(2 downto 0),inst_b(2 downto 0),RA,RB); 
alu1: ALU port map(RA,aluSrcOutput, aluOutput,opCode(0),opCode(1),opCode(2),C,status);
--ram1: ram_256 port map(clk, (not regWrite), '1', inst_value, RA, ramOutput);
muxAluSrc: mux2 port map(RB,inst_value,aluSrc,aluSrcOutput);
muxMemToReg: mux2 port map(aluOutput,x"0000",memToReg,regNewData);

---Store new value into destination register from ALU
process(aluOutput)
begin
	if (regWrite = '1')	then	
		-- Assigning register file data value to appropriate register debug signal.
		case inst_dest is
			when "0000" => R0 <= aluOutput;
			when "0001" => R1 <= aluOutput;
			when "0010" => R2 <= aluOutput;
			when "0011" => R3 <= aluOutput;
			when "0100" => R4 <= aluOutput;
			when "0101" => R5 <= aluOutput;
			when "0110" => R6 <= aluOutput;
			when "0111" => R7 <= aluOutput;
			when others => null;
		end case;
	end if;
end process;

--Store new value into destination register from RAM
process(ramOutput)
begin
	if (regWrite = '0')	then	
		-- Assigning register file data value to appropriate register debug signal.
		case inst_a is
			when "0000" => R0 <= ramOutput;
			when "0001" => R1 <= ramOutput;
			when "0010" => R2 <= ramOutput;
			when "0011" => R3 <= ramOutput;
			when "0100" => R4 <= ramOutput;
			when "0101" => R5 <= ramOutput;
			when "0110" => R6 <= ramOutput;
			when "0111" => R7 <= ramOutput;
			when others => null;
		end case;
	end if;
end process;



end behavioral;																	   
