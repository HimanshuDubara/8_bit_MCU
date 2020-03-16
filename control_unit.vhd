library IEEE;
use IEEE.std_logic_1164.all;

--defining the instruction set
constant LDA_IMM : std_logic_vector (7 downto 0) := x"86";
constant LDA_DIR : std_logic_vector (7 downto 0) := x"87";
constant LDB_IMM : std_logic_vector (7 downto 0) := x"88";
constant LDB_DIR : std_logic_vector (7 downto 0) := x"89";
constant STA_DIR : std_logic_vector (7 downto 0) := x"96";
constant STB_DIR : std_logic_vector (7 downto 0) := x"97";
constant ADD_AB : std_logic_vector (7 downto 0) := x"42";
constant SUB_AB : std_logic_vector (7 downto 0) := x"43";
constant AND_AB : std_logic_vector (7 downto 0) := x"44";
constant OR_AB : std_logic_vector (7 downto 0) := x"45";
constant INCA : std_logic_vector (7 downto 0) := x"46";
constant INCB : std_logic_vector (7 downto 0) := x"47";
constant DECA : std_logic_vector (7 downto 0) := x"48";
constant DECB : std_logic_vector (7 downto 0) := x"49";
constant BRA : std_logic_vector (7 downto 0) := x"20";
constant BMI : std_logic_vector (7 downto 0) := x"21";
constant BPL : std_logic_vector (7 downto 0) := x"22";
constant BEQ : std_logic_vector (7 downto 0) := x"23";
constant BNE : std_logic_vector (7 downto 0) := x"24";
constant BVS : std_logic_vector (7 downto 0) := x"25";
constant BVC : std_logic_vector (7 downto 0) := x"26";
constant BCS : std_logic_vector (7 downto 0) := x"27";
constant BCC : std_logic_vector (7 downto 0) := x"28";

entity control_unit is
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
	 Bus1_Sel: out std_logic_vector(1 downto 0)
	 );
	 
	 
