library IEEE;
use IEEE.std_logic_1164.all;

entity BUS1 is
port( PC: in std_logic_vector(7 downto 0);
      A: in std_logic_vector(7 downto 0);
		B: in std_logic_vector(7 downto 0);
		Bus1_Sel: in std_logic_vector(1 downto 0);
		Bus1Output: out std_logic_vector(7 downto 0));
end BUS1;

architecture BUS11 of BUS1 is
begin
MUX_BUS1 : process (Bus1_Sel, PC, A, B)
begin
	case (Bus1_Sel) is
		when "00" => Bus1Output <= PC;
		when "01" => Bus1Output <= A;
		when "10" => Bus1Output <= B;
		when others => Bus1Output <= x"00";
	end case;
end process;
end BUS11;
		
		