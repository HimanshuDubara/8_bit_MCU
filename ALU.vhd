----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/19/2020 09:37:03 AM
-- Design Name: 
-- Module Name: alu - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;
--use ieee.numeric_bit.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity alu is
--  Port ( );
    PORT( A,B : in std_logic_vector(7 downto 0);
         ALU_sel : in std_logic_vector(3 downto 0);
         NZVC : out std_logic_vector(3 downto 0);
         ALU_result : out std_logic_vector(7 downto 0)
    );
    
end alu;

architecture alu_arch of alu is
    
    signal sum : std_logic_vector(8 downto 0);
    signal result,temp: std_logic_vector(7 downto 0);
    signal N,Z,V,C: std_logic;
    begin
    process(A,B,ALU_sel)
    begin
        sum <= "00000000";
    case ALU_sel is
        when "0000" => 
            sum<=('0'&A)+('0'&B);
            result<=A+B;
        when "0001" =>
            result<=B-A;
            sum<=('0'&B)-('0'&A);
        when "0010" =>
            result <= A and B;  
        when "0011" =>
            result <= A or B;
        when "0100" =>
            result <= not A;
        when "0101" =>
            result <= A + 1;
        when "0110" =>
            result <= A - 1;
        when "1111" =>
            result <= "00000000";
		  when "1000" =>
            result <= B + 1;
		  when "1001" =>
            result <= B - 1;
		 
--            temp <= A;
--            A <= B;
--            B <= temp;
         end case;
         end process;
       --Flags
       ALU_result<=result;
       N <= result(7);
       Z <= '1' when result="00000000"
         else '0';
       with ALU_sel select
           C <= sum(8) when "0000",
                sum(8) when "0001",
                sum(0) when "0101",
                sum(0) when "0110",
                '0' when others;  
       with ALU_sel select
       V <= ( A(7)and B(7)and (not result(7)) ) or ( (not A(7)) and (not B(7)) and result(7) ) when "0000",
            ( A(7)and (not B(7)) and (not result(7)) ) or ( (not A(7))and B(7)    and result(7) ) when "0001",                   
            '0' when others;
       NZVC <= N&Z&V&C;

end alu_arch;