architecture control_unit is
begin
   
	type state_type is
		(S_FETCH_0, S_FETCH_1, S_FETCH_2,
		S_DECODE_3,
		S_LDA_IMM_4, S_LDA_IMM_5, S_LDA_IMM_6,
		S_LDA_DIR_4, S_LDA_DIR_5, S_LDA_DIR_6, S_LDA_DIR_7,
		S_STA_DIR_4, S_STA_DIR_5, S_STA_DIR_6, S_STA_DIR_7, S_STA_DIR_8,
		S_ADD_AB_4,
		S_BRA_4, S_BRA_5, S_BRA_6,
		S_BEQ_4, S_BEQ_5, S_BEQ_6, S_BEQ_7);

	signal current_state, next_state : state_type;

	STATE_MEMORY : process (Clock, Reset)
	begin
		if (Reset = ’0’) then
			current_state <= S_FETCH_0;
		elsif (clock’event and clock = ’1’) then
			current_state <= next_state;
		end if;
	end process;

	NEXT_STATE_LOGIC : process (current_state, IR, CCR_Result)
	begin
		if (current_state = S_FETCH_0) then
			next_state <= S_FETCH_1;
		elsif (current_state = S_FETCH_1) then
			next_state <= S_FETCH_2;
		elsif (current_state = S_FETCH_2) then
			next_state <= S_DECODE_3;
		elsif (current_state = S_DECODE_3) then
		-- select execution path
			if (IR = LDA_IMM) then -- Load A Immediate
				next_state <= S_LDA_IMM_4;
			elsif (IR = LDA_DIR) then -- Load A Direct
				next_state <= S_LDA_DIR_4;
			elsif (IR = STA_DIR) then -- Store A Direct
				next_state <= S_STA_DIR_4;
			elsif (IR = ADD_AB) then -- Add A and B
				next_state <= S_ADD_AB_4;
			elsif (IR = SUB_AB) then -- Sub A and B
				next_state <= S_SUB_AB_4;
			elsif (IR = AND_AB) then --  A AND B
				next_state <= S_AND_AB_4;
			elsif (IR = OR_AB) then --  A OR B
				next_state <= S_OR_AB_4;
			elsif (IR = INC_A) then --  A + 1
				next_state <= S_INC_A_4;
			elsif (IR = DEC_A) then --  A -1
				next_state <= S_DEC_A_4;
			elsif (IR = INC_B) then --  B + 1
				next_state <= S_INC_B_4;
			elsif (IR = DEC_B) then --  B -1
				next_state <= S_DEC_B_4;
			elsif (IR = BRA) then -- Branch Always
				next_state <= S_BRA_4;
			elsif (IR=BEQ and CCR_Result(2)=’1’) then -- BEQ and Z=1
				next_state <= S_BEQ_4;
			elsif (IR=BEQ and CCR_Result(2)=’0’) then -- BEQ and Z=0
				next_state <= S_BEQ_7;
			elsif (IR=BMI and CCR_Result(1)=’1’) then -- BMI and N=1
				next_state <= S_BMI_4;
			elsif (IR=BEQ and CCR_Result(1)=’0’) then -- BMI and N=0
				next_state <= S_BMI_7;
			elsif (IR=BPL and CCR_Result(1)=’0’) then -- BPL and N=0
				next_state <= S_BPL_4;
			elsif (IR=BEQ and CCR_Result(1)=’0’) then -- BPL and N=1
				next_state <= S_BPL_7;
			elsif (IR=BNE and CCR_Result(2)=’0’) then -- BNE and N=0
				next_state <= S_BNE_4;
			elsif (IR=BEQ and CCR_Result(2)=’1’) then -- BNE and N=1
				next_state <= S_BNE_7;
			elsif (IR=BVS and CCR_Result(3)=’1’) then -- BVS and V=1
				next_state <= S_BVS_4;
			elsif (IR=BVS and CCR_Result(3)=’0’) then -- BVS and V=0
				next_state <= S_BVS_7;
			elsif (IR=BVC and CCR_Result(3)=’0’) then -- BVC and V=0
				next_state <= S_BVC_4;
			elsif (IR=BVC and CCR_Result(3)=’1’) then -- BVC and V=1
				next_state <= S_BVC_7;
			elsif (IR=BCS and CCR_Result(4)=’1’) then -- BCS and C=1
				next_state <= S_BCS_4;
			elsif (IR=BCS and CCR_Result(4)=’0’) then -- BCS and C=0
				next_state <= S_BCS_7;
			elsif (IR=BCC and CCR_Result(4)=’0’) then -- BCC and C=0
				next_state <= S_BCC_4;
			elsif (IR=BCC and CCR_Result(4)=’1’) then -- BCC and C=1
				next_state <= S_BCC_7;
			
			else
				next_state <= S_FETCH_0;
			end if;
		elsif(current_state=S_LDA_IMM_4) then
			next_state<=S_LDA_IMM_5;
		elsif(current_state=S_LDA_IMM_5) then
			next_state<=S_LDA_IMM_6;
		elsif(current_state=S_LDA_IMM_6) then
			next_state<=S_FETCH_0;
		elsif(current_state=S_LDA_DIR_4) then
			next_state<=S_LDA_DIR_5;
		elsif(current_state=S_LDA_DIR_5) then
			next_state<=S_LDA_DIR_6;
		elsif(current_state=S_LDA_DIR_6) then
			next_state<=S_LDA_DIR_7;
		elsif(current_state=S_LDA_DIR_7) then
			next_state<=S_LDA_DIR_8;
		elsif(current_state=S_LDA_DIR_8) then
			next_state<=S_FETCH_0;
		elsif(current_state=S_ADD_AB_4) then
			next_state<=S_FETCH_0;
		elsif(current_state=S_SUB_AB_4) then
			next_state<=S_FETCH_0;
		elsif(current_state=S_AND_AB_4) then
			next_state<=S_FETCH_0;
		elsif(current_state=S_OR_AB_4) then
			next_state<=S_FETCH_0;
		elsif(current_state=S_INC_A_4) then
			next_state<=S_FETCH_0;
		elsif(current_state=S_DEC_A_4) then
			next_state<=S_FETCH_0;
		elsif(current_state=S_INC_B_4) then
			next_state<=S_FETCH_0;
		elsif(current_state=S_DEC_B_4) then
			next_state<=S_FETCH_0;

	   elsif(current_state=S_AND_AB_4) then
			next_state<=S_FETCH_0;
	   elsif(current_state=S_OR_AB_4) then
			next_state<=S_FETCH_0;
		elsif(current_state=S_INC_A_4) then
			next_state<=S_FETCH_0;
		elsif(current_state=S_DEC_A_4) then
			next_state<=S_FETCH_0;
		elsif(current_state=S_BEQ_6) then
			next_state<=S_FETCH_0;
		elsif(current_state=S_BEQ_7) then
			next_state<=S_FETCH_0;
		elsif(current_state=S_BMI_6) then
			next_state<=S_FETCH_0;
		elsif(current_state=S_BMI_7) then
			next_state<=S_FETCH_0;
		elsif(current_state=S_BPL_6) then
			next_state<=S_FETCH_0;
		elsif(current_state=S_BPL_7) then
			next_state<=S_FETCH_0;
		elsif(current_state=S_BNE_6) then
			next_state<=S_FETCH_0;
		elsif(current_state=S_BNE_7) then
			next_state<=S_FETCH_0;
		elsif(current_state=S_BVS_6) then
			next_state<=S_FETCH_0;
		elsif(current_state=S_BVS_7) then
			next_state<=S_FETCH_0;
		elsif(current_state=S_BVC_6) then
			next_state<=S_FETCH_0;
		elsif(current_state=S_BVC_7) then
			next_state<=S_FETCH_0;
		elsif(current_state=S_BCS_6) then
			next_state<=S_FETCH_0;
		elsif(current_state=S_BCS_7) then
			next_state<=S_FETCH_0;
		elsif(current_state=S_BCC_6) then
			next_state<=S_FETCH_0;
		elsif(current_state=S_BCC_7) then
			next_state<=S_FETCH_0;
		
		
		
			
		
		
