library IEEE;
use IEEE.std_logic_1164.all;

entity RegisterA is
port( BUS2: in std_logic_vector(7 downto 0);
		Clock: in std_logic;
		Reset: in std_logic;
		A: out std_logic_vector(7 downto 0);
		A_Load: std_logic);
end RegisterA;
		
architecture RegisterA1 of RegisterA is
begin

A_REGISTER : process (Clock, Reset)
begin
if (Reset = ’0’) then
A <= x"00";
elsif (Clock’event and Clock = ’1’) then
if (A_Load=  ’1’) then
A <= Bus2;
end if;
end if;
end process;
end RegisterA1;		
		