library IEEE;
use IEEE.std_logic_1164.all;

entity BUS1 is
port( ALU_Result: in std_logic_vector(7 downto 0);
      from_memory: in std_logic_vector(7 downto 0);
		Bus2Output: in std_logic_vector(7 downto 0);
		Bus2_Sel: in std_logic_vector(1 downto 0);
		Bus1: in std_logic_vector(7 downto 0));
end BUS1;

architecture BUS21 of BUS1 is
begin
MUX_BUS1 : process (Bus2_Sel, ALU_Result, from_memory, Bus1)
begin
	case (Bus1_Sel) is
		when "00" => Bus2Output <= ALU_Result;
		when "01" => Bus2Output <= BUS1;
		when "10" => Bus2Output <= from_memory;
		when others => Bus2Output <= x"00";
	end case;
end process;
end BUS21;
		