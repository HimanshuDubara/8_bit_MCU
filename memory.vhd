library IEEE;
use IEEE.std_logic_1164.all;
type portout1 is array(0 to 15) of std_logic_vector(7 downto 0);

entity memory is
port( address: in std_logic_vector(7 downto 0);
      data_in: in std_logic_vector(7 downto 0);
		w: in std_logic;
		clock: in std_logic;
		portout: out portout1;
		portin: in portout1;
		data_out: out std_logic_vector(7 downto 0);
		reset: in std_logic
		);
end memory;

architecture memory1 of memory is
signal rom_data_out, rw_data_out: std_logic_vector(7 downto 0);

component rom is 
port( address : in std_logic_vector(7 downto 0);
      clock : in std_logic;
		data_out: out std_logic_vector(7 downto 0)
		);
end component;

component rw is
port( w: in std_logic;
      address: in std_logic_address(7 downto 0);
		clock: in std_logic;
		data_in: in std_logic_vector(7 downto 0);
		data_out: out std_logic_vector(7 downto 0)
		);
end component;

component outports is
port( address: in std_logic_vector(7 downto 0);
      clock: in std_logic;
		data_in: in std_logic_vector(7 downto 0);
		w: in std_logic;
		reset: in std_logic;
		portout: out portout1);
end component;

begin
--internal connections 
 x1: rom port map( address => address,
                   clock => clock,
						 data_out => rom_data_out );
x2: rw port map( w => w,
                 address => address,
                 clock => clock,
					  data_in => data_in,
					  data_out => rw_data_out );
x3: outports port map( address => address,
							  clock => clock,
							  data_in => data_in,
							  reset => reset,
							  portout => portout);
							  
--multiplexing input and output
MUX1: process(address, rom_data_out, rw_data_out, portin)
		begin
			if ( (to_integer(unsigned(address)) >= 0) and
			(to_integer(unsigned(address)) <= 127)) then
			data_out <= rom_data_out;

			elsif ( (to_integer(unsigned(address)) >= 128) and
			(to_integer(unsigned(address)) <= 223)) then
			data_out <= rw_data_out;
			
			elsif (address = x"F0") then data_out <= portin(0);
			elsif (address = x"F1") then data_out <= portin(1);
			elsif (address = x"F2") then data_out <= portin(2);
			elsif (address = x"F3") then data_out <= portin(3);
			elsif (address = x"F4") then data_out <= portin(4);
			elsif (address = x"F5") then data_out <= portin(5);
			elsif (address = x"F6") then data_out <= portin(6);
			elsif (address = x"F7") then data_out <= portin(7);
			elsif (address = x"F8") then data_out <= portin(8);
			elsif (address = x"F9") then data_out <= portin(9);
			elsif (address = x"FA") then data_out <= portin(10);
			elsif (address = x"FB") then data_out <= portin(11);
			elsif (address = x"FC") then data_out <= portin(12);
			elsif (address = x"FD") then data_out <= portin(13);
			elsif (address = x"FE") then data_out <= portin(14);
			elsif (address = x"FF") then data_out <= portin1(15);
			else data_out <= x"00";
		end if;
		end process;

		
end memory1;

							  
						 

						 

