library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL; 


entity instruction_memory is
    Port ( ins_a : in  STD_LOGIC_VECTOR (15 downto 0);
           ins_di : out  STD_LOGIC_VECTOR (31 downto 0));
end instruction_memory;

architecture Behavioral of instruction_memory is
	type INSTRUCTION is array(integer range <>) of STD_LOGIC_VECTOR(31 downto 0);
	signal ins_mem : 
		INSTRUCTION(0 to 15) := (
			x"06025555",	-- AFC 2 0x5555
			x"06011001",	-- AFC 1 0x1001
			x"01010102",	-- ADD 1 1 2
			others => x"00000000"
		);	
begin
	ins_di <= ins_mem(to_integer(unsigned(ins_a(3 downto 0))));

end Behavioral;

