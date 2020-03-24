library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.ALL;

-- data memory handling, w stands for write
entity rw is
port( w: in std_logic;
      address: in std_logic_vector(7 downto 0);
		clock: in std_logic;
		data_in: in std_logic_vector(7 downto 0);
		data_out: out std_logic_vector(7 downto 0)
		);
end rw;

architecture rw1 of rw is
type rw_type is array (128 to 223) of std_logic_vector(7 downto 0);
signal RWe : rw_type;
signal EN: std_logic;

begin

enable : process (address)
begin
if ( (to_integer(unsigned(address)) >=128) and
(to_integer(unsigned(address)) <= 223)) then
EN <= '1';
else
EN <= '0';
end if;
end process;

memory : process (clock)
begin
if (clock'event and clock='1') then
if (EN='1' and w='1') then
RWe(to_integer(unsigned(address))) <= data_in;
elsif (EN='1' and w='0') then
data_out <= RWe(to_integer(unsigned(address)));
end if;
end if;
end process;
end rw1;
		
		