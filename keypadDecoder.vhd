----------------------------------------------------------------------------------
-- Company: The Future
-- Engineer: Dylan Kirkby
-- 
-- Create Date:    18:37:01 12/02/2013 
-- Design Name: 	 Keypad Decoder
-- Module Name:    keypadDecoder - Behavioral 
-- Project Name:   Final Project: Nutcracker
-- Target Devices: Nexys 2
-- Description:    A Module to decode a standard 12 character
--						 telephone keypad
-- Dependencies:   None
--
-- Revision: 
-- Revision 0.01 - File Created
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity keypadDecoder is
    Port ( ROWS : in  STD_LOGIC_VECTOR (2 downto 0);
           CLK : in  STD_LOGIC;
           COLUMNS : out  STD_LOGIC_VECTOR (3 downto 0);
           OUTPUT : out  STD_LOGIC_VECTOR (3 downto 0);
           VALID : out  STD_LOGIC);
end keypadDecoder;

architecture Behavioral of keypadDecoder is

-- State Declarations
type state_type is (COL0, COL2, COL3);
signal PS, NS : state_type;

-- Intermediate Signal Declarations
signal t_output : STD_LOGIC_VECTOR (3 downto 0) := "00000000";
signal t_valid : STD_LOGIC := '0';

begin

OUTPUT <= t_output;
VALID <= t_valid;

-- Sequential Process
seq_proc: process(CLK)
begin
	if(rising_edge(CLK)) then
		PS <= NS;
	end if;
end process seq_process;

-- Combinatorial Process
comb_proc: process(PS, ROWS)
begin

	case PS is
		when COL0 => 
			-- Column 0 is low
			COLUMNS <= "011";

		when COL1 =>
			-- Column 1 is low
			COLUMNS <= "101";

		when COL2 =>
			-- Column 2 is low
			COLUMNS <= "110";

	end case;
end process comb_proc;

end Behavioral;

