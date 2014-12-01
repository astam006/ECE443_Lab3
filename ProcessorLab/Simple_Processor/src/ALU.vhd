library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

--Define the ALU and it's signals
entity ALU is
	port (A      : in  std_logic_vector(15 downto 0); -- Input signal A
			B      : in  std_logic_vector(15 downto 0); -- Input signal B
			R      : out std_logic_vector(15 downto 0); -- Result output Signal
			S0     : in  std_logic;							  -- First bit of mux selector signal
			S1     : in  std_logic;							  -- Second bit of mux selector signal
			S2		 : in  std_logic;							  -- Third bit of mux selector signal
			C	   :	buffer std_logic_vector(15 downto 0);
			status : out std_logic_vector(2 downto 0)   -- Status output signal
	);
end ALU;

-- Implement the functionality of the ALU
architecture ALU_arc of ALU is

	-- Implement 16-bit adder component
	component adder16 is
		port (
			A : in  std_logic_vector(15 downto 0);
			B : in  std_logic_vector(15 downto 0);
			CI: in  std_logic;
			O : out std_logic_vector(15 downto 0);
			CO: out std_logic
		);
	end component;
	
	-- Implement 16-bit subtractor component
	component subtractor16 is
		port (
			A      : in std_logic_vector(15 downto 0);
			B      : in std_logic_vector(15 downto 0);
			borrow : out std_logic;
			diff   :	out std_logic_vector(15 downto 0)
		);
	end component;

	-- Implement Multiplier component
	component multiplier16 is
		port (
			A 		 : in std_logic_vector(15 downto 0);
			B 		 : in std_logic_vector(15 downto 0);
			product: out std_logic_vector(31 downto 0)
		);
	end component;
	
	-- Implement Multiplexer component
	component mux16 is
		port( A : in  std_logic_vector(15 downto 0);	--Signal A
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
	end component;
	
	--Define all internal signals of the ALU
	signal sum_signal, diff_signal 	     : std_logic_vector(15 downto 0);
	signal product_signal 				     : std_logic_vector(31 downto 0);
	signal adder_carryOut, sub_borrow 	  : std_logic;
	signal selector_signal, status_signal : std_logic_vector(2 downto 0);
	signal output_signal					     : std_logic_vector(15 downto 0);

--Begin the architecture for the ALU
begin
	selector_signal <= S2 & S1 & S0;														--Concatenate the S0-S2 signals into a single signal to be passed into the Mux
	Adder:			adder16 port map(A, B, '0', sum_signal, adder_carryOut);	--Map signals to 16-bit adder
	Subtractor:		subtractor16 port map(A, B, sub_borrow, diff_signal);		--Map signals to 16-bit subtractor
	Multiplier:		multiplier16 port map(A, B, product_signal);					--Map signals to 16-bit multiplier
	Multiplexer:	mux16 port map(A, B, sum_signal, product_signal(15 downto 0), 
								diff_signal, x"0000", x"0000", x"0000", selector_signal, output_signal);	--Map signals to multiplexer
	
	--Process used to assign proper status output values.
	process(output_signal, status_signal)
	begin
		status_signal <= "000";					--Initialize status_signal
		if (output_signal = x"0000") then	--Check if the output is zero
			status_signal <= "010";				--If zero, set status_signal accordingly.
		end if;
	end process;
	R <= output_signal after 30ns;			--Set the ALU output equal to the internal signal
	status <= status_signal;					--Set the ALU status equal to the internal signal
													   
end ALU_arc;										--End the architecture