end process;


OUTPUT_LOGIC : process (current_state)
begin
case(current_state) is
	when S_FETCH_0 => -- Put PC onto MAR to read Opcode
		IR_Load <= ’0’;
		MAR_Load <= ’1’;
		PC_Load <= ’0’;
		PC_Inc <= ’0’;
		A_Load <= ’0’;
		B_Load <= ’0’;
		ALU_Sel <= "1111";
		CCR_Load <= ’0’;
		Bus1_Sel <= "00"; -- "00"=PC, "01"=A, "10"=B
		Bus2_Sel <= "01"; -- "00"=ALU_Result, "01"=Bus1, "10"=from_memory
		write <= ’0’;
	when S_FETCH_1 => -- Increment PC
		IR_Load <= ’0’;
		MAR_Load <= ’0’;
		PC_Load <= ’0’;
		PC_Inc <= ’1’;
		A_Load <= ’0’;
		B_Load <= ’0’;
		ALU_Sel <= "1111";
		CCR_Load <= ’0’;
		Bus1_Sel <= "00"; -- "00"=PC, "01"=A, "10"=B
		Bus2_Sel <= "00"; -- "00"=ALU, "01"=Bus1, "10"=from_memory
		write <== ’0’;
		when S_FETCH_2 => -- Instruction Opcode to IR
		IR_Load <= ’1’;
		MAR_Load <= ’0’;
		PC_Load <= ’0’;
		PC_Inc <= ’0’;
		A_Load <= ’0’;
		B_Load <= ’0’;
		ALU_Sel <= "1111";
		CCR_Load <= ’0’;
		Bus1_Sel <= "00"; -- "00"=PC, "01"=A, "10"=B
		Bus2_Sel <= "10"; -- "00"=ALU, "01"=Bus1, "10"=from_memory
		write <== ’0’;

--LDA_IMM
	when S_LDA_IMM_4 => 
		IR_Load <= ’0’;
		MAR_Load <= ’1’;
		PC_Load <= ’0’;
		PC_Inc <= ’0’;
		A_Load <= ’0’;
		B_Load <= ’0’;
		ALU_Sel <= "1111";
		CCR_Load <= ’0’;
		Bus1_Sel <= "00"; -- "00"=PC, "01"=A, "10"=B
		Bus2_Sel <= "01"; -- "00"=ALU, "01"=Bus1, "10"=from_memory
		write <== ’0’;
	when S_LDA_IMM_5 => 
		IR_Load <= ’0’;
		MAR_Load <= ’0’;
		PC_Load <= ’0’;
		PC_Inc <= ’1’;
		A_Load <= ’0’;
		B_Load <= ’0’;
		ALU_Sel <= "1111";
		CCR_Load <= ’0’;
		Bus1_Sel <= "00"; -- "00"=PC, "01"=A, "10"=B
		Bus2_Sel <= "00"; -- "00"=ALU, "01"=Bus1, "10"=from_memory
		write <== ’0’;
		when S_LDA_IMM_6 => 
		IR_Load <= ’0’;
		MAR_Load <= ’0’;
		PC_Load <= ’0’;
		PC_Inc <= ’0’;
		A_Load <= ’1;
		B_Load <= ’0’;
		ALU_Sel <= "1111";
		CCR_Load <= ’0’;
		Bus1_Sel <= "00"; -- "00"=PC, "01"=A, "10"=B
		Bus2_Sel <= "10"; -- "00"=ALU, "01"=Bus1, "10"=from_memory
		next
		write <== ’0’;

