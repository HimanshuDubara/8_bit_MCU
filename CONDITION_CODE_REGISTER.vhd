library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.NUMERIC_STD.ALL;


entity CONDITION_CODE_REGISTER is
port( Clock: in std_logic;
		Reset: in std_logic_vector;
		NZVC: in std_logic_vector(3 downto 0);
		CCR_Result: out std_logic);
end CONDITION_CODE_REGISTER;


architecture ccr of CONDITION_CODE_REGISTER is
begin
CONDITION_CODE_REGISTERE : process (Clock, Reset)
begin
if (Reset = '0') then
CCR_Result <= x"0";
elsif (Clock'event and Clock = '1') then
	if (CCR_Load = '1') then
	CCR_Result <= NZVC;
	end if;
end if;
end process;
end ccr;