library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.ALL;

entity data_path is
port(
IR_Load: in std_logic;
MAR_Load: in std_logic;
PC_Load: in std_logic;
PC_Inc: in std_logic;
A_Load: in std_logic;
B_Load: in std_logic;
ALU_Sel: in std_logic_vector(3 downto 0);
CCR_Result: out std_logic_vector(3 downto 0);
CCR_Load: in std_logic;
Bus2_Sel: in std_logic_vector(1 downto 0);
Bus1_Sel: in std_logic_vector(1 downto 0);
clock: in std_logic;
reset: in std_logic;
IR_out: out std_logic_vector(7 downto 0);
address: out std_logic_vector(7 downto 0);
from_memory: in std_logic_vector(7 downto 0);
to_memory: out std_logic_vector(7 downto 0)

); 
end data_path;



architecture data of data_path is

				component alu is
				--  Port ( );
					 PORT( A,B : in std_logic_vector(7 downto 0);
							ALU_sel : in std_logic_vector(3 downto 0);
							NZVC : out std_logic_vector(3 downto 0);
							ALU_result : out std_logic_vector(7 downto 0)
					 );
					 
				end component;


				component BUS1 is
				port( PC: in std_logic_vector(7 downto 0);
						A: in std_logic_vector(7 downto 0);
						B: in std_logic_vector(7 downto 0);
						Bus1_Sel: in std_logic_vector(1 downto 0);
						Bus1Output: out std_logic_vector(7 downto 0));
				end component;

				component BUS2 is
				port( ALU_Result: in std_logic_vector(7 downto 0);
						from_memory: in std_logic_vector(7 downto 0);
						Bus2Output: out std_logic_vector(7 downto 0);
						Bus2_Sel: in std_logic_vector(1 downto 0);
						Bus1: in std_logic_vector(7 downto 0));
				end component;


				component CONDITION_CODE_REGISTER is
							 port( Clock: in std_logic;
						Reset: in std_logic;
						NZVC: in std_logic_vector(3 downto 0);
						CCR_Load: in std_logic;
						CCR_Result: out std_logic_vector(3 downto 0));
				end component;


				component INSTRUCTION_REGISTER is
				port( BUS2: in std_logic_vector(7 downto 0);
						Clock: in std_logic;
						Reset: in std_logic;
						IR_Load: in std_logic;
						IR: out std_logic_vector(7 downto 0));
				end component;

				component MEMORY_REGISTER_ADDRESS is
				port( BUS2: in std_logic_vector(7 downto 0);
						Clock: in std_logic;
						Reset: in std_logic;
						MAR_Load: in std_logic;
						MARe: out std_logic_vector(7 downto 0));
				end component;

				component PROGRAM_COUNTER is 
				port( BUS2: in std_logic_vector(7 downto 0);
						Clock: in std_logic;
						Reset: in std_logic;
						PC_Inc: in std_logic;
						PC_Load: in std_logic;
						PC: out std_logic_vector(7 downto 0));
				end component;

				component RegisterA is
				port( BUS2: in std_logic_vector(7 downto 0);
						Clock: in std_logic;
						Reset: in std_logic;
						A: out std_logic_vector(7 downto 0);
						A_Load: in std_logic);
				end component;

				component RegisterB is
				port( BUS2: in std_logic_vector(7 downto 0);
						Clock: in std_logic;
						Reset: in std_logic;
						B: out std_logic_vector(7 downto 0);
						B_Load: in std_logic);
				end component;

signal bus1_out,bus2_out,mar_out,pc_out,a_out,b_out,alu_out: std_logic_vector(7 downto 0);
signal nzvc_out: std_logic_vector(3 downto 0);
begin
	A: alu port map(A => a_out,
						 B =>b_out,
						 ALU_Sel => ALU_Sel,
						 NZVC => nzvc_out,
						 ALU_result => alu_out			 
						);
	
	B1: BUS1 port map(PC => pc_out,
							A => a_out,
							B => b_out,
							Bus1_Sel => Bus1_Sel,
							BUS1Output => bus1_out
							);
	B2: BUS2 port map(ALU_result => alu_out,
							from_memory => from_memory,
							BUS2Output => bus2_out,
							Bus2_Sel => Bus2_Sel,
							Bus1 => bus1_out
							);
	C1: CONDITION_CODE_REGISTER port map(Clock => clock,
													 Reset => reset,
													NZVC => nzvc_out,
												   CCR_Load => CCR_Load,
												   CCR_Result => CCR_Result	
													);
	I1: INSTRUCTION_REGISTER port map(BUS2 => bus2_out,
												 Clock => clock,
												 Reset => reset,
												 IR_Load => IR_Load,
												 IR => IR_out 
												);
	M1: MEMORY_REGISTER_ADDRESS port map(BUS2 => bus2_out,
													 Clock => clock,
													 Reset => reset,
													 MAR_Load => MAR_Load,
													 MARe => address
													);
	P: PROGRAM_COUNTER port map(BUS2 => bus2_out,
										 Clock => clock,
							          Reset => reset,			 
										 PC_Inc => PC_Inc,
										 PC_Load => PC_Load,
										 PC => pc_out
										 );
	R1: REGISTERA port map(BUS2 => bus2_out,
								  Clock => clock,
								  Reset => reset,
								  A => a_out,
								  A_Load => A_Load 
								 );									
	
	R2: REGISTERB port map(BUS2 => bus2_out,
								  Clock => clock,
								  Reset => reset,
								  B => b_out,
								  B_Load => B_Load 
								 );
end data;


