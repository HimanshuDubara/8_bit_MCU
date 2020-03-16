library IEEE;
use IEEE.std_logic_1164.all;
type portout1 is array(0 to 15) of std_logic_vector(7 downto 0);  

entity outports is
port( address: in std_logic_vector(7 downto 0);
      clock: in std_logic;
		data_in: in std_logic_vector(7 downto 0);
		w: in std_logic;
		reset: in std_logic;
		portout: out portout1);
end outports;
architecture outports1 is
begin

-- port_out(0) description : ADDRESS x"E0"
U3 : process (clock, reset)
begin
if (reset = ’0’) then
port_out(0) <= x"00";
elsif (clock’event and clock=’1’) then
if (address = x"E0" and w = ’1’) then
port_out(0) <= data_in;
end if;
end if;
end process;

-- port_out(1) description : ADDRESS x"E1"
U3 : process (clock, reset)
begin
if (reset = ’0’) then
port_out(1) <= x"00";
elsif (clock’event and clock=’1’) then
if (address = x"E1" and w = ’1’) then
port_out(1) <= data_in;
end if;
end if;
end process;

-- port_out(2) description : ADDRESS x"E2"
U3 : process (clock, reset)
begin
if (reset = ’0’) then
port_out(2) <= x"00";
elsif (clock’event and clock=’1’) then
if (address = x"E2" and w = ’1’) then
port_out(2) <= data_in;
end if;
end if;
end process;

-- port_out(3) description : ADDRESS x"E3"
U3 : process (clock, reset)
begin
if (reset = ’0’) then
port_out(3) <= x"00";
elsif (clock’event and clock=’1’) then
if (address = x"E3" and w = ’1’) then
port_out(3) <= data_in;
end if;
end if;
end process;

-- port_out(4) description : ADDRESS x"E4"
U3 : process (clock, reset)
begin
if (reset = ’0’) then
port_out(4) <= x"00";
elsif (clock’event and clock=’1’) then
if (address = x"E4" and w = ’1’) then
port_out(4) <= data_in;
end if;
end if;
end process;

-- port_out(5) description : ADDRESS x"E5"
U3 : process (clock, reset)
begin
if (reset = ’0’) then
port_out(5) <= x"00";
elsif (clock’event and clock=’1’) then
if (address = x"E5" and w = ’1’) then
port_out(5) <= data_in;
end if;
end if;
end process;

-- port_out(6) description : ADDRESS x"E6"
U3 : process (clock, reset)
begin
if (reset = ’0’) then
port_out(6) <= x"00";
elsif (clock’event and clock=’1’) then
if (address = x"E6" and w = ’1’) then
port_out(6) <= data_in;
end if;
end if;
end process;


-- port_out(7) description : ADDRESS x"E7"
U3 : process (clock, reset)
begin
if (reset = ’0’) then
port_out(7) <= x"00";
elsif (clock’event and clock=’1’) then
if (address = x"E7" and w = ’1’) then
port_out(7) <= data_in;
end if;
end if;
end process;

-- port_out(8) description : ADDRESS x"E8"
U3 : process (clock, reset)
begin
if (reset = ’0’) then
port_out(8) <= x"00";
elsif (clock’event and clock=’1’) then
if (address = x"E8" and w = ’1’) then
port_out(8) <= data_in;
end if;
end if;
end process;

-- port_out(9) description : ADDRESS x"E9"
U3 : process (clock, reset)
begin
if (reset = ’0’) then
port_out(9) <= x"00";
elsif (clock’event and clock=’1’) then
if (address = x"E9" and w = ’1’) then
port_out(9) <= data_in;
end if;
end if;
end process;

-- port_out(10) description : ADDRESS x"E10"
U3 : process (clock, reset)
begin
if (reset = ’0’) then
port_out(10) <= x"00";
elsif (clock’event and clock=’1’) then
if (address = x"E10" and w = ’1’) then
port_out(10) <= data_in;
end if;
end if;
end process;

-- port_out(11) description : ADDRESS x"E11"
U3 : process (clock, reset)
begin
if (reset = ’0’) then
port_out(11) <= x"00";
elsif (clock’event and clock=’1’) then
if (address = x"E11" and w = ’1’) then
port_out(11) <= data_in;
end if;
end if;
end process;

-- port_out(12) description : ADDRESS x"E12"
U3 : process (clock, reset)
begin
if (reset = ’0’) then
port_out(12) <= x"00";
elsif (clock’event and clock=’1’) then
if (address = x"E12" and w = ’1’) then
port_out(12) <= data_in;
end if;
end if;
end process;

-- port_out(13) description : ADDRESS x"E13"
U3 : process (clock, reset)
begin
if (reset = ’0’) then
port_out(13) <= x"00";
elsif (clock’event and clock=’1’) then
if (address = x"E13" and w = ’1’) then
port_out(13) <= data_in;
end if;
end if;
end process;

-- port_out(14) description : ADDRESS x"E14"
U3 : process (clock, reset)
begin
if (reset = ’0’) then
port_out(14) <= x"00";
elsif (clock’event and clock=’1’) then
if (address = x"E14" and w = ’1’) then
port_out(14) <= data_in;
end if;
end if;
end process;

-- port_out(15) description : ADDRESS x"E15"
U3 : process (clock, reset)
begin
if (reset = ’0’) then
port_out(15) <= x"00";
elsif (clock’event and clock=’1’) then
if (address = x"E15" and w = ’1’) then
port_out(15) <= data_in;
end if;
end if;
end process;
		