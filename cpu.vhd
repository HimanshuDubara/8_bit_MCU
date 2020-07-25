library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.ALL;

entity cpu is
port(clock: in std_logic;
	  reset: in std_logic;
	  w: out std_logic;
     address: out std_logic_vector(7 downto 0);
	  from_memory: in std_logic_vector(7 downto 0);
	  to_memory: out std_logic_vector(7 downto 0)		
); 
end cpu;

architecture cpu_work of cpu is
signal ir_l,mar_l,pc_l,pc_in,a_l,b_l,ccr_l: std_logic;
signal b2_sel,b1_sel: std_logic_vector(1 downto 0);
signal ccr_res:std_logic_vector(3 downto 0);
signal ir_o: std_logic_vector(7 downto 0);
signal alu_s: std_logic_vector(3 downto 0);

component control_unit is
port(IR: in std_logic_vector(7 downto 0);
	  CCR_Result: in std_logic_vector(3 downto 0);
	  clock: in std_logic;
	  reset: in std_logic;
	  IR_Load: out std_logic;
	  MAR_Load: out std_logic;
	  PC_Load: out std_logic;
     PC_Inc: out std_logic;
	  A_Load: out std_logic;
	  B_Load: out std_logic;
	  ALU_Sel: out std_logic_vector(3 downto 0);
	  CCR_Load: out std_logic;
	 Bus2_Sel: out std_logic_vector(1 downto 0);
	 Bus1_Sel: out std_logic_vector(1 downto 0);
	 write1: out std_logic
	 );
end component;

component data_path is
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
end component;

begin
	CU: control_unit port map(IR => ir_o,
									  CCR_Result => ccr_res,
									  clock => clock,
									  reset =>reset,
									  IR_Load => ir_l,
									  MAR_Load => mar_l,
									  PC_Load => pc_l,
									  PC_Inc => pc_in,
									  A_Load => a_l,
									  B_Load => b_l,
									  ALU_Sel => alu_s,
									  CCR_Load => ccr_l,
									  Bus2_Sel => b2_sel,
									  Bus1_Sel => b1_sel,
									  write1 => w
									  );
	DP: data_path port map(IR_Load => ir_l,
                          MAR_Load => mar_l,
								  PC_Load => pc_l,
								  PC_Inc => pc_in,
								  A_Load => a_l,
								  B_Load => b_l,
								  ALU_Sel => alu_s,
								  CCR_Result => ccr_res,
								  CCR_Load => ccr_l,
								  Bus2_Sel => b2_sel,
								  Bus1_Sel => b1_sel,
								  clock => clock,
								  reset =>reset,
								  IR_out => ir_o,
								  address => address,
								  from_memory => from_memory,
								  to_memory => to_memory
								  );
end cpu_work;

 
