library ieee;
use ieee.std_logic_1164.all;

entity mono_testb is
port( OK: out boolean:=TRUE );
end entity mono_testb;

Architecture test_bench of mono_testb is
	signal clk,rst	: std_logic;
	signal PC : std_logic_vector (31 downto 0);
begin

	process
	begin
		clk <= '1';
		rst <= '0';
		wait for 10 ns;
		clk <= '0';
		rst <= '1';
		wait for 10 ns;
		clk <= '1';
		wait for 10 ns;
		rst <= '0';
		clk <= '0';
		wait for 10 ns;
		for i in 0 to 60 loop
			clk <= '1';
			wait for 10 ns;
			clk <= '0';
			wait for 10 ns;
		end loop;
		wait;
	end process;
	
	MTB: entity work.Monocycle port map (clk=>clk,rst=>rst,PC=>PC);
	
end test_bench;