library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity data_memory is
port(
	clk	: in std_logic;
	DataIn : in std_logic_vector (31 downto 0);
	DataOut: out std_logic_vector (31 downto 0);
	Addr : in std_logic_vector (5 downto 0);
	WrEn : in std_logic
);
end entity;

Architecture memoire of data_memory is

	type table is array (63 downto 0) of std_logic_vector (31 downto 0);
	
	function init_mots return table is
		variable result : table;
	begin
		for i in 63 downto 0 loop
			result(i) := std_logic_vector(to_unsigned(i,32));
		end loop;
		--result(63) := (others=>'1');
		return result;
	end init_mots;
	
	signal mem : table := init_mots;

begin
	
	DataOut <= mem(to_integer(unsigned(Addr)));
	process(clk)
	begin
		if rising_edge(clk) then
			if WrEn = '1' then
				mem(to_integer(unsigned(Addr))) <= DataIn;
			end if;
		end if;
	end process;
	
end memoire;