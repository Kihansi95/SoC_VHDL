--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   11:41:08 05/29/2018
-- Design Name:   
-- Module Name:   /home/dhnguye1/compilo/CL_test_bench.vhd
-- Project Name:  compilo
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: CL
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
 
ENTITY CL_test_bench IS
END CL_test_bench;
 
ARCHITECTURE behavior OF CL_test_bench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT CL
    PORT(
         OP : IN  std_logic_vector(7 downto 0);
         W : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal OP : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal W : std_logic;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: CL PORT MAP (
          OP => OP,
          W => W
        ); 

   -- Stimulus process
   stim_proc: process
   begin		
      OP <= x"01" after 1ns,
				x"02" after 2ns,
				x"03" after 3ns,
				x"04" after 4ns,
				x"05" after 5ns,
				x"06" after 6ns,
				x"07" after 7ns,
				x"08" after 8ns,
				x"09" after 9ns,
				x"0A" after 10ns,
				x"0B" after 11ns,
				x"0C" after 12ns,
				x"0D" after 13ns,
				x"0E" after 14ns,
				x"0F" after 15ns;
      wait;
   end process;

END;
