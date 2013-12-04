----------------------------------------------------------------------------------
-- Company: The Future
-- Engineer: Dylan Kirkby
-- 
-- Create Date:    19:26:55 12/02/2013 
-- Design Name: 	 Keypad Decoder
-- Module Name:    keypadDecoder - Behavioral 
-- Project Name:   Final Project: Nutcracker
-- Target Devices: Nexys 2
-- Description:    A Wrapper Module to test and use the decoding module
-- Dependencies:   None
--
-- Revision: 
-- Revision 0.01 - File Created
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity passkeyEntry is
    Port ( ROWS : in  STD_LOGIC_VECTOR (3 downto 0);
           CLK : in  STD_LOGIC;
			  HIGH : out STD_LOGIC;
			  BUZZER : out STD_LOGIC;
           LEDS : out  STD_LOGIC_VECTOR (2 downto 0);
           COLUMNS : out  STD_LOGIC_VECTOR (2 downto 0);
           CATHODES : out  STD_LOGIC_VECTOR (7 downto 0);
           ANODES : out  STD_LOGIC_VECTOR (3 downto 0));
end passkeyEntry;

architecture Behavioral of passkeyEntry is

-- Component Declarations

component sseg_dec is
    Port (      ALU_VAL : in std_logic_vector(7 downto 0); 
					    SIGN : in std_logic;
						VALID : in std_logic;
                    CLK : in std_logic;
                DISP_EN : out std_logic_vector(3 downto 0);
               SEGMENTS : out std_logic_vector(7 downto 0));
end component;

component my_clk_div is
    Port (  clk : in std_logic;
           sclk : out std_logic);
end component;

component keypadDecoder is
    Port ( ROWS : in  STD_LOGIC_VECTOR (3 downto 0);
			  FCLK : in STD_LOGIC;
           CLK : in  STD_LOGIC;
			  LEDS : out STD_LOGIC_VECTOR (2 downto 0);
           COLUMNS : out  STD_LOGIC_VECTOR (2 downto 0);
           OUTPUT : out  STD_LOGIC_VECTOR (3 downto 0);
           VALID : out  STD_LOGIC);
end component;


component SequenceDetectorFSM is
    Port ( INPUT : in  STD_LOGIC_VECTOR(3 downto 0);
           CLK : in  STD_LOGIC;
           DETECTED : out  STD_LOGIC);
end component;

component buzzerWrapper is
    Port ( CLK : in  STD_LOGIC;
	        BTN : in  STD_LOGIC;
           BUZZ : out  STD_LOGIC);
end component;


-- Intermediate Signal Declarations
signal t8 : STD_LOGIC_VECTOR (7 downto 0);
signal t4 : STD_LOGIC_VECTOR (3 downto 0);
signal t1,t2,t3 : STD_LOGIC;

begin

d1: sseg_dec PORT MAP(ALU_VAL => t8,
							 SIGN => '0',
							 VALID => t1,
							 CLK => CLK,
							 DISP_EN => ANODES,
							 SEGMENTS => CATHODES);
							 
d2: my_clk_div PORT MAP(clk => CLK,
								sclk => t2);
								
d3: keypadDecoder PORT MAP(ROWS => ROWS,
									FCLK => CLK,
									CLK => t2,
									LEDS => open,
									COLUMNS => COLUMNS,
									OUTPUT => t4,
									VALID => t1);


d4: SequenceDetectorFSM PORT MAP(INPUT => t4,
                                 CLK => t2,
											DETECTED => t3);
											
d5: buzzerWrapper PORT MAP(CLK => CLK,
								  BTN => t3,
								  BUZZ => BUZZER);

t8 <= "0000" & t4;
HIGH <= '1';

LEDS <= "000";

end Behavioral;

