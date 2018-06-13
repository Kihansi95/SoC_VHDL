--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   09:55:53 05/29/2018
-- Design Name:   
-- Module Name:   /home/dhnguye1/compilo/register_test_bench.vhd
-- Project Name:  compilo
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: registre
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
 
ENTITY register_test_bench IS
END register_test_bench;
 
ARCHITECTURE behavior OF register_test_bench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT registre
    PORT(
         A : IN  std_logic_vector(7 downto 0);
         B : IN  std_logic_vector(7 downto 0);
         W : IN  std_logic;
         adr_W : IN  std_logic_vector(7 downto 0);
         Data : IN  std_logic_vector(7 downto 0);
         clk : IN  std_logic;
         RST : IN  std_logic;
         QA : OUT  std_logic_vector(7 downto 0);
         QB : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal A : std_logic_vector(7 downto 0) := (others => '0');
   signal B : std_logic_vector(7 downto 0) := (others => '0');
   signal W : std_logic := '0';
   signal adr_W : std_logic_vector(7 downto 0) := (others => '0');
   signal Data : std_logic_vector(7 downto 0) := (others => '0');
   signal clk : std_logic := '0';
   signal RST : std_logic := '0';

 	--Outputs
   signal QA : std_logic_vector(7 downto 0);
   signal QB : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: registre PORT MAP (
	       clk => clk,
          A => A,
          B => B,
          W => W,
          adr_W => adr_W,
          Data => Data,

          RST => RST,
          QA => QA,
          QB => QB
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
		
		RST 	<= '0' 	after 1ns, '1' after 10ns;
		W 		<= '1' 	after 11ns, '1' after 21ns;
		adr_W <= x"00" after 10ns, x"02" after 21ns;
		Data  <= x"FF" after 10ns, x"0A" after 20ns;
		
		A <= x"00" after 11ns;
		B <= x"00" after 11ns, x"02"after 15ns;
		
		wait;
   end process;

END;
