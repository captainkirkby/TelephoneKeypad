----------------------------------------------------------------------------------
-- Company: The Future
-- Engineer: Dylan Kirkby
-- 
-- Create Date:    10:59:54 12/03/2013 
-- Design Name: 	 Nutcracker
-- Module Name:    KeypadOutputCleanerUpper - Behavioral 
-- Project Name:   Nutcracker
-- Target Devices: Nexys 2
-- Description: 	 Cleans up the messy output of the Keypad Decoder
-- Revision: 
-- Revision 0.01 - File Created
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity KeypadOutputCleanerUpper is
    Port ( CLK : in  STD_LOGIC;
           KEYPAD : in  STD_LOGIC_VECTOR (3 downto 0);
           CLEAN : in  STD_LOGIC_VECTOR (3 downto 0));
end KeypadOutputCleanerUpper;

architecture Behavioral of KeypadOutputCleanerUpper is

begin




end Behavioral;