--LDA_DIR
	when S_LDA_DIR_4 => 
		IR_Load <= ’0’;
		MAR_Load <= ’1’;
		PC_Load <= ’0’;
		PC_Inc <= ’0’;
		A_Load <= ’0;
		B_Load <= ’0’;
		ALU_Sel <= "1111";
		CCR_Load <= ’0’;
		Bus1_Sel <= "00"; -- "00"=PC, "01"=A, "10"=B
		Bus2_Sel <= "01"; -- "00"=ALU, "01"=Bus1, "10"=from_memory
		next
		write <== ’0’;
	when S_LDA_DIR_5 => 
		IR_Load <= ’0’;
		MAR_Load <= ’0’;
		PC_Load <= ’0’;
		PC_Inc <= ’1’;
		A_Load <= ’0;
		B_Load <= ’0’;
		ALU_Sel <= "1111";
		CCR_Load <= ’0’;
		Bus1_Sel <= "00"; -- "00"=PC, "01"=A, "10"=B
		Bus2_Sel <= "01"; -- "00"=ALU, "01"=Bus1, "10"=from_memory
		next
		write <== ’0’;
	when S_LDA_DIR_6 => 
		IR_Load <= ’0’;
		MAR_Load <= ’1’;
		PC_Load <= ’0’;
		PC_Inc <= ’0’;
		A_Load <= ’0;
		B_Load <= ’0’;
		ALU_Sel <= "1111";
		CCR_Load <= ’0’;
		Bus1_Sel <= "00"; -- "00"=PC, "01"=A, "10"=B
		Bus2_Sel <= "10"; -- "00"=ALU, "01"=Bus1, "10"=from_memory
		next
		write <== ’0’;
	when S_LDA_DIR_7 => 
		IR_Load <= ’0’;
		MAR_Load <= ’0’;
		PC_Load <= ’0’;
		PC_Inc <= ’0’;
		A_Load <= ’0;
		B_Load <= ’0’;
		ALU_Sel <= "1111";
		CCR_Load <= ’0’;
		Bus1_Sel <= "00"; -- "00"=PC, "01"=A, "10"=B
		Bus2_Sel <= "00"; -- "00"=ALU, "01"=Bus1, "10"=from_memory
		next
		write <== ’0’;
	when S_LDA_DIR_8 => 
		IR_Load <= ’0’;
		MAR_Load <= ’0’;
		PC_Load <= ’0’;
		PC_Inc <= ’0’;
		A_Load <= ’1';
		B_Load <= ’0’;
		ALU_Sel <= "1111";
		CCR_Load <= ’0’;
		Bus1_Sel <= "00"; -- "00"=PC, "01"=A, "10"=B
		Bus2_Sel <= "10"; -- "00"=ALU, "01"=Bus1, "10"=from_memory
		next
		write <== ’0’;

--STA_DIR
	when STA_DIR_4 => 
		IR_Load <= ’0’;
		MAR_Load <= ’1’;
		PC_Load <= ’0’;
		PC_Inc <= ’0’;
		A_Load <= ’0;
		B_Load <= ’0’;
		ALU_Sel <= "1111";
		CCR_Load <= ’0’;
		Bus1_Sel <= "00"; -- "00"=PC, "01"=A, "10"=B
		Bus2_Sel <= "01"; -- "00"=ALU, "01"=Bus1, "10"=from_memory
		next
		write <== ’0’;
	when STA_DIR_5 => 
		IR_Load <= ’0’;
		MAR_Load <= ’0’;
		PC_Load <= ’0’;
		PC_Inc <= ’1’;
		A_Load <= ’0;
		B_Load <= ’0’;
		ALU_Sel <= "1111";
		CCR_Load <= ’0’;
		Bus1_Sel <= "00"; -- "00"=PC, "01"=A, "10"=B
		Bus2_Sel <= "00"; -- "00"=ALU, "01"=Bus1, "10"=from_memory
		next
		write <== ’0’;
	when STA_DIR_6 => 
		IR_Load <= ’0’;
		MAR_Load <= ’1’;
		PC_Load <= ’0’;
		PC_Inc <= ’0’;
		A_Load <= ’0;
		B_Load <= ’0’;
		ALU_Sel <= "1111";
		CCR_Load <= ’0’;
		Bus1_Sel <= "00"; -- "00"=PC, "01"=A, "10"=B
		Bus2_Sel <= "10"; -- "00"=ALU, "01"=Bus1, "10"=from_memory
		next
		write <== ’0’;
	when STA_DIR_7 => 
		IR_Load <= ’0’;
		MAR_Load <= ’0’;
		PC_Load <= ’0’;
		PC_Inc <= ’0’;
		A_Load <= ’0;
		B_Load <= ’0’;
		ALU_Sel <= "1111";
		CCR_Load <= ’0’;
		Bus1_Sel <= "01"; -- "00"=PC, "01"=A, "10"=B
		Bus2_Sel <= "01"; -- "00"=ALU, "01"=Bus1, "10"=from_memory
		next
		write <== ’1’;

