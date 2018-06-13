LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY aleas_manager_test_bench IS
END aleas_manager_test_bench;
 
ARCHITECTURE behavior OF aleas_manager_test_bench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT aleas_manager
    PORT(
         clk : IN  std_logic;
         dec_OP: in  STD_LOGIC_VECTOR (7 downto 0);
			dec_A : in  STD_LOGIC_VECTOR (15 downto 0);
			dec_B : in  STD_LOGIC_VECTOR (15 downto 0);
			dec_C : in  STD_LOGIC_VECTOR (15 downto 0);
			li_di_OP: in  STD_LOGIC_VECTOR (7 downto 0);
			li_di_A : in  STD_LOGIC_VECTOR (15 downto 0);
			li_di_B : in  STD_LOGIC_VECTOR (15 downto 0);
			li_di_C : in  STD_LOGIC_VECTOR (15 downto 0);
			di_ex_OP: in  STD_LOGIC_VECTOR (7 downto 0);
			di_ex_A : in  STD_LOGIC_VECTOR (15 downto 0);
			di_ex_B : in  STD_LOGIC_VECTOR (15 downto 0);
			di_ex_C : in  STD_LOGIC_VECTOR (15 downto 0);
         clk_ctrl : OUT  std_logic;
         aleas_op	: out	 STD_LOGIC_VECTOR (7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal dec_OP : std_logic_vector(7 downto 0) := (others => '0');
   signal dec_A : std_logic_vector(15 downto 0) := (others => '0');
   signal dec_B : std_logic_vector(15 downto 0) := (others => '0');
   signal dec_C : std_logic_vector(15 downto 0) := (others => '0');
   signal li_di_OP : std_logic_vector(7 downto 0) := (others => '0');
   signal li_di_A : std_logic_vector(15 downto 0) := (others => '0');
   signal li_di_B : std_logic_vector(15 downto 0) := (others => '0');
   signal li_di_C : std_logic_vector(15 downto 0) := (others => '0');
	signal di_ex_OP : std_logic_vector(7 downto 0) := (others => '0');
   signal di_ex_A : std_logic_vector(15 downto 0) := (others => '0');
   signal di_ex_B : std_logic_vector(15 downto 0) := (others => '0');
   signal di_ex_C : std_logic_vector(15 downto 0) := (others => '0');

 	--Outputs
   signal clk_ctrl : std_logic;
   signal aleas_op : std_logic_vector(7 downto 0) := (others => '0');

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
	type INSTRUCTION is array(integer range <>) of STD_LOGIC_VECTOR(31 downto 0);
 	signal ins : 
		INSTRUCTION(0 to 15) := (
			x"06015555",	-- AFC 1 5555
			x"06022222",	-- AFC 2 2222
			x"01020102",	-- ADD 2 1 2
			others => x"00000000"
		);	
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: aleas_manager PORT MAP (
          clk => clk,
          dec_OP => dec_OP,
          dec_A => dec_A,
			 dec_B =>dec_B,
			 dec_C =>dec_C,
			 li_di_OP=>li_di_OP,
 			 li_di_A =>li_di_A,
 			 li_di_B =>li_di_B,
			 li_di_C =>li_di_C,
			 di_ex_OP=>di_ex_OP,
 			 di_ex_A =>di_ex_A,
 			 di_ex_B =>di_ex_B,
			 di_ex_C =>di_ex_C,
			 clk_ctrl =>clk_ctrl,
			 aleas_op =>aleas_op
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
		-- [LI/DI] -> [DI/EX]
		-- test [AFC 2 2222] -> [AFC 1 5555] : expect 0 conflict		
		dec_OP <= 		  ins(1)(31 downto 24);
		dec_A 	<= x"00" & ins(1)(23 downto 16);
		dec_B	<= x"00" & ins(1)(15 downto 8);
		dec_C	<= x"00" & ins(1)(7 downto 0);
		
		li_di_OP <= 		  ins(0)(31 downto 24);
		li_di_A 	<= x"00" & ins(0)(23 downto 16);
		li_di_B	<= x"00" & ins(0)(15 downto 8);
		li_di_C	<= x"00" & ins(0)(7 downto 0);
		wait for 10ns;
		
		-- test [ADD 2 1 2] -> [AFC 2 2222] : expect 1 conflict
		dec_OP <= 		  ins(2)(31 downto 24);
		dec_A 	<= x"00" & ins(2)(23 downto 16);
		dec_B	<= x"00" & ins(2)(15 downto 8);
		dec_C	<= x"00" & ins(2)(7 downto 0);
		
		li_di_OP <=   		  ins(1)(31 downto 24);
		li_di_A 	<= x"00" & ins(1)(23 downto 16);
		li_di_B	<= x"00" & ins(1)(15 downto 8);
		li_di_C	<= x"00" & ins(1)(7 downto 0);
		wait for 10ns;
		
		-- test [ADD 2 1 2] -> [AFC 3 1234] : expect 0 conflict
		dec_OP <= 		  ins(3)(31 downto 24);
		dec_A 	<= x"00" & ins(3)(23 downto 16);
		dec_B	<= x"00" & ins(3)(15 downto 8);
		dec_C	<= x"00" & ins(3)(7 downto 0);
		
		li_di_OP <=   		  ins(2)(31 downto 24);
		li_di_A 	<= x"00" & ins(2)(23 downto 16);
		li_di_B	<= x"00" & ins(2)(15 downto 8);
		li_di_C	<= x"00" & ins(2)(7 downto 0);
		wait for 10ns;
		
		-- test [ADD 2 1 2] -> [AFC 2 2222] : expect 1 conflict
		dec_OP <= 		  ins(2)(31 downto 24);
		dec_A 	<= x"00" & ins(2)(23 downto 16);
		dec_B	<= x"00" & ins(2)(15 downto 8);
		dec_C	<= x"00" & ins(2)(7 downto 0);
		
		di_ex_OP <=   		  ins(1)(31 downto 24);
		di_ex_A 	<= x"00" & ins(1)(23 downto 16);
		di_ex_B	<= x"00" & ins(1)(15 downto 8);
		di_ex_C	<= x"00" & ins(1)(7 downto 0);
		
      wait;
   end process;

END;
