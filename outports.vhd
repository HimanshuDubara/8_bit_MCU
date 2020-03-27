library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.ALL;

entity outports is
port( 
		address: in std_logic_vector(7 downto 0);
      clock: in std_logic;
		data_in: in std_logic_vector(7 downto 0);
		w: in std_logic;
		reset: in std_logic;
         port_out_00: out std_logic_vector(7 downto 0);
        port_out_01: out std_logic_vector(7 downto 0);
        port_out_02: out std_logic_vector(7 downto 0);
        port_out_03: out std_logic_vector(7 downto 0);
        port_out_04: out std_logic_vector(7 downto 0);
        port_out_05: out std_logic_vector(7 downto 0);
        port_out_06: out std_logic_vector(7 downto 0);
        port_out_07: out std_logic_vector(7 downto 0);
        port_out_08: out std_logic_vector(7 downto 0);
        port_out_09: out std_logic_vector(7 downto 0);
        port_out_10: out std_logic_vector(7 downto 0);
        port_out_11: out std_logic_vector(7 downto 0);
        port_out_12: out std_logic_vector(7 downto 0);
        port_out_13: out std_logic_vector(7 downto 0);
        port_out_14: out std_logic_vector(7 downto 0);
        port_out_15: out std_logic_vector(7 downto 0) 
	);
end outports;
architecture outports1 of outports is
begin

-- port_out(0) description : ADDRESS x"E0"
U3 : process (clock, reset)
begin
if (reset = '0') then
port_out_00 <= x"00";
elsif (clock'event and clock='1') then
if (address = x"E0" and w = '1') then
port_out_00 <= data_in;
end if;
end if;
end process;

-- port_out(1) description : ADDRESS x"E1"
 process (clock, reset)
begin
if (reset = '0') then
port_out_01 <= x"00";
elsif (clock'event and clock='1') then
if (address = x"E1" and w = '1') then
port_out_01 <= data_in;
end if;
end if;
end process;

-- port_out(2) description : ADDRESS x"E2"
U34: process (clock, reset)
begin
if (reset = '0') then
port_out_02 <= x"00";
elsif (clock'event and clock='1') then
if (address = x"E2" and w = '1') then
port_out_02 <= data_in;
end if;
end if;
end process;

-- port_out(3) description : ADDRESS x"E3"
U38 : process (clock, reset)
begin
if (reset = '0') then
port_out_03 <= x"00";
elsif (clock'event and clock='1') then
if (address = x"E3" and w = '1') then
port_out_03 <= data_in;
end if;
end if;
end process;

-- port_out(4) description : ADDRESS x"E4"
U39 : process (clock, reset)
begin
if (reset = '0') then
port_out_04 <= x"00";
elsif (clock'event and clock='1') then
if (address = x"E4" and w = '1') then
port_out_04 <= data_in;
end if;
end if;
end process;

-- port_out(5) description : ADDRESS x"E5"
U30: process (clock, reset)
begin
if (reset = '0') then
port_out_05 <= x"00";
elsif (clock'event and clock='1') then
if (address = x"E5" and w = '1') then
port_out_05 <= data_in;
end if;
end if;
end process;

-- port_out(6) description : ADDRESS x"E6"
U36 : process (clock, reset)
begin
if (reset = '0') then
port_out_06 <= x"00";
elsif (clock'event and clock='1') then
if (address = x"E6" and w = '1') then
port_out_06 <= data_in;
end if;
end if;
end process;


-- port_out(7) description : ADDRESS x"E7"
U45 : process (clock, reset)
begin
if (reset = '0') then
port_out_07 <= x"00";
elsif (clock'event and clock='1') then
if (address = x"E7" and w = '1') then
port_out_07 <= data_in;
end if;
end if;
end process;

-- port_out(8) description : ADDRESS x"E8"
U56: process (clock, reset)
begin
if (reset = '0') then
port_out_08 <= x"00";
elsif (clock'event and clock='1') then
if (address = x"E8" and w = '1') then
port_out_08 <= data_in;
end if;
end if;
end process;

-- port_out(9) description : ADDRESS x"E9"
U67 : process (clock, reset)
begin
if (reset = '0') then
port_out_09 <= x"00";
elsif (clock'event and clock='1') then
if (address = x"E9" and w = '1') then
port_out_09 <= data_in;
end if;
end if;
end process;

-- port_out(10) description : ADDRESS x"E10"
U78 : process (clock, reset)
begin
if (reset = '0') then
port_out_10 <= x"00";
elsif (clock'event and clock='1') then
if (address = x"E10" and w = '1') then
port_out_10 <= data_in;
end if;
end if;
end process;

-- port_out(11) description : ADDRESS x"E11"
U89 : process (clock, reset)
begin
if (reset = '0') then
port_out_11 <= x"00";
elsif (clock'event and clock='1') then
if (address = x"E11" and w = '1') then
port_out_11 <= data_in;
end if;
end if;
end process;

-- port_out(12) description : ADDRESS x"E12"
U76 : process (clock, reset)
begin
if (reset = '0') then
port_out_12 <= x"00";
elsif (clock'event and clock='1') then
if (address = x"E12" and w = '1') then
port_out_12 <= data_in;
end if;
end if;
end process;

-- port_out(13) description : ADDRESS x"E13"
U90 : process (clock, reset)
begin
if (reset = '0') then
port_out_13 <= x"00";
elsif (clock'event and clock='1') then
if (address = x"E13" and w = '1') then
port_out_13 <= data_in;
end if;
end if;
end process;

-- port_out(14) description : ADDRESS x"E14"
U66 : process (clock, reset)
begin
if (reset = '0') then
port_out_14 <= x"00";
elsif (clock'event and clock='1') then
if (address = x"E14" and w = '1') then
port_out_14 <= data_in;
end if;
end if;
end process;

-- port_out(15) description : ADDRESS x"E15"
U43 : process (clock, reset)
begin
if (reset = '0') then
port_out_15 <= x"00";
elsif (clock'event and clock='1') then
if (address = x"E15" and w = '1') then
port_out_15 <= data_in;
end if;
end if;
end process;
end outports1;
