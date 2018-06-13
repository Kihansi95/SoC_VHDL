library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity instruction_pointer is
    Port ( 	clk: 			in 	STD_LOGIC;
				clk_enable:  in 	STD_LOGIC;
				load: 		in 	STD_LOGIC := '0';
				adr_load : 	in 	STD_LOGIC_VECTOR(15 downto 0);
				ip : 			out  STD_LOGIC_VECTOR (15 downto 0));
end instruction_pointer;

architecture Behavioral of instruction_pointer is

signal cpt: STD_LOGIC_VECTOR (15 downto 0) := (others => '0');
	
begin
	process		
	begin
		wait until clk'event and clk = '1';
		if clk_enable = '0' then
			if (load='1') then
				cpt <= adr_load;
			else
				cpt <= cpt + 4;
			end if;
		end if;
	end process;
	ip <= cpt;
end Behavioral;

