----------------------------------------------------------------------------------
-- Company: The Future
-- Engineer: Krishna Polavali and Dylan Kirkby
-- 
-- Create Date:    10:45:21 11/14/2013 
-- Design Name:    Exp 16
-- Module Name:    FSM - Behavioral 
-- Project Name:   FSM to detect a 4 character sequence
-- Target Devices: NexysII Board
-- Tool versions:  None
-- Description:    to detect whether the button presses or not.
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity SequenceDetectorFSM is
    Port ( INPUT : in  STD_LOGIC_VECTOR(3 downto 0);
           CLK : in  STD_LOGIC;
           DETECTED : out  STD_LOGIC);
end SequenceDetectorFSM;

architecture Behavioral of FSM is

type state_type is (CHAR0,CHAR1,CHAR2,CHAR3);
signal PS,NS : state_type;


begin

sync_proc: process(CLK)
begin
	if (rising_edge(CLK)) then PS <= NS;
	end if;
end process sync_proc;

comb_proc: process(PS,INPUT)
begin
	case PS is
		when CHAR0 =>
		when CHAR1 =>
		when CHAR2 =>
		when CHAR3 =>
end process comb_proc;

end Behavioral;