--ADD_AB
	when S_ADD_AB_4 => 
		IR_Load <= ’0’;
		MAR_Load <= ’1’;
		PC_Load <= ’0’;
		PC_Inc <= ’0’;
		A_Load <= ’0;
		B_Load <= ’0’;
		ALU_Sel <= "0000";
		CCR_Load <= ’1’;
		Bus1_Sel <= "01"; -- "00"=PC, "01"=A, "10"=B
		Bus2_Sel <= "00"; -- "00"=ALU, "01"=Bus1, "10"=from_memory
		next
		write <== ’0’;

--SUB_AB
	when S_SUB_AB_4 => 
		IR_Load <= ’0’;
		MAR_Load <= ’1’;
		PC_Load <= ’0’;
		PC_Inc <= ’0’;
		A_Load <= ’0;
		B_Load <= ’0’;
		ALU_Sel <= "0001";
		CCR_Load <= ’1’;
		Bus1_Sel <= "01"; -- "00"=PC, "01"=A, "10"=B
		Bus2_Sel <= "00"; -- "00"=ALU, "01"=Bus1, "10"=from_memory
		next
		write <== ’0’;


--AND_AB
	when S_AND_AB_4 => 
		IR_Load <= ’0’;
		MAR_Load <= ’1’;
		PC_Load <= ’0’;
		PC_Inc <= ’0’;
		A_Load <= ’0;
		B_Load <= ’0’;
		ALU_Sel <= "0010";
		CCR_Load <= ’1’;
		Bus1_Sel <= "01"; -- "00"=PC, "01"=A, "10"=B
		Bus2_Sel <= "00"; -- "00"=ALU, "01"=Bus1, "10"=from_memory
		next
		write <== ’0’;


--OR_AB
	when S_OR_AB_4 => 
		IR_Load <= ’0’;
		MAR_Load <= ’1’;
		PC_Load <= ’0’;
		PC_Inc <= ’0’;
		A_Load <= ’0;
		B_Load <= ’0’;
		ALU_Sel <= "0011";
		CCR_Load <= ’1’;
		Bus1_Sel <= "01"; -- "00"=PC, "01"=A, "10"=B
		Bus2_Sel <= "00"; -- "00"=ALU, "01"=Bus1, "10"=from_memory
		next
		write <== ’0’;
--INC_A
	when S_INC_A_4 => 
		IR_Load <= ’0’;
		MAR_Load <= ’1’;
		PC_Load <= ’0’;
		PC_Inc <= ’0’;
		A_Load <= ’0;
		B_Load <= ’0’;
		ALU_Sel <= "0101";
		CCR_Load <= ’1’;
		Bus1_Sel <= "01"; -- "00"=PC, "01"=A, "10"=B
		Bus2_Sel <= "00"; -- "00"=ALU, "01"=Bus1, "10"=from_memory
		next
		write <== ’0’;

		
--DEC_A
	when S_DEC_A_4 => 
		IR_Load <= ’0’;
		MAR_Load <= ’1’;
		PC_Load <= ’0’;
		PC_Inc <= ’0’;
		A_Load <= ’0;
		B_Load <= ’0’;
		ALU_Sel <= "0110";
		CCR_Load <= ’1’;
		Bus1_Sel <= "01"; -- "00"=PC, "01"=A, "10"=B
		Bus2_Sel <= "00"; -- "00"=ALU, "01"=Bus1, "10"=from_memory
		next
		write <== ’0’;
--BRA
	when S_BRA_4 => 
		IR_Load <= ’0’;
		MAR_Load <= ’1’;
		PC_Load <= ’0’;
		PC_Inc <= ’0’;
		A_Load <= ’0;
		B_Load <= ’0’;
		ALU_Sel <= "1111";
		CCR_Load <= ’0’;
		Bus1_Sel <= "00"; -- "00"=PC, "01"=A, "10"=B
		Bus2_Sel <= "01"; -- "00"=ALU, "01"=Bus1, "10"=from_memory
		next
		write <== ’0’;
	when S_BRA_6 => 
		IR_Load <= ’0’;
		MAR_Load <= ’0’;
		PC_Load <= ’1’;
		PC_Inc <= ’0’;
		A_Load <= ’0;
		B_Load <= ’0’;
		ALU_Sel <= "1111";
		CCR_Load <= ’0’;
		Bus1_Sel <= "00"; -- "00"=PC, "01"=A, "10"=B
		Bus2_Sel <= "10"; -- "00"=ALU, "01"=Bus1, "10"=from_memory
		next
		write <== ’0’;
