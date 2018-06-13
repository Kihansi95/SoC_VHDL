--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   11:14:14 05/14/2018
-- Design Name:   
-- Module Name:   /home/dhnguye1/compilo/ALU_test_bench.vhd
-- Project Name:  compilo
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: ALU
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
 
ENTITY ALU_test_bench IS
END ALU_test_bench;
 
ARCHITECTURE behavior OF ALU_test_bench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ALU
    PORT(
         A : IN  std_logic_vector(15 downto 0);
         B : IN  std_logic_vector(15 downto 0);
         Op : IN  std_logic_vector(15 downto 0);
         Flags : OUT  std_logic_vector(3 downto 0);
         Output : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal A : std_logic_vector(15 downto 0) := (others => '0');
   signal B : std_logic_vector(15 downto 0) := (others => '0');
   signal Op : std_logic_vector(15 downto 0) := (others => '0');

 	--Outputs
   signal Flags : std_logic_vector(3 downto 0);
   signal Output : std_logic_vector(15 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ALU PORT MAP (
          A => A,
          B => B,
          Op => Op,
          Flags => Flags,
          Output => Output
        );

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		
		--		test add			  		test flags(C & Z)			test mul				 	test flags(O)				test equ
		A 	<= x"0002" after 2ns, 	x"FFFF" after 100ns, 	x"0003" after 120ns, x"9FFF" after 210ns, 	x"0009" after 304ns;
		B 	<= x"0001" after 1ns, 	x"0001" after 100ns, 	x"0002" after 110ns, x"00E3" after 205ns, 	x"0009" after 302ns;		
		Op <= x"0001" after 1.5ns,					   			x"0002" after 105ns,	x"0002"  after 209ns, 	x"0009" after 301ns;
		
		--RST 	<= '0' after 50 ns,'1' after 100 ns, '0' after 450 ns;
		--LOAD 	<= '1' after 60 ns,'0' after 170 ns;
		--EN 	<= '0' after 100 ns,'1' after 400 ns;
		--SENS  <= '1' after 290 ns, '0' after 350 ns, '1' after 390 ns, '0' after 420 ns; 
		wait for 100 ns;


      -- insert stimulus here 

      wait;
   end process;

END;
