library IEEE;
use IEEE.std_logic_1164.all;

entity MEMORY_REGISTER_ADDRESS is
port( BUS2: in std_logic_vector(7 downto 0);
      Clock: in std_logic;
		Reset: in std_logic;
		MAR_ Load: in std_logic;
		MAR: out std_logic_vector(7 downto 0));
end MEMORY_REGISTER_ADDRESS;

architecture MM1 of MEMORY_REGISTER_ADDRESS is
begin
MEMORY_ADDRESS_REGISTER : process (Clock, Reset)
begin
if (Reset = ’0’) then
MAR <= x"00";
elsif (Clock’event and Clock = ’1’) then
if (MAR_Load = ’1’) then
MAR <= Bus2;
end if;
end if;
end process;
end MM1;