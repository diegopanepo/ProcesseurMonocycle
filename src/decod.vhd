library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity decod is
port(
	Instr	: in std_logic_vector (31 downto 0);
	PSR		: in std_logic_vector (31 downto 0);
	nPCsel	: out std_logic;
	RegWr	: out std_logic;
	ALUsrc	: out std_logic;
	ALUctr	: out std_logic_vector (1 downto 0);
	PSREn	: out std_logic;
	MemWr	: out std_logic;
	WrSrc	: out std_logic;
	RegSel	: out std_logic;
	Rd,Rn,Rm: out std_logic_vector (3 downto 0)
);
end entity;

Architecture decod_instr of decod is

	type enum_instruction is (MOV, ADDi, ADDr, CMP, LDR, STR, BAL, BLT);
	signal instr_courante : enum_instruction;

begin
	
	process(Instr)
	begin
		case Instr(27 downto 26) is
			when "00" =>
				case Instr(25 downto 21) is
					when "10100"	=> instr_courante <= ADDi;
					when "00100"	=> instr_courante <= ADDr;
					when "11101"	=> instr_courante <= MOV;
					when "11010"	=> instr_courante <= CMP;
					when others		=> report "Instruction invalide";
									--instr_courante <= 'X';
					end case;
			when "01" =>
				if Instr(20) = '1' then
					instr_courante <= LDR;
				elsif Instr(20) = '0' then
					instr_courante <= STR;
				else report "Instruction invalide";
						--instr_courante <= 'X';
				end if;
			when "10" =>
				if Instr(30) = '1' then
					instr_courante <= BAL;
				elsif Instr(30) = '0' then
					instr_courante <= BLT;
				else
					report "Instruction invalide";--instr_courante <= 'X';
				end if;
			when others	=>
				report "Instruction invalide"; --instr_courante <= 'X';
		end case;
	end process;
	
	process(Instr)
	begin
		case Instr(27 downto 26) is
			when "00" =>	--tratiement de donnees
				nPCsel	<= '0';
				MemWr	<= '0';
				WrSrc	<= '0';
				RegSel	<= '0';
				case Instr(25 downto 21) is
					when "10100"	=>	--ADDi
						RegWr	<= '1';
						ALUsrc	<= '1';
						ALUctr	<= "00";
						PSREn	<= '0';
						Rn		<= Instr(19 downto 16);
						Rd		<= Instr(15 downto 12);
					when "00100"	=>	--ADDr
						RegWr	<= '1';
						ALUsrc	<= '0';
						ALUctr	<= "00";
						PSREn	<= '0';
						Rn		<= Instr(19 downto 16);
						Rd		<= Instr(15 downto 12);
						Rm		<= Instr(3 downto 0);
					when "11101"	=>	--MOV
						RegWr	<= '1';
						ALUsrc	<= '1';
						ALUctr	<= "01";
						PSREn	<= '0';
						Rd		<= Instr(15 downto 12);
					when "11010"	=>	--CMP
						RegWr	<= '0';
						ALUsrc	<= '1';
						ALUctr	<= "10";
						PSREn	<= '1';
						Rn		<= Instr(19 downto 16);
					when others		=>	--error
						report "Instruction invalide";
				end case;
			when "01" =>	--memoire
				nPCsel	<= '0';
				ALUsrc	<= '1';
				ALUctr	<= "00";
				PSREn	<= '0';
				WrSrc	<= '1';
				Rn		<= Instr(19 downto 16);
				Rd		<= Instr(15 downto 12);
				if Instr(20) = '1' then		--LDR
					RegWr	<= '1';
					MemWr	<= '0';
					RegSel	<= '0';
				elsif Instr(20) = '0' then	--STR
					RegWr	<= '0';
					MemWr	<= '1';
					RegSel	<= '1';
				else					-- error
					report "Instruction invalide";
				end if;
			when "10" =>	--branchements
				RegWr	<= '0';
				ALUsrc	<= '0';
				--ALUctr	<= "00"; --peu importe valeur ALUctr
				PSREn	<= '0';
				MemWr	<= '0';
				WrSrc	<= '0';
				RegSel	<= '0';
				if Instr(30) = '1' then		--BAL
					nPCsel	<= '1';
				elsif Instr(30) = '0' then	--BLT
					nPCsel	<= PSR(0);
				else
					report "Instruction invalide";
				end if;
			when others	=>		--error
				report "Instruction invalide";
		end case;
	end process;
	
end decod_instr;