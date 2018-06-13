----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:34:23 05/29/2018 
-- Design Name: 
-- Module Name:    decoder - Behavioral 
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

entity decoder is
    Port ( ins_di : in  STD_LOGIC_VECTOR (31 downto 0);
           OP : out  STD_LOGIC_VECTOR (7 downto 0);
           A : out  STD_LOGIC_VECTOR (15 downto 0);
           B : out  STD_LOGIC_VECTOR (15 downto 0);
           C : out  STD_LOGIC_VECTOR (15 downto 0));
end decoder;



architecture Behavioral of decoder is
	signal t_op : STD_LOGIC_VECTOR (7 downto 0);
	
begin	
	t_op <= ins_di(31 downto 24);
	
	OP <= t_op;
	
	A 	<=	ins_di(23 downto 8) 	when t_op = x"08" or t_op = x"0E" or t_op = x"0F" else 
			 x"00" & ins_di(23 downto 16);
			
	B	<= x"0000" 							when t_op = x"0E" else 
			ins_di(15 downto 0)  		when t_op = x"07" or t_op = x"06" else
			x"00" & ins_di(7 downto 0)	when t_op = x"08" or t_op = x"0F" else
			x"00" & ins_di(15 downto 8);
			
	C 	<= x"0000"					when t_op = x"0E" 
											or t_op = x"06" 
											or t_op = x"07" 
											or t_op = x"05" 
											or t_op = x"08" 
											or t_op = x"0F" else
			x"00" & ins_di(7 downto 0);

end Behavioral;