--S_BEQ
	when S_BEQ_4 => 
		IR_Load <= ’0’;
		MAR_Load <= ’1’;
		PC_Load <= ’0’;
		PC_Inc <= ’0’;
		A_Load <= ’0;
		B_Load <= ’0’;
		ALU_Sel <= "1111";
		CCR_Load <= ’0’;
		Bus1_Sel <= "00"; -- "00"=PC, "01"=A, "10"=B
		Bus2_Sel <= "01"; -- "00"=ALU, "01"=Bus1, "10"=from_memory
		next
		write <== ’0’;
	when S_BEQ_6 => 
		IR_Load <= ’0’;
		MAR_Load <= ’0’;
		PC_Load <= ’1’;
		PC_Inc <= ’0’;
		A_Load <= ’0;
		B_Load <= ’0’;
		ALU_Sel <= "1111";
		CCR_Load <= ’0’;
		Bus1_Sel <= "00"; -- "00"=PC, "01"=A, "10"=B
		Bus2_Sel <= "10"; -- "00"=ALU, "01"=Bus1, "10"=from_memory
		next
		write <== ’0’;	
	when S_BEQ_7 => 
		IR_Load <= ’0’;
		MAR_Load <= ’0’;
		PC_Load <= ’0’;
		PC_Inc <= ’1’;
		A_Load <= ’0;
		B_Load <= ’0’;
		ALU_Sel <= "1111";
		CCR_Load <= ’0’;
		Bus1_Sel <= "00"; -- "00"=PC, "01"=A, "10"=B
		Bus2_Sel <= "01"; -- "00"=ALU, "01"=Bus1, "10"=from_memory
		next
		write <== ’0’;
	
	
--BMI

	when S_BMI_4 => 
		IR_Load <= ’0’;
		MAR_Load <= ’1’;
		PC_Load <= ’0’;
		PC_Inc <= ’0’;
		A_Load <= ’0;
		B_Load <= ’0’;
		ALU_Sel <= "1111";
		CCR_Load <= ’0’;
		Bus1_Sel <= "00"; -- "00"=PC, "01"=A, "10"=B
		Bus2_Sel <= "01"; -- "00"=ALU, "01"=Bus1, "10"=from_memory
		next
		write <== ’0’;
	when S_BMI_6 => 
		IR_Load <= ’0’;
		MAR_Load <= ’0’;
		PC_Load <= ’1’;
		PC_Inc <= ’0’;
		A_Load <= ’0;
		B_Load <= ’0’;
		ALU_Sel <= "1111";
		CCR_Load <= ’0’;
		Bus1_Sel <= "00"; -- "00"=PC, "01"=A, "10"=B
		Bus2_Sel <= "10"; -- "00"=ALU, "01"=Bus1, "10"=from_memory
		next
		write <== ’0’;	
	when S_BMI_7 => 
		IR_Load <= ’0’;
		MAR_Load <= ’0’;
		PC_Load <= ’0’;
		PC_Inc <= ’1’;
		A_Load <= ’0;
		B_Load <= ’0’;
		ALU_Sel <= "1111";
		CCR_Load <= ’0’;
		Bus1_Sel <= "00"; -- "00"=PC, "01"=A, "10"=B
		Bus2_Sel <= "01"; -- "00"=ALU, "01"=Bus1, "10"=from_memory
		next
		write <== ’0’;
--BPL

	when S_BPL_4 => 
		IR_Load <= ’0’;
		MAR_Load <= ’1’;
		PC_Load <= ’0’;
		PC_Inc <= ’0’;
		A_Load <= ’0;
		B_Load <= ’0’;
		ALU_Sel <= "1111";
		CCR_Load <= ’0’;
		Bus1_Sel <= "00"; -- "00"=PC, "01"=A, "10"=B
		Bus2_Sel <= "01"; -- "00"=ALU, "01"=Bus1, "10"=from_memory
		next
		write <== ’0’;
	when S_BPL_6 => 
		IR_Load <= ’0’;
		MAR_Load <= ’0’;
		PC_Load <= ’1’;
		PC_Inc <= ’0’;
		A_Load <= ’0;
		B_Load <= ’0’;
		ALU_Sel <= "1111";
		CCR_Load <= ’0’;
		Bus1_Sel <= "00"; -- "00"=PC, "01"=A, "10"=B
		Bus2_Sel <= "10"; -- "00"=ALU, "01"=Bus1, "10"=from_memory
		next
		write <== ’0’;	
	when S_BPL_7 => 
		IR_Load <= ’0’;
		MAR_Load <= ’0’;
		PC_Load <= ’0’;
		PC_Inc <= ’1’;
		A_Load <= ’0;
		B_Load <= ’0’;
		ALU_Sel <= "1111";
		CCR_Load <= ’0’;
		Bus1_Sel <= "00"; -- "00"=PC, "01"=A, "10"=B
		Bus2_Sel <= "01"; -- "00"=ALU, "01"=Bus1, "10"=from_memory
		next
		write <== ’0’;
		
