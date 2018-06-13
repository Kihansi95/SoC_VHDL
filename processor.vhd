library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity processor is
	--Port( clk_proc : 	in  STD_LOGIC ;
   --      ins_di : in  STD_LOGIC_VECTOR (31 downto 0));
	Port( 
		clk_proc : 	in  STD_LOGIC
		
		);
end processor;

architecture behavioral of processor is

	----------------------------------------------------------------------------------------------------------------------------------
	-- external components
	----------------------------------------------------------------------------------------------------------------------------------
	
	component bram16
	port (
	  -- System
	  sys_clk : in std_logic;
	  sys_rst : in std_logic;
	  -- Master
	  di : out std_logic_vector(15 downto 0);
	  we : in std_logic;
	  a : in std_logic_vector(15 downto 0);
	  do : in std_logic_vector(15 downto 0));
	end component;
	
	component bram32
	port (
		-- System
		sys_clk : in std_logic;
		sys_rst : in std_logic;
		-- Master
		di : in std_logic_vector(31 downto 0);
		we : in std_logic;
		a : in std_logic_vector(15 downto 0);
		do : out std_logic_vector(31 downto 0));
	end component;

	----------------------------------------------------------------------------------------------------------------------------------
	-- components
	----------------------------------------------------------------------------------------------------------------------------------

	component instruction_pointer is
		Port ( 	clk: 		in 	STD_LOGIC;
					clk_enable:	in STD_LOGIC;
					load: 		in 	STD_LOGIC;
					adr_load : 	in 	STD_LOGIC_VECTOR(15 downto 0);
					ip : 			out  STD_LOGIC_VECTOR (15 downto 0));
	end component;

	component decoder is
		Port ( ins_di : in  STD_LOGIC_VECTOR (31 downto 0);
				 OP : out  STD_LOGIC_VECTOR (7 downto 0);
				 A : out  STD_LOGIC_VECTOR (15 downto 0);
				 B : out  STD_LOGIC_VECTOR (15 downto 0);
				 C : out  STD_LOGIC_VECTOR (15 downto 0));
	end component;
	
	component pipeline is
		Port( clk : in  STD_LOGIC;
				p_in1, p_in2, p_in3, p_in4, p_in5 : in  STD_LOGIC_VECTOR (15 downto 0);
				p_out1, p_out2, p_out3, p_out4, p_out5 : out  STD_LOGIC_VECTOR (15 downto 0));
	end component;
		
	component registre is
		Port( A, B : in  		STD_LOGIC_VECTOR (15 downto 0);
				W : in  		STD_LOGIC;
				adr_W : in  STD_LOGIC_VECTOR (15 downto 0);
				Data : in  	STD_LOGIC_VECTOR (15 downto 0);
				clk: in 		STD_LOGIC;
				RST: in 		STD_LOGIC;
			  
				QA : out  STD_LOGIC_VECTOR (15 downto 0);
				QB : out  STD_LOGIC_VECTOR (15 downto 0));
	end component;
	
	component ALU is
	Port( A : 		in  STD_LOGIC_VECTOR (15 downto 0);
			B : 		in  STD_LOGIC_VECTOR (15 downto 0);
			Op : 		in  STD_LOGIC_VECTOR (15 downto 0);
			Flags : 	out STD_LOGIC_VECTOR (3 downto 0);
			Output : out STD_LOGIC_VECTOR (15 downto 0));	-- Sortie == output
	end component;
	
	component aleas_manager is
    Port ( 
				-- input
				clk : in std_logic ;
				
				-- named after the following pipeline
				dec_OP: in  STD_LOGIC_VECTOR (7 downto 0);
				dec_B : in  STD_LOGIC_VECTOR (15 downto 0);
				dec_C : in  STD_LOGIC_VECTOR (15 downto 0);
				
				li_di_OP: in  STD_LOGIC_VECTOR (7 downto 0);
				li_di_A : in  STD_LOGIC_VECTOR (15 downto 0);
				
				di_ex_OP: in  STD_LOGIC_VECTOR (7 downto 0);
				di_ex_A : in  STD_LOGIC_VECTOR (15 downto 0);
				
				-- output
				clk_ctrl 	: out  STD_LOGIC;
				aleas_op		: out	 STD_LOGIC_VECTOR (7 downto 0)
				);
	end component;
	
	----------------------------------------------------------------------------------------------------------------------------------
	-- local signal
	----------------------------------------------------------------------------------------------------------------------------------
		
	-- Ip output
	signal ip_out: 		std_logic_vector(15 downto 0);
	
	-- Ins mem output
	signal ins_di: 		std_logic_vector(31 downto 0);
	
	-- Dec output
	signal DEC_OP: 		std_logic_vector(7 downto 0);
	signal DEC_A: 			std_logic_vector(15 downto 0);
	signal DEC_B: 			std_logic_vector(15 downto 0);
	signal DEC_C: 			std_logic_vector(15 downto 0);
	
	-- LI/DI output
	signal li_di_OP: 		std_logic_vector(15 downto 0);
	signal li_di_A: 		std_logic_vector(15 downto 0);
	signal li_di_B: 		std_logic_vector(15 downto 0);
	signal li_di_C: 		std_logic_vector(15 downto 0);
	
	-- aleas manager output
	signal clk_control:		std_logic;
	signal aleas_op:		std_logic_vector(7 downto 0);
	
	-- register bank output
	signal reg_QA : 		std_logic_vector(15 downto 0);
	signal reg_QB : 		std_logic_vector(15 downto 0);
	
	-- register MUX 
	signal mux_reg_op: 	std_logic_vector(7 downto 0);
	signal mux_reg_out: 	std_logic_vector(15 downto 0);
	
	-- DI/EX output
	signal di_ex_OP: 		std_logic_vector(15 downto 0);
	signal di_ex_A: 		std_logic_vector(15 downto 0);
	signal di_ex_B: 		std_logic_vector(15 downto 0);
	signal di_ex_C: 		std_logic_vector(15 downto 0);
	
	-- ALU MUX 
	signal mux_alu_op: 	std_logic_vector(7 downto 0);
	signal mux_alu_out: 	std_logic_vector(15 downto 0);
	
	-- ALU output
	signal alu_output : 	std_logic_vector(15 downto 0);
	
	-- EX/Mem output
	signal ex_mem_OP: 	std_logic_vector(15 downto 0);
	signal ex_mem_A: 		std_logic_vector(15 downto 0);
	signal ex_mem_B: 		std_logic_vector(15 downto 0);
	
	-- Mem/RE output
	signal mem_re_OP: 	std_logic_vector(15 downto 0);
	signal mem_re_A: 		std_logic_vector(15 downto 0);
	signal mem_re_B: 		std_logic_vector(15 downto 0);
	
	-- LC Mem/RE output
	signal lc_mem_re_w: 	std_logic;
	signal lc_mem_re_op: std_logic_vector(7 downto 0);

	-- mux mem output
	signal mem_mux_out: std_logic_vector(15 downto 0);
	
	----------------------------------------------------------------------------------------------------------------------------------
	-- external i/o
	----------------------------------------------------------------------------------------------------------------------------------
	signal data_we: 	std_logic;
	signal data_di:	std_logic_vector(15 downto 0);
	signal data_a:		std_logic_vector(15 downto 0);
	signal data_do:	std_logic_vector(15 downto 0);
	
