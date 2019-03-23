library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Unit_gest is
port(
	clk,rst	: in std_logic;
	offset	: in std_logic_vector (23 downto 0);
	nPCsel	: in std_logic;
	instr	: out std_logic_vector (31 downto 0);
	PCout	: out std_logic_vector (31 downto 0)
);
end entity;

Architecture UG of Unit_gest is
	signal ext,mult,PC,ent0,ent1 : std_logic_vector (31 downto 0);
begin

  PCout <= PC;
  ent0 <= std_logic_vector(unsigned(PC)+1);
  ent1 <= std_logic_vector(unsigned(PC)+1+unsigned(ext));
	UG1 : entity work.ext_signe generic map (23) port map (offset,ext);
	UG2 : entity work.pc port map (mult,rst,clk,PC);
	UG3 : entity work.multip2v1 generic map (31) port map (nPCsel,ent0,ent1,mult);
	UG4 : entity work.instruction_memory port map (PC,instr);
	
end UG;