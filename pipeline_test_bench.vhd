--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   09:51:23 05/15/2018
-- Design Name:   
-- Module Name:   /home/dhnguye1/compilo/pipeline_test_bench.vhd
-- Project Name:  compilo
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: pipeline
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
 
ENTITY pipeline_test_bench IS
END pipeline_test_bench;
 
ARCHITECTURE behavior OF pipeline_test_bench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT pipeline
    PORT(
			clk : in  STD_LOGIC;
         p_in1, p_in2, p_in3, p_in4, p_in5 : IN  std_logic_vector(15 downto 0);
			p_out1, p_out2, p_out3, p_out4, p_out5 : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
	signal clk : std_logic := '0';
   signal p_in1 : std_logic_vector(15 downto 0) := (others => '0');
   signal p_in2 : std_logic_vector(15 downto 0) := (others => '0');
   signal p_in3 : std_logic_vector(15 downto 0) := (others => '0');
   signal p_in4 : std_logic_vector(15 downto 0) := (others => '0');
   signal p_in5 : std_logic_vector(15 downto 0) := (others => '0');

 	--Outputs
   signal p_out1 : std_logic_vector(15 downto 0);
   signal p_out2 : std_logic_vector(15 downto 0);
   signal p_out3 : std_logic_vector(15 downto 0);
   signal p_out4 : std_logic_vector(15 downto 0);
   signal p_out5 : std_logic_vector(15 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   -- Clock period definitions
   constant clk_period : time := 100 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: pipeline PORT MAP (
          clk => clk,
          p_in1 => p_in1,
          p_in2 => p_in2,
          p_in3 => p_in3,
          p_in4 => p_in4,
          p_in5 => p_in5,
          p_out1 => p_out1,
          p_out2 => p_out2,
          p_out3 => p_out3,
          p_out4 => p_out4,
          p_out5 => p_out5
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		
		p_in1 <= x"0000" after 20ns;
		p_in2 <= x"0052" after 10ns;
		p_in3 <= x"00F3" after 40ns;
		p_in4 <= x"00F2" after 45ns;
		p_in5 <= x"0D0A" after 30ns;

      wait;
   end process;

END;
