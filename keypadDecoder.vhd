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
    Port ( ROWS : in  STD_LOGIC_VECTOR (3 downto 0);
			  FCLK : in STD_LOGIC;
           CLK : in  STD_LOGIC;
			  LEDS : out STD_LOGIC_VECTOR (2 downto 0);
           COLUMNS : out  STD_LOGIC_VECTOR (2 downto 0);
           OUTPUT : out  STD_LOGIC_VECTOR (3 downto 0);
           VALID : out  STD_LOGIC);
end keypadDecoder;

architecture Behavioral of keypadDecoder is

-- Component Declarations
component Latch is
    Port ( D : in  STD_LOGIC_VECTOR(3 downto 0);
           L : in  STD_LOGIC :='1';
           R : in  STD_LOGIC :='1';
           CLK : in  STD_LOGIC;
           Q : out  STD_LOGIC_VECTOR(3 downto 0));
end component;

-- State Declarations
type state_type is (COL0, COL1, COL2);
signal PS, NS : state_type;

-- Intermediate Signal Declarations
signal t_output, latchValue : STD_LOGIC_VECTOR (3 downto 0);
signal t_valid : STD_LOGIC;
signal t_latch : STD_LOGIC := '0';


begin

l1 : Latch PORT MAP(D => t_output,
						  L => t_latch,
						  R => '1',
						  CLK => FCLK,
						  Q => latchValue);

OUTPUT <= latchValue;
VALID <= t_valid;

det_proc: process(PS, ROWS)
begin
			t_latch <= '1';

			-- 1 pressed
			if(ROWS = "1110" AND PS=COL0) then
				t_valid <= '1';
				t_output <= "0001";
			-- 4 pressed
			elsif(ROWS = "1101" AND PS=COL0) then
				t_valid <= '1';
				t_output <= "0100";
			-- 7 pressed
			elsif(ROWS = "1011" AND PS=COL0) then
				t_valid <= '1';
				t_output <= "0111";
			-- * pressed
			elsif(ROWS = "0111" AND PS=COL0) then
				t_valid <= '1';
				t_output <= "1010";
				
				
			-- 2 pressed
			elsif(ROWS = "1110" AND PS=COL1) then
				t_valid <= '1';
				t_output <= "0010";
			-- 5 pressed
			elsif(ROWS = "1101" AND PS=COL1) then
				t_valid <= '1';
				t_output <= "0101";
			-- 8 pressed
			elsif(ROWS = "1011" AND PS=COL1) then
				t_valid <= '1';
				t_output <= "1000";
			-- 0 pressed
			elsif(ROWS = "0111" AND PS=COL1) then
				t_valid <= '1';
				t_output <= "0000";
				
			-- 3 pressed
			elsif(ROWS = "1110" AND PS=COL2) then
				t_valid <= '1';
				t_output <= "0011";
			-- 6 pressed
			elsif(ROWS = "1101" AND PS=COL2) then
				t_valid <= '1';
				t_output <= "0110";
			-- 9 pressed
			elsif(ROWS = "1011" AND PS=COL2) then
				t_valid <= '1';
				t_output <= "1001";
			-- # pressed
			elsif(ROWS = "0111" AND PS=COL2) then
				t_valid <= '1';
				t_output <= "1011";
			else
				t_latch <= '0';
			end if;

end process det_proc;

-- Sequential Process
seq_proc: process(CLK)
begin
	if(rising_edge(CLK)) then
		PS <= NS;
	end if;
end process seq_proc;

-- Combinatorial Process
comb_proc: process(PS, ROWS)
begin

	case PS is
		when COL0 => 
			NS <= COL1;
			-- Column 0 is low
			COLUMNS <= "110";
			LEDS <= "001";
			
--			-- 1 pressed
--			if(ROWS = "1110") then
--				t_valid <= '1';
--				t_output <= "0001";
--			-- 4 pressed
--			elsif(ROWS = "1101") then
--				t_valid <= '1';
--				t_output <= "0100";
--			-- 7 pressed
--			elsif(ROWS = "1011") then
--				t_valid <= '1';
--				t_output <= "0111";
--			-- * pressed
--			elsif(ROWS = "0111") then
--				t_valid <= '1';
--				t_output <= "1010";
--			-- Nothing pressed
----			elsif(ROWS = "1111") then
----				t_valid <= '0';
----				t_output <= "1111";
--			end if;

		when COL1 =>
			NS <= COL2;
			-- Column 1 is low
			COLUMNS <= "101";
			LEDS <= "010";
			
--			-- 2 pressed
--			if(ROWS = "1110") then
--				t_valid <= '1';
--				t_output <= "0010";
--			-- 5 pressed
--			elsif(ROWS = "1101") then
--				t_valid <= '1';
--				t_output <= "0101";
--			-- 8 pressed
--			elsif(ROWS = "1011") then
--				t_valid <= '1';
--				t_output <= "1000";
--			-- 0 pressed
--			elsif(ROWS = "0111") then
--				t_valid <= '1';
--				t_output <= "0000";
--			-- Nothing pressed
----			elsif(ROWS = "1111") then
----				t_valid <= '0';
----				t_output <= "1111";
--			end if;

		when COL2 =>
			NS <= COL0;
			-- Column 2 is low
			COLUMNS <= "011";
			LEDS <= "100";
			
--			-- 3 pressed
--			if(ROWS = "1110") then
--				t_valid <= '1';
--				t_output <= "0011";
--			-- 6 pressed
--			elsif(ROWS = "1101") then
--				t_valid <= '1';
--				t_output <= "0110";
--			-- 9 pressed
--			elsif(ROWS = "1011") then
--				t_valid <= '1';
--				t_output <= "1001";
--			-- # pressed
--			elsif(ROWS = "0111") then
--				t_valid <= '1';
--				t_output <= "1011";
--			-- Nothing pressed
----			elsif(ROWS = "1111") then
----				t_valid <= '0';
----				t_output <= "1111";
--			end if;

	end case;
end process comb_proc;

end Behavioral;

