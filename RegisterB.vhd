library IEEE;
use IEEE.std_logic_1164.all;

entity RegisterB is
port( BUS2: in std_logic_vector(7 downto 0);
		Clock: in std_logic;
		Reset: in std_logic;
		B: out std_logic_vector(7 downto 0);
		B_Load: std_logic);
end RegisterB;
		
architecture RegisterB1 of RegisterB is
begin

B_REGISTER : process (Clock, Reset)
begin
if (Reset = '0') then
B <= x"00";
elsif (Clock'event and Clock = '1') then
if (B_Load=  '1') then
B <= Bus2;
end if;
end if;
end process;
end RegisterB1;	