begin

	----------------------------------------------------------------------------------------------------------------------------------
	-- component instanciation
	----------------------------------------------------------------------------------------------------------------------------------

	ip : instruction_pointer port map (
		load			=> '0',	-- TODO need to map properly
		adr_load 	=>	x"0000",
		clk 	=> clk_proc,
		clk_enable 	=> clk_control,
		ip 	=> ip_out
	);
	
	dec : decoder port map (
		ins_di => ins_di,
	
		OP => DEC_OP,
		A 	=> DEC_A,
		B 	=> DEC_B,
		C 	=> DEC_C
	);
	
	li_di : pipeline port map (
		clk 		=> clk_proc,
		p_in1 	=>	x"00" & aleas_op,
		p_in2 	=>	DEC_A,
		p_in3 	=>	DEC_B,
		p_in4 	=>	DEC_C,
		p_in5		=> x"0000",
		
		p_out1	=> li_di_OP,
		p_out2	=> li_di_A,
		p_out3	=>	li_di_B,
		p_out4	=>	li_di_C
	);
	
	-- LI/DI aleas manager
	aleas : aleas_manager port map (
		clk		=> clk_proc,
		
		li_di_OP => li_di_OP(7 downto 0),
		li_di_A => 	li_di_A,
		
		di_ex_OP => di_ex_OP(7 downto 0),
		di_ex_A => 	di_ex_A,
		
		dec_OP => dec_OP(7 downto 0),
		dec_B => dec_B,
		dec_C => dec_C,
		
		clk_ctrl => clk_control,
		aleas_op	=> aleas_op
	);	
										
	register_bank : registre port map (
		A => li_di_B, 
		B => li_di_C,
		rst	=> '1',
		clk => clk_proc,
		
		W			=> lc_mem_re_w,
		adr_W 	=>	mem_re_A,
		DATA  	=> mem_mux_out,
		
		QA => reg_QA,
		QB => reg_QB
	);
	
	-- register multiplexer
	mux_reg_op <= li_di_OP(7 downto 0);
	mux_reg_out <= li_di_B when mux_reg_op = x"06" 
									or mux_reg_op = x"07" 
									or mux_reg_op = x"0E"
									else reg_QA;
		
	di_ex : pipeline port map (
		clk => clk_proc,
		p_in1 	=>	li_di_OP,
		p_in2 	=>	li_di_A,
		p_in3 	=>	mux_reg_out,
		p_in4 	=>	reg_QB,
		p_in5		=> x"0000",
		
		p_out1	=> di_ex_OP,
		p_out2	=> di_ex_A,
		p_out3	=>	di_ex_B,
		p_out4	=> di_ex_C
	);

	ual : ALU port map (
		A => 			di_ex_B,
		B => 			di_ex_C,
		Op => 		di_ex_op,
		
		Output =>	alu_output
	);		
		
	-- ALU multiplexer
	mux_alu_op <= di_ex_OP(7 downto 0);
	mux_alu_out <= alu_output when mux_alu_op = x"01" 
									or mux_alu_op = x"02" 
									or mux_alu_op = x"03" 
									or mux_alu_op = x"04" 
									else di_ex_B;
									

	ex_mem : pipeline port map (
		clk => clk_proc,
		p_in1 	=>	di_ex_OP,
		p_in2 	=>	di_ex_A,
		p_in3 	=>	mux_alu_out,
		p_in4 	=>	x"0000",
		p_in5		=> x"0000",
		
		p_out1	=> ex_mem_OP,
		p_out2	=> ex_mem_A,
		p_out3	=>	ex_mem_B
	);
	
	-- EX/Mem multiplexer
	data_a <= ex_mem_A when ex_mem_OP(7 downto 0) = x"08" else ex_mem_B;
	
	-- LC data memory
	data_we <= '1' when ex_mem_OP(7 downto 0) = x"08" else '0';
	
	mem_re : pipeline port map (
		clk => clk_proc,		
		p_in1 	=>	ex_mem_OP,
		p_in2 	=>	ex_mem_A,
		p_in3 	=>	ex_mem_B,
		p_in4 	=>	x"0000",
		p_in5		=> x"0000",
		
		p_out1	=> mem_re_OP,
		p_out2	=> mem_re_A,
		p_out3	=>	mem_re_B
	);
	
	-- LC Mem/RE
	lc_mem_re_op <= mem_re_OP(7 downto 0);
	lc_mem_re_W <= '0' when lc_mem_re_op = x"08" or lc_mem_re_op = x"0E" or lc_mem_re_op = x"0F" else '1';
		
	-- memory multiplexer
	mem_mux_out <= data_di when lc_mem_re_op = x"07" else mem_re_B;
	
	-- external mapping
	data_do <= ex_mem_B;
	
	----------------------------------------------------------------------------------------------------------------------------------
	-- external component instanciation
	----------------------------------------------------------------------------------------------------------------------------------
	data_memory : bram16 port map (
		sys_clk => clk_proc,
		-- sys_rst => rst,
		sys_rst => '0',
		di => data_di,
		do => data_do,
		a => data_a,
		we => data_we
	) ;
	
	instruction_memory : bram32 port map (
		sys_clk => clk_proc,
		-- sys_rst => rst,
		sys_rst => '1',
		di => x"00000000",
		do => 	ins_di,
		a => 		ip_out,
		we => 	'0'
	) ;

end Behavioral;

