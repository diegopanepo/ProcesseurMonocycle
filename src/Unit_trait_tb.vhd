library ieee;
use ieee.Std_logic_1164.all;

entity Unit_trait_tb is
	generic(N: positive range 1 to 31:=7);
    port(OK: out BOOLEAN);
end;

architecture TB of Unit_trait_tb is
    
	signal clk,rst	: std_logic;
	signal OP		: std_logic_vector (1 downto 0);
	signal flag		: std_logic;
	signal RW,RA,RB	: std_logic_vector (3 downto 0);
	signal RegWr	: std_logic;
	signal WrEn		: std_logic;
	signal mx1,mx2	: std_logic;
	signal Imm		: std_logic_vector (N downto 0);
	signal busW		: std_logic_vector (31 downto 0);
	signal RegSel	: std_logic;

begin

	process
	begin
	
		RA <= "1110";
        RB <= "1111";
        RW <= "0001";
        OP <= "01";	--addition de 2 registres
        RegWr <= '1';
		WrEn <= '0';
		mx1 <= '0';
		mx2 <= '0';
		Imm <= "10100010"; --291
    
        clk <= '0';
        wait for 5 ns;
        clk <= '1';
        wait for 5 ns;
		
		mx1 <= '1';	--addition de regitre + imm
		RW <= "0010";
    
        clk <= '0';
        wait for 5 ns;
        clk <= '1';
        wait for 5 ns;
		
		mx1 <= '0'; --soustraction de 2 registres
		OP <= "10";
		RW <= "0011";
    
        clk <= '0';
        wait for 5 ns;
        clk <= '1';
        wait for 5 ns;
		
		mx1 <= '1'; --soustraction de registre - imm
		RW <= "0100";
    
        clk <= '0';
        wait for 5 ns;
        clk <= '1';
        wait for 5 ns;
		
		OP <= "11";  --registre dans un autre registre
		RW <= "0101";
    
        clk <= '0';
        wait for 5 ns;
        clk <= '1';
        wait for 5 ns;
		
		mx2 <= '1';	--lecture de mot dans memoire
		RW <= "0110";
    
        clk <= '0';
        wait for 5 ns;
        clk <= '1';
        wait for 5 ns;
        
		WrEn <= '1';--ecriture de mot dans memoire
		RW <= "0111";
    
        clk <= '0';
        wait for 5 ns;
        clk <= '1';
        wait for 5 ns;
    
        clk <= '0';
        wait for 5 ns;
        clk <= '1';
        wait for 5 ns;
		
		wait;
		
	end process;
	
	U : entity work.Unit_trait generic map (7) port map (clk,rst,OP,flag,RW,RA,RB,RegWr,WrEn,mx1,mx2,Imm,busW,RegSel);

end TB;
