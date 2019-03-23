library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity monocycle is
generic(
	N : positive := 7
);
port(
	clk,rst	: in std_logic;
	busW	: out std_logic_vector (31 downto 0);
	instr,PC: out std_logic_vector (31 downto 0);
	Rw,Ra,Rb: out std_logic_vector (3 downto 0)
);
end entity;

Architecture processeur of monocycle is
	signal flag : std_logic_vector (31 downto 0) := (others=>'0');
	signal nPCsel,RegWr,ALUsrc,MemWr,WrSrc,RegSel : std_logic;
	signal ALUctr : std_logic_vector (1 downto 0);
	signal Rd,Rn,Rm : std_logic_vector (3 downto 0);
	signal Imm : std_logic_vector (N downto 0);
	signal offset : std_logic_vector (23 downto 0);
	signal instr2 : std_logic_vector (31 downto 0);
begin

	Imm <= instr2 (N downto 0);
	offset <= instr2 (23 downto 0);
	instr <= instr2;
	MC1 : entity work.Unit_trait generic map (N) port map (clk,rst,ALUctr,flag(0),Rd,Rn,Rm,RegWr,MemWr,ALUsrc,WrSrc,Imm,busW,RegSel,Rw,Ra,Rb);
	MC2 : entity work.Unit_gest port map (clk,rst,offset,nPCsel,instr2,PC);
	MC3 : entity work.Unit_contr port map (clk,rst,instr2,flag,nPCsel,RegWr,ALUsrc,ALUctr,MemWr,WrSrc,RegSel,Rd,Rn,Rm);
	
end processeur;