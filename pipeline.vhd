----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:47:25 05/15/2018 
-- Design Name: 
-- Module Name:    pipeline - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity pipeline is
    Port ( 	clk : in  STD_LOGIC;
				p_in1, p_in2, p_in3, p_in4, p_in5 : IN  std_logic_vector(15 downto 0);
				p_out1, p_out2, p_out3, p_out4, p_out5 : OUT  std_logic_vector(15 downto 0)
			);
end pipeline;

architecture Behavioral of pipeline is

begin
	process
	begin
		wait until clk'event and clk='1';
		p_out1 <= p_in1;
		p_out2 <= p_in2;
		p_out3 <= p_in3;
		p_out4 <= p_in4;
		p_out5 <= p_in5;
	end process;
end Behavioral;

