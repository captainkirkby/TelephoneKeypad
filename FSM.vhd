----------------------------------------------------------------------------------
-- Company: The Future
-- Engineer: Krishna Polavali and Dylan Kirkby
-- 
-- Create Date:    10:45:21 11/14/2013 
-- Design Name:    Exp 16
-- Module Name:    FSM - Behavioral 
-- Project Name:   FSM
-- Target Devices: NexysII Board
-- Tool versions:  None
-- Description:    to detect whether the button presses or not.
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity FSM is
    Port ( X : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           BT0 : in  STD_LOGIC;
           Z : out  STD_LOGIC);
end FSM;

architecture Behavioral of FSM is

type state_type is (IDLE,ST0,ST01,ST011,ST0111,ST01110,ST011101);
signal PS,NS : state_type;


begin

sync_proc: process(CLK,NS)
     begin
	  if (rising_edge(CLK)) then PS <= NS;
	  end if;
	  end process sync_proc;

comb_proc: process(BT0,X,PS)
     begin
	  Z <= '0';
	  
	  if(BT0 = '1') then 
		  case PS is 
			when IDLE => 
			if( X = '1') then NS <= IDLE;
			else NS <= ST0;
			end if;
			
			when ST0 => 
			if( X = '0') then NS <= ST0;
			else NS <= ST01;
			end if;
			 
			when ST01 => 
			if( X = '0') then NS <= ST0;
			else NS <= ST011;
			end if;
			 
			when ST011 => 
			if( X = '0') then NS <= ST0;
			else NS <= ST0111;
			end if;
			 
			when ST0111 => 
			if( X = '1') then NS <= IDLE;
			else NS <= ST01110;
			end if;
			 
			when ST01110 => 
			if( X = '0') then NS <= ST0;
			else NS <= ST011101;
			end if;
			 
			when ST011101 => 
			if( X = '0') then NS <= ST0;
			else NS <= IDLE;
			end if;
			Z <= '1';

			end case;
		
		else
		
		  case PS is 
			when IDLE => 
			if( X = '1') then NS <= IDLE;
			else NS <= ST0;
			end if;
			
			when ST0 => 
			if( X = '0') then NS <= ST0;
			else NS <= ST01;
			end if;
			 
			when ST01 => 
			if( X = '0') then NS <= ST0;
			else NS <= ST011;
			end if;
			 
			when ST011 => 
			if( X = '1') then NS <= ST0;
			else NS <= ST0111;
			end if;
			 
			when ST0111 => 
			if( X = '1') then NS <= IDLE;
			else NS <= ST01110;
			end if;
			 
			when ST01110 => 
			if( X = '0') then NS <= ST0;
			else NS <= ST011101;
			end if;
			 
			when ST011101 => 
			if( X = '0') then NS <= ST0;
			else NS <= IDLE;
			end if;
			Z <= '1';

			end case;

		end if;
		end process comb_proc;

end Behavioral;



