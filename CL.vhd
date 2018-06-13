----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:37:24 05/29/2018 
-- Design Name: 
-- Module Name:    CL - Behavioral 
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

entity CL is
    Port ( OP : in  STD_LOGIC_VECTOR (7 downto 0);
           W : out  STD_LOGIC);
end CL;

architecture Behavioral of CL is

begin
	W <= '0' when OP = x"08" or OP = x"0E" or OP = x"0F" else '1';
end Behavioral;

