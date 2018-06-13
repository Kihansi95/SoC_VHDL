LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY instruction_pointer_test_bench IS
END instruction_pointer_test_bench;
 
ARCHITECTURE behavior OF instruction_pointer_test_bench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT instruction_pointer
    PORT(
         clk_ip : IN  std_logic;
			clk_enable : IN std_logic;
         load : IN  std_logic;
         adr_load : IN  std_logic_vector(15 downto 0);
         ip : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
	signal clk_enable : std_logic := '1';
   signal load : std_logic := '0';
   signal adr_load : std_logic_vector(15 downto 0) := (others => '0');

 	--Outputs
   signal ip : std_logic_vector(15 downto 0);

   constant clk_period : time := 10 ns;
 
BEGIN
 
   uut: instruction_pointer PORT MAP (
          clk_ip => clk,
			 clk_enable => clk_enable,
          load => load,
          adr_load => adr_load,
          ip => ip
        );
		  
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;

   stim_proc: process
   begin		
      wait;
   end process;

END;
