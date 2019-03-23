library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity psr is
port(
	clk,rst	: in std_logic;
	DATAIN	: in std_logic_vector (31 downto 0);
	WE	    : in std_logic;
	DATAOUT	: out std_logic_vector (31 downto 0)
);
end entity;

Architecture Arch_Reg32 of psr is
	signal registre : std_logic_vector (31 downto 0) := (others=>'0');
begin
    process(clk,rst)
    begin
    if rst = '1' then
        registre <= (others=>'0');
    elsif rising_edge(clk) then
        if WE = '1' then
            registre <= DATAIN;        
        end if;
    end if;
    end process;
    DATAOUT <= registre ;
end Arch_Reg32;