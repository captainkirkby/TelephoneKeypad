--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   19:12:26 12/02/2013
-- Design Name:   
-- Module Name:   K:/Final Project/KDTestBench.vhd
-- Project Name:  FinalProject
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: keypadDecoder
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY KDTestBench IS
END KDTestBench;
 
ARCHITECTURE behavior OF KDTestBench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT keypadDecoder
    PORT(
         ROWS : IN  std_logic_vector(3 downto 0);
         CLK : IN  std_logic;
         LEDS : OUT  std_logic_vector(2 downto 0);
         COLUMNS : OUT  std_logic_vector(2 downto 0);
         OUTPUT : OUT  std_logic_vector(3 downto 0);
         VALID : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal ROWS : std_logic_vector(3 downto 0) := (others => '0');
   signal CLK : std_logic := '0';

 	--Outputs
   signal LEDS : std_logic_vector(2 downto 0);
   signal COLUMNS : std_logic_vector(2 downto 0);
   signal OUTPUT : std_logic_vector(3 downto 0);
   signal VALID : std_logic;

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: keypadDecoder PORT MAP (
          ROWS => ROWS,
          CLK => CLK,
          LEDS => LEDS,
          COLUMNS => COLUMNS,
          OUTPUT => OUTPUT,
          VALID => VALID
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for CLK_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
