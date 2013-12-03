----------------------------------------------------------------------------------
-- Company: The Future
-- Engineer: Dylan Kirkby and Krishna Polavali
-- 
-- Create Date:    10:28:17 11/05/2013 
-- Design Name:    Latch Module
-- Module Name:    Latch - Behavioral 
-- Project Name:   Exp13
-- Target Devices: NexysII Board
-- Tool versions:  None
-- Description:    To latch a value.
--
-- Dependencies:   None

----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Latch is
    Port ( D : in  STD_LOGIC_VECTOR(3 downto 0);
           L : in  STD_LOGIC :='1';
           R : in  STD_LOGIC :='1';
           CLK : in  STD_LOGIC;
           Q : out  STD_LOGIC_VECTOR(3 downto 0));
end Latch;

architecture Behavioral of Latch is

begin

	proc1: process (D,L,R,CLK)
	begin
		if(R = '0') then
			Q <= '0';
		elsif(rising_edge(CLK) AND L = '1') then
			Q <= D;
		end if;
		
	end process proc1;

end Behavioral;

