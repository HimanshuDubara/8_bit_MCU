library IEEE;
use IEEE.std_logic_1164.all;

entity PROGRAM_COUNTER is 
port( BUS2: in std_logic_vector(7 downto 0);
		Clock: in std_logic;
		Reset: in std_logic;
		PC_Inc: in std_logic;
		PC: in std_logic_vector(7 downto 0));
end PROGRAM_COUNTER;
		
architecture PROGRAM_COUNTER1 of PROGRAM_COUNTER is
signal PC_uns: std_logic_vector(7 downto 0)

begin
PROGRAM_COUNTER : process (Clock, Reset)
begin
if (Reset = ’0’) then
PC_uns <= x"00";
elsif (Clock’event and Clock ¼ ’1’) then
if (PC_Load = ’1’) then
PC_uns <= unsigned(Bus2);
elsif (PC_Inc = ’1’) then
PC_uns <= PC_uns + 1;
end if;
end if;
end process;

PC <= std_logic_vector(PC_uns);
end PROGRAM_COUNTER1;		
		