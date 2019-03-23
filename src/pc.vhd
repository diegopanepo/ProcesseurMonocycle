library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pc is
port(
	W		: in std_logic_vector (31 downto 0);
	rst,clk	: in std_logic ;
	Addr	: out std_logic_vector (31 downto 0)
);
end entity ;

Architecture Arch_PC of pc is
	signal registr : std_logic_vector (31 downto 0);

	begin
		process(clk)
		begin
			if rst = '1' then
				registr <= (others=>'0');
			elsif rising_edge(clk) then
				registr <= W;
			end if;
		end process;
		
		Addr <= registr;
		
end Arch_PC;
