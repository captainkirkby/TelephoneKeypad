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

-- Passkey Declaration
-- SET PASSKEY HERE
signal PASSKEY_CHAR0 : STD_LOGIC_VECTOR(3 downto 0) := x"1";
signal PASSKEY_CHAR1 : STD_LOGIC_VECTOR(3 downto 0) := x"2";
signal PASSKEY_CHAR2 : STD_LOGIC_VECTOR(3 downto 0) := x"3";
signal PASSKEY_CHAR3 : STD_LOGIC_VECTOR(3 downto 0) := x"4";

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
		if(INPUT = PASSKEY_CHAR0) then Correct(0) <= '1';
		end if;
		NS <= B;
		
		when B =>
		if(INPUT = PASSKEY_CHAR1) then Correct(1) <= '1';
		end if;
		NS <= C;
		
		when C =>
		if(INPUT = PASSKEY_CHAR2) then Correct(2) <= '1';
		end if;
		NS <= D;
		
		when D =>
		if(INPUT = PASSKEY_CHAR3) then Correct(3) <= '1';
		end if;
      NS <= IDLE;		
	end case;
		
end process comb_proc;

correct_proc: process(Correct)
begin

	if(Correct = "1111") then
		Detected <= '1';
		Correct <= "0000";
	else 
		Detected <= '0';
	end if;
	
end process correct_proc;

--DETECTED <= '1' when (Correct = "1111") else
--            '0';

end Behavioral;



