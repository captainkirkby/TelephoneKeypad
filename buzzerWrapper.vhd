----------------------------------------------------------------------------------
-- Company: The Future
-- Engineer: Nate Fox, Krishna Polavali, Dylan Kirkby
-- 
-- Create Date:    10:00:16 12/03/2013 
-- Design Name:    Buzzer Wrapper
-- Module Name:    buzzerWrapper - Behavioral 
-- Project Name:   Buzzer Wrapper
-- Target Devices: Nexys II Board
-- Tool versions:  None
-- Description:    Determine good or bad tune.

----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity buzzerWrapper is
    Port ( CLK : in  STD_LOGIC;
	        BTN : in  STD_LOGIC;
           BUZZ : out  STD_LOGIC);
end buzzerWrapper;

architecture Behavioral of buzzerWrapper is

component buzz_clk_div is
    Port (  clk : in std_logic;
	        div : in STD_LOGIC_VECTOR(15 downto 0);
           sclk : out std_logic);
end component;

component count_clk_div is
    Port (  clk : in std_logic;
	        div : in STD_LOGIC_VECTOR(23 downto 0);
           sclk : out std_logic);
end component;

-- state declaration
type state_type is (IDLE, PLAYING1, PLAYING2, PLAYING3);
signal PS, NS: state_type;

-- intermediate signal declaration
signal t0,t1 : STD_LOGIC;
signal td : STD_LOGIC_VECTOR(15 downto 0);


begin

d1: buzz_clk_div PORT MAP( clk => CLK,
                         div =>  td,
								 sclk => t0);
								 
d2: count_clk_div PORT MAP( clk => CLK,
                         div =>  "111111100101000000101010",
								 sclk => t1);			

BUZZ <= t0;

-- if button is pressed, then td = 1101110111110010. else, td = 1001110100000000


-- ROOT td <= "1101110111110010" when (BTN = '0') else
--  TT    "1001110100000000";

-- 5th "1001010000110000"
		
--btn_proc: process(BTN)
--begin
--
--	if(BTN = '1') then
--		td <= "1101110111110010";
--	end if;
--	
--end process btn_proc;

seq_proc: process(t1)
begin
	if(rising_edge(t1)) then
		PS <= NS;
	end if;
end process seq_proc;

comb_proc: process(PS, BTN)
begin
	case PS is
		when IDLE =>
			td <= "0000000000000001";
			if(BTN = '1') then NS <= PLAYING1;
			else NS <= IDLE;
			end if;
		when PLAYING1 =>
			td <= "1101110111110010";
			NS <= PLAYING2;
		when PLAYING2 =>
			td <= "1001010000110000";
			NS <= PLAYING3;
		when PLAYING3 =>
			td <= "1101110111110010";
			NS <= IDLE;
	end case;
end process comb_proc;

end Behavioral;

