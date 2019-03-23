library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Unit_trait is
generic(
	N : positive range 1 to 31:= 7
);
port(
	clk,rst	: in std_logic;
	OP		: in std_logic_vector (1 downto 0);
	flag	: out std_logic;
	Rd,Rn,Rm: in std_logic_vector (3 downto 0);
	RegWr	: in std_logic;
	WrEn	: in std_logic;
	mx1,mx2	: in std_logic;
	Imm		: in std_logic_vector (N downto 0);	--N
	busW	: out std_logic_vector(31 downto 0);
	RegSel	: in std_logic;
	Rw,Ra,Rb: out std_logic_vector (3 downto 0)
);
end entity;

Architecture UT of Unit_trait is

	signal busA, busB, busW2 : std_logic_vector (31 downto 0);
	signal ALUout : std_logic_vector (31 downto 0);
	signal ext, multip : std_logic_vector (31 downto 0);
	signal DataOut : std_logic_vector (31 downto 0);
	signal R : std_logic_vector (3 downto 0);

begin
	busW <= busW2;
	Rw <= Rd;
	Ra <= Rn;
	Rb <= R;
	--possibles problemes avec le generic N -- il faut les initialiser autrement?
	UT0 : entity work.multip2v1 generic map (3) port map (RegSel,Rm,Rd,R);
	UT1 : entity work.banc_registr port map (clk,rst,busW2,Rn,R,Rd,RegWr,busA,busB);
	UT2 : entity work.ext_signe generic map (N) port map (Imm,ext);
	UT3 : entity work.multip2v1 generic map (31) port map (mx1,busB,ext,multip);
	UT4 : entity work.alu port map (OP,busA,multip,ALUout,flag);
	UT5 : entity work.data_memory port map (clk,busB,DataOut,ALUout(5 downto 0),WrEn);
	UT6 : entity work.multip2v1 generic map (31) port map (mx2,ALUout,DataOut,busW2);
	--UT1 : entity work.ual_banc2 port map (clk,rst,busW,RA,RB,RW,RegWr,OP,flag,DataIn,Imm,mx1);
	--UT2 : entity work.multip2v1 port map (mx1,busB,
	
end UT;
	