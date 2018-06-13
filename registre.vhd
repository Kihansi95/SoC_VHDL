----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:14:57 05/15/2018 
-- Design Name: 
-- Module Name:    registre - Behavioral 
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
USE ieee.numeric_std.ALL; 

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity registre is
    Port ( A : in  		STD_LOGIC_VECTOR (15 downto 0);
           B : in  		STD_LOGIC_VECTOR (15 downto 0);
           W : in  		STD_LOGIC;
           adr_W : in  	STD_LOGIC_VECTOR (15 downto 0);
           Data : in  	STD_LOGIC_VECTOR (15 downto 0);
			  clk: in 		STD_LOGIC;
			  RST: in 		STD_LOGIC;
			  
           QA : out  STD_LOGIC_VECTOR (15 downto 0);
           QB : out  STD_LOGIC_VECTOR (15 downto 0));
           
end registre;

architecture Behavioral of registre is

type REGISTRE is array(integer range <>) of STD_LOGIC_VECTOR(15 downto 0);
signal reg_bank : REGISTRE(15 downto 0);

begin
	
	QA <= Data when W = '1' and adr_W = A else reg_bank(to_integer(unsigned(A(3 downto 0))));
	QB <= Data when W = '1' and adr_W = B else reg_bank(to_integer(unsigned(B(3 downto 0))));
	process
	begin
	wait until clk'event and clk='1';
		if W = '1' then
			reg_bank(to_integer(unsigned(adr_W(3 downto 0)))) <= Data;
		end if;
		
		if RST = '0' then
			reg_bank <= (others => x"0000");
		end if;
	end process;

end Behavioral;

