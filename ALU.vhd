----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:41:10 05/14/2018 
-- Design Name: 
-- Module Name:    ALU - Behavioral 
-- Project Name: 	 Compilo
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ALU is
    Port ( A : 		in  STD_LOGIC_VECTOR (15 downto 0);
           B : 		in  STD_LOGIC_VECTOR (15 downto 0);
           Op : 		in  STD_LOGIC_VECTOR (15 downto 0);
           Flags : 	out STD_LOGIC_VECTOR (3 downto 0);
           Output : 	out STD_LOGIC_VECTOR (15 downto 0));	-- Sortie == output
end ALU;

architecture Behavioral of ALU is
signal R:		std_logic_vector(15 downto 0):=(others => '0');
signal Radd:	std_logic_vector(16 downto 0):=(others => '0');
signal Rmul:	std_logic_vector(31 downto 0):=(others => '0');

constant Z: integer := 0; -- Zero
constant C: integer := 1; -- Carry
constant S: integer := 2; -- Signed 
constant O: integer := 3; -- Overflow

constant c_1: std_logic_vector(15 downto 0):=(0 => '1', others => '0');
constant c_0: std_logic_vector(15 downto 0):=(others => '0');

begin

	Rmul <= A * B;
	Radd <= ('0'&A) + ('0'&B);
	
   R <= 	Radd(15 downto 0)	when op = x"1" else 	-- add
         Rmul(15 downto 0)	when op = x"2" else 	-- mul
			A - B 				when op = x"3" else	-- sub

			c_1	when op = x"9" and A = B 	else c_0 when op = x"9" and A /= B else	-- equ
			c_1	when op = x"A" and A < B 	else c_0 when op = x"A" and A >= B else	-- inf
			c_1	when op = x"B" and A <= B 	else c_0 when op = x"B" and A > B else	-- infe
			c_1	when op = x"C" and A > B 	else c_0 when op = x"C" and A <= B else	-- sup
			c_1	when op = x"D" and A <= B 	else c_0 when op = x"B" and A > B else	-- supe
			
			c_0;
			
	-- update the flags
   Flags(C) <= Radd(16) when op = x"1" else '0';
   Flags(Z) <= '1' when R = c_0 else '0'; -- flag zero
	Flags(S) <= '1' when op = x"3" and A < B else '0';
	Flags(O)	<= '1' when op = x"2" and Rmul(31 downto 16) > c_0 else '0';
	
	-- output
   Output <= R; 									-- S n'est pas réutilisable


end Behavioral;

