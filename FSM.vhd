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

architecture Behavioral of SequenceDetectorFSM is

-- State Declarations
type state_type is (IDLE,A,B,C,D);
signal PS,NS : state_type;

-- Intermediate Signal Declarations
signal Correct : STD_LOGIC_VECTOR(3 downto 0) := "0000";

begin

sync_proc: process(CLK)
begin
	if (rising_edge(CLK)) then PS <= NS;
	end if;
end process sync_proc;

comb_proc: process(PS,INPUT)
begin
	case PS is
		when IDLE => 
		NS <= A;
		
		when A =>
		if(INPUT = "0001") then Correct(0) <= '1';
		end if;
		NS <= B;
		
		when B =>
		if(INPUT = "0010") then Correct(1) <= '1';
		end if;
		NS <= C;
		
		when C =>
		if(INPUT = "0011") then Correct(2) <= '1';
		end if;
		NS <= D;
		
		when D =>
		if(INPUT = "0100") then Correct(3) <= '1';
		end if;
      NS <= IDLE;		
	end case;
		
end process comb_proc;

DETECTED <= '1' when (Correct = "1111") else
            '0';


end Behavioral;



