library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Unit_contr is
port(
	clk,rst	: in std_logic;
	Instr	: in std_logic_vector (31 downto 0);
	flagPSR	: in std_logic_vector (31 downto 0);
	nPCsel	: out std_logic;
	RegWr	: out std_logic;
	ALUsrc	: out std_logic;
	ALUctr	: out std_logic_vector (1 downto 0);
	MemWr	: out std_logic;
	WrSrc	: out std_logic;
	RegSel	: out std_logic;
	Rd,Rn,Rm: out std_logic_vector (3 downto 0)
);
end entity;

Architecture UC of Unit_contr is
	signal PSREn : std_logic;
	signal PSRout : std_logic_vector (31 downto 0);
begin

	UC1 : entity work.decod port map (Instr,PSRout,nPCsel,RegWr,ALUsrc,ALUctr,PSREn,MemWr,WrSrc,RegSel,Rd,Rn,Rm);
	UC2 : entity work.psr port map (clk,rst,flagPSR,PSREn,PSRout);
	
end UC;