--BNE

	when S_BNE_4 => 
		IR_Load <= ’0’;
		MAR_Load <= ’1’;
		PC_Load <= ’0’;
		PC_Inc <= ’0’;
		A_Load <= ’0;
		B_Load <= ’0’;
		ALU_Sel <= "1111";
		CCR_Load <= ’0’;
		Bus1_Sel <= "00"; -- "00"=PC, "01"=A, "10"=B
		Bus2_Sel <= "01"; -- "00"=ALU, "01"=Bus1, "10"=from_memory
		next
		write <== ’0’;
	when S_BNE_6 => 
		IR_Load <= ’0’;
		MAR_Load <= ’0’;
		PC_Load <= ’1’;
		PC_Inc <= ’0’;
		A_Load <= ’0;
		B_Load <= ’0’;
		ALU_Sel <= "1111";
		CCR_Load <= ’0’;
		Bus1_Sel <= "00"; -- "00"=PC, "01"=A, "10"=B
		Bus2_Sel <= "10"; -- "00"=ALU, "01"=Bus1, "10"=from_memory
		next
		write <== ’0’;	
	when S_BNE_7 => 
		IR_Load <= ’0’;
		MAR_Load <= ’0’;
		PC_Load <= ’0’;
		PC_Inc <= ’1’;
		A_Load <= ’0;
		B_Load <= ’0’;
		ALU_Sel <= "1111";
		CCR_Load <= ’0’;
		Bus1_Sel <= "00"; -- "00"=PC, "01"=A, "10"=B
		Bus2_Sel <= "01"; -- "00"=ALU, "01"=Bus1, "10"=from_memory
		next
		write <== ’0’;

--BVS

	when S_BVS_4 => 
		IR_Load <= ’0’;
		MAR_Load <= ’1’;
		PC_Load <= ’0’;
		PC_Inc <= ’0’;
		A_Load <= ’0;
		B_Load <= ’0’;
		ALU_Sel <= "1111";
		CCR_Load <= ’0’;
		Bus1_Sel <= "00"; -- "00"=PC, "01"=A, "10"=B
		Bus2_Sel <= "01"; -- "00"=ALU, "01"=Bus1, "10"=from_memory
		next
		write <== ’0’;
	when S_BVS_6 => 
		IR_Load <= ’0’;
		MAR_Load <= ’0’;
		PC_Load <= ’1’;
		PC_Inc <= ’0’;
		A_Load <= ’0;
		B_Load <= ’0’;
		ALU_Sel <= "1111";
		CCR_Load <= ’0’;
		Bus1_Sel <= "00"; -- "00"=PC, "01"=A, "10"=B
		Bus2_Sel <= "10"; -- "00"=ALU, "01"=Bus1, "10"=from_memory
		next
		write <== ’0’;	
	when S_BVS_7 => 
		IR_Load <= ’0’;
		MAR_Load <= ’0’;
		PC_Load <= ’0’;
		PC_Inc <= ’1’;
		A_Load <= ’0;
		B_Load <= ’0’;
		ALU_Sel <= "1111";
		CCR_Load <= ’0’;
		Bus1_Sel <= "00"; -- "00"=PC, "01"=A, "10"=B
		Bus2_Sel <= "01"; -- "00"=ALU, "01"=Bus1, "10"=from_memory
		next
		write <== ’0’;

--BVC

	when S_BVC_4 => 
		IR_Load <= ’0’;
		MAR_Load <= ’1’;
		PC_Load <= ’0’;
		PC_Inc <= ’0’;
		A_Load <= ’0;
		B_Load <= ’0’;
		ALU_Sel <= "1111";
		CCR_Load <= ’0’;
		Bus1_Sel <= "00"; -- "00"=PC, "01"=A, "10"=B
		Bus2_Sel <= "01"; -- "00"=ALU, "01"=Bus1, "10"=from_memory
		next
		write <== ’0’;
	when S_BVC_6 => 
		IR_Load <= ’0’;
		MAR_Load <= ’0’;
		PC_Load <= ’1’;
		PC_Inc <= ’0’;
		A_Load <= ’0;
		B_Load <= ’0’;
		ALU_Sel <= "1111";
		CCR_Load <= ’0’;
		Bus1_Sel <= "00"; -- "00"=PC, "01"=A, "10"=B
		Bus2_Sel <= "10"; -- "00"=ALU, "01"=Bus1, "10"=from_memory
		next
		write <== ’0’;	
	when S_BVC_7 => 
		IR_Load <= ’0’;
		MAR_Load <= ’0’;
		PC_Load <= ’0’;
		PC_Inc <= ’1’;
		A_Load <= ’0;
		B_Load <= ’0’;
		ALU_Sel <= "1111";
		CCR_Load <= ’0’;
		Bus1_Sel <= "00"; -- "00"=PC, "01"=A, "10"=B
		Bus2_Sel <= "01"; -- "00"=ALU, "01"=Bus1, "10"=from_memory
		next
		write <== ’0’;
		

