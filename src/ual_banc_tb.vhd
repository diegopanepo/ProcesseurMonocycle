library ieee;
use ieee.std_logic_1164.all;

entity ual_banc_tb is
    --port(OK: out BOOLEAN);
end entity;

architecture TB of ual_banc_tb is

    signal clk, rst: Std_logic;
    signal N : std_logic;
    signal RA,RB,RW : std_logic_vector (3 downto 0);
    signal WE : std_logic;
    signal OP : std_logic_vector (1 downto 0);
    signal busW : std_logic_vector (31 downto 0);

begin

    --rst <= '1' , '0' after 1 ns;
    process
    begin
        RA <= "0001";
        RB <= "1111";
        RW <= "0001";
        OP <= "01";
        WE <= '1';
        --OK <= TRUE;
    
        clk <= '0';
        wait for 5 ns;
        clk <= '1';
        wait for 5 ns;

        OP <= "00";

        clk <= '0';
        wait for 5 ns;
        clk <= '1';
        wait for 5 ns;

        RW <= "0010";

        clk <= '0';
        wait for 5 ns;
        clk <= '1';
        wait for 5 ns;

        OP <= "10";
        RW <= "0011";

        clk <= '0';
        wait for 5 ns;
        clk <= '1';
        wait for 5 ns;

        RA <= "0111";
        RW <= "0101";

        clk <= '0';
        wait for 5 ns;
        clk <= '1';
        wait for 5 ns;
    
        wait;
    end process;

    U : entity work.ual_banc port map (clk, rst, busW, RA, RB, RW, WE, OP, N);

end TB;
        
