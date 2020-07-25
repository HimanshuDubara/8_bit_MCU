library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.ALL;

entity mcu is
port(clock: in std_logic;
	  reset: in std_logic;
	   port_in_00: in std_logic_vector(7 downto 0);   
        port_in_01: in std_logic_vector(7 downto 0);  
        port_in_02: in std_logic_vector(7 downto 0);    
        port_in_03: in std_logic_vector(7 downto 0);   
        port_in_04: in std_logic_vector(7 downto 0);   
        port_in_05: in std_logic_vector(7 downto 0);   
        port_in_06: in std_logic_vector(7 downto 0);   
        port_in_07: in std_logic_vector(7 downto 0);   
        port_in_08: in std_logic_vector(7 downto 0);   
        port_in_09: in std_logic_vector(7 downto 0);  
        port_in_10: in std_logic_vector(7 downto 0);   
        port_in_11: in std_logic_vector(7 downto 0);   
        port_in_12: in std_logic_vector(7 downto 0);   
        port_in_13: in std_logic_vector(7 downto 0);   
        port_in_14: in std_logic_vector(7 downto 0);    
        port_in_15: in std_logic_vector(7 downto 0);  
         
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
end mcu;

architecture mcu_work of mcu is
signal addr,to_mem,from_mem: std_logic_vector(7 downto 0);
signal wr: std_logic;

component cpu is
port(clock: in std_logic;
	  reset: in std_logic;
	  w: out std_logic;
     address: out std_logic_vector(7 downto 0);
	  from_memory: in std_logic_vector(7 downto 0);
	  to_memory: out std_logic_vector(7 downto 0)		
); 
end component;

component memory is
port( address: in std_logic_vector(7 downto 0);
      data_in: in std_logic_vector(7 downto 0);
		w: in std_logic;
		clock,reset: in std_logic;
		data_out: out std_logic_vector(7 downto 0);
      port_in_00: in std_logic_vector(7 downto 0);   
        port_in_01: in std_logic_vector(7 downto 0);  
        port_in_02: in std_logic_vector(7 downto 0);    
        port_in_03: in std_logic_vector(7 downto 0);   
        port_in_04: in std_logic_vector(7 downto 0);   
        port_in_05: in std_logic_vector(7 downto 0);   
        port_in_06: in std_logic_vector(7 downto 0);   
        port_in_07: in std_logic_vector(7 downto 0);   
        port_in_08: in std_logic_vector(7 downto 0);   
        port_in_09: in std_logic_vector(7 downto 0);  
        port_in_10: in std_logic_vector(7 downto 0);   
        port_in_11: in std_logic_vector(7 downto 0);   
        port_in_12: in std_logic_vector(7 downto 0);   
        port_in_13: in std_logic_vector(7 downto 0);   
        port_in_14: in std_logic_vector(7 downto 0);    
        port_in_15: in std_logic_vector(7 downto 0);  
         
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
end component;

begin
C: cpu port map(clock => clock,
					 reset => reset,
					 address => addr,
					 w => wr,
					 from_memory => from_mem,
					 to_memory => to_mem					 
					);
M: memory port map(address => addr,
						 data_in => to_mem,
						 w => wr,
						 clock => clock,
					    reset => reset,
					    data_out => from_mem,
						 port_in_00 =>port_in_00,
						 port_in_01 =>port_in_01,
						 port_in_02 =>port_in_02,
						 port_in_03 =>port_in_03,
						 port_in_04 =>port_in_04,
						 port_in_05 =>port_in_05,
						 port_in_06 =>port_in_06,
						 port_in_07 =>port_in_07,
						 port_in_08 =>port_in_08,
						 port_in_09 =>port_in_09,
						 port_in_10 =>port_in_10,
						 port_in_11 =>port_in_11,
						 port_in_12 =>port_in_12,
						 port_in_13 =>port_in_13,
						 port_in_14 =>port_in_14,
						 port_in_15 =>port_in_15,
						 port_out_00 =>port_out_00,
						 port_out_01 =>port_out_01,
						 port_out_02 =>port_out_02,
						 port_out_03 =>port_out_03,
						 port_out_04 =>port_out_04,
						 port_out_05 =>port_out_05,
						 port_out_06 =>port_out_06,
						 port_out_07 =>port_out_07,
						 port_out_08 =>port_out_08,
						 port_out_09 =>port_out_09,
						 port_out_10 =>port_out_10,
						 port_out_11 =>port_out_11,
						 port_out_12 =>port_out_12,
						 port_out_13 =>port_out_13,
						 port_out_14 =>port_out_14,
						 port_out_15 =>port_out_15
						);

end mcu_work;
						