--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   10:53:41 05/29/2018
-- Design Name:   
-- Module Name:   /home/dhnguye1/compilo/decoder_test_bench.vhd
-- Project Name:  compilo
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: decoder
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
 
ENTITY decoder_test_bench IS
END decoder_test_bench;
 
ARCHITECTURE behavior OF decoder_test_bench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT decoder
    PORT(
         ins_di : IN  std_logic_vector(31 downto 0);
         OP : OUT  std_logic_vector(7 downto 0);
         A : OUT  std_logic_vector(15 downto 0);
         B : OUT  std_logic_vector(15 downto 0);
         C : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal ins_di : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal OP : std_logic_vector(7 downto 0);
   signal A : std_logic_vector(15 downto 0);
   signal B : std_logic_vector(15 downto 0);
   signal C : std_logic_vector(15 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: decoder PORT MAP (
          ins_di => ins_di,
          OP => OP,
          A => A,
          B => B,
          C => C
        );

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      ins_di <= 	x"01010203" after 10ns,	-- check ADD 1 2 3
						x"05010203" after 15ns,	-- check COP 1 2
						x"06011234" after 20ns,	-- check AFC 1 1234
						x"07011234" after 25ns,	-- check LOAD 1 1234
						x"08123402" after 30ns,	-- check STORE 1234 2
						x"0E432100" after 35ns,	-- check JMP 4321
						x"0F432101" after 40ns;	-- check JMPC 4321 1
      wait;
   end process;

END;
