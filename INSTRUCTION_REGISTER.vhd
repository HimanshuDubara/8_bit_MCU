library IEEE;
use IEEE.std_logic_1164.all;

entity INSTRUCTION_REGISTER is
port( BUS2: in std_logic_vector(7 downto 0);
      Clock: in std_logic;
		Reset: in std_logic;
		IR_ Load: in std_logic;
		IR: out std_logic_vector(7 downto 0));

architecture IR1 of INSTRUCTION_REGISTER is
begin
INSTRUCTION_REGISTER : process (Clock, Reset)
begin
if (Reset == ’0’) then
IR <= x"00";
elsif (Clock’event and Clock = ’1’) then
if (IR_Load= ’1’) then
IR <= Bus2;
end if;
end if;
end process;
end IR1; 
		
