--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   13:10:55 05/30/2018
-- Design Name:   
-- Module Name:   /home/dhnguye1/compilo/processor_test_bench.vhd
-- Project Name:  compilo
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: processor
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY processor_test_bench IS
END processor_test_bench;
 
ARCHITECTURE behavior OF processor_test_bench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT processor
    PORT(
         clk_proc : IN  std_logic);
    END COMPONENT;
    

   --Inputs
   signal clk_proc : std_logic := '0';
	
	signal ins_a : STD_LOGIC_VECTOR (15 downto 0);
	signal ins_di : STD_LOGIC_VECTOR (31 downto 0);

   -- Clock period definitions
   constant clk_proc_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: processor PORT MAP (
          clk_proc => clk_proc
        );

   -- Clock process definitions
   clk_proc_process :process
   begin
		clk_proc <= '0';
		wait for clk_proc_period/2;
		clk_proc <= '1';
		wait for clk_proc_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      wait;
   end process;

END;
