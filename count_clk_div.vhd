-----------------------------------------------------------------------
-----------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
-----------------------------------------------------------------------
-- Module to divide the clock 
-----------------------------------------------------------------------
entity count_clk_div is
    Port (  clk : in std_logic;
	        div : in STD_LOGIC_VECTOR(23 downto 0);
           sclk : out std_logic);
end count_clk_div;

architecture count_clk_div of count_clk_div is
   signal tmp_clk : std_logic := '0'; 
begin
   my_div: process (clk,tmp_clk)              
      variable div_cnt : integer := 0;   
   begin
      if (rising_edge(clk)) then   
         if (div_cnt = div) then 
            tmp_clk <= not tmp_clk; 
            div_cnt := 0; 
         else
            div_cnt := div_cnt + 1; 
         end if; 
      end if; 
      sclk <= tmp_clk; 
   end process my_div; 
end count_clk_div;