--BCS

	when S_BCS_4 => 
		IR_Load <= ’0’;
		MAR_Load <= ’1’;
		PC_Load <= ’0’;
		PC_Inc <= ’0’;
		A_Load <= ’0;
		B_Load <= ’0’;
		ALU_Sel <= "1111";
		CCR_Load <= ’0’;
		Bus1_Sel <= "00"; -- "00"=PC, "01"=A, "10"=B
		Bus2_Sel <= "01"; -- "00"=ALU, "01"=Bus1, "10"=from_memory
		next
		write <== ’0’;
	when S_BCS_6 => 
		IR_Load <= ’0’;
		MAR_Load <= ’0’;
		PC_Load <= ’1’;
		PC_Inc <= ’0’;
		A_Load <= ’0;
		B_Load <= ’0’;
		ALU_Sel <= "1111";
		CCR_Load <= ’0’;
		Bus1_Sel <= "00"; -- "00"=PC, "01"=A, "10"=B
		Bus2_Sel <= "10"; -- "00"=ALU, "01"=Bus1, "10"=from_memory
		next
		write <== ’0’;	
	when S_BCS_7 => 
		IR_Load <= ’0’;
		MAR_Load <= ’0’;
		PC_Load <= ’0’;
		PC_Inc <= ’1’;
		A_Load <= ’0;
		B_Load <= ’0’;
		ALU_Sel <= "1111";
		CCR_Load <= ’0’;
		Bus1_Sel <= "00"; -- "00"=PC, "01"=A, "10"=B
		Bus2_Sel <= "01"; -- "00"=ALU, "01"=Bus1, "10"=from_memory
		next
		write <== ’0’;	

--BCC

	when S_BCC_4 => 
		IR_Load <= ’0’;
		MAR_Load <= ’1’;
		PC_Load <= ’0’;
		PC_Inc <= ’0’;
		A_Load <= ’0;
		B_Load <= ’0’;
		ALU_Sel <= "1111";
		CCR_Load <= ’0’;
		Bus1_Sel <= "00"; -- "00"=PC, "01"=A, "10"=B
		Bus2_Sel <= "01"; -- "00"=ALU, "01"=Bus1, "10"=from_memory
		next
		write <== ’0’;
	when S_BCC_6 => 
		IR_Load <= ’0’;
		MAR_Load <= ’0’;
		PC_Load <= ’1’;
		PC_Inc <= ’0’;
		A_Load <= ’0;
		B_Load <= ’0’;
		ALU_Sel <= "1111";
		CCR_Load <= ’0’;
		Bus1_Sel <= "00"; -- "00"=PC, "01"=A, "10"=B
		Bus2_Sel <= "10"; -- "00"=ALU, "01"=Bus1, "10"=from_memory
		next
		write <== ’0’;	
	when S_BCC_7 => 
		IR_Load <= ’0’;
		MAR_Load <= ’0’;
		PC_Load <= ’0’;
		PC_Inc <= ’1’;
		A_Load <= ’0;
		B_Load <= ’0’;
		ALU_Sel <= "1111";
		CCR_Load <= ’0’;
		Bus1_Sel <= "00"; -- "00"=PC, "01"=A, "10"=B
		Bus2_Sel <= "01"; -- "00"=ALU, "01"=Bus1, "10"=from_memory
		next
		write <== ’0’;
		

--INC_B
	when S_INC_B_4 => 
		IR_Load <= ’0’;
		MAR_Load <= ’1’;
		PC_Load <= ’0’;
		PC_Inc <= ’0’;
		A_Load <= ’0;
		B_Load <= ’0’;
		ALU_Sel <= "1000";
		CCR_Load <= ’1’;
		Bus1_Sel <= "01"; -- "00"=PC, "01"=A, "10"=B
		Bus2_Sel <= "00"; -- "00"=ALU, "01"=Bus1, "10"=from_memory
		next
		write <== ’0’;
		
--DEC_B
	when S_DEC_B_4 => 
		IR_Load <= ’0’;
		MAR_Load <= ’1’;
		PC_Load <= ’0’;
		PC_Inc <= ’0’;
		A_Load <= ’0;
		B_Load <= ’0’;
		ALU_Sel <= "1001";
		CCR_Load <= ’1’;
		Bus1_Sel <= "01"; -- "00"=PC, "01"=A, "10"=B
		Bus2_Sel <= "00"; -- "00"=ALU, "01"=Bus1, "10"=from_memory
		next
		write <== ’0’;


		

	


























end case;
end process;

