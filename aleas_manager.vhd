library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;

entity aleas_manager is
    Port ( 
				-- input
				clk : in std_logic ;
				
				-- named after the following pipeline
				dec_OP: in  STD_LOGIC_VECTOR (7 downto 0);
				dec_B : in  STD_LOGIC_VECTOR (15 downto 0);
				dec_C : in  STD_LOGIC_VECTOR (15 downto 0);
				
				li_di_OP: in  STD_LOGIC_VECTOR (7 downto 0);
				li_di_A : in  STD_LOGIC_VECTOR (15 downto 0);
				
				di_ex_OP: in  STD_LOGIC_VECTOR (7 downto 0);
				di_ex_A : in  STD_LOGIC_VECTOR (15 downto 0);
				
				-- output
				clk_ctrl 	: out  STD_LOGIC;
				aleas_op		: out	 STD_LOGIC_VECTOR (7 downto 0);
				retard_op	: out	STD_LOGIC_VECTOR (7 downto 0)
				);
end aleas_manager;

architecture Behavioral of aleas_manager is

signal li_di_write : std_logic;
signal di_ex_write : std_logic;
signal dec_read: std_logic;
signal conflict: std_logic;

begin
	-- check if the instruction in DI/EX will modify a register
	li_di_write <= '0' 	when li_di_OP = x"00" or li_di_OP = x"07" or li_di_OP = x"0E" or li_di_OP = x"0F" 
								else '1';
							
	di_ex_write <= '0'	when di_ex_OP = x"00" or di_ex_OP = x"07" or di_ex_OP = x"0E" or di_ex_OP = x"0F" 
								else '1';
								
	
	-- check if LI/DI will read a register (B or C)
	dec_read <= '0' when dec_OP = x"00" or dec_OP = x"06" or dec_OP = x"0E"
								else '1';
	
	-- check if conflict happens at DI/EX
	conflict <= '1' when  dec_read = '1' and dec_OP = x"08" and ((li_di_write = '1' and dec_B = li_di_A) 
													 or  (di_ex_write = '1' and dec_B = di_ex_A))
						 else '1' when  dec_read = '1' and dec_OP /= x"08" and((li_di_write = '1' and (dec_B = li_di_A or dec_C = li_di_A)) 
													 or  (di_ex_write = '1' and (dec_B = di_ex_A or dec_C = di_ex_A)))
						 else '0';
	
	-- in case conflict, we stop the clock and affect NOP
	clk_ctrl <= '1' when conflict = '1' else '0';
	aleas_op <= x"00" when conflict ='1' else dec_OP;

end Behavioral;

