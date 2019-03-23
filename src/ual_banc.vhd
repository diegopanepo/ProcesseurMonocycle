library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ual_banc is
port(
    clk,rst : in std_logic;
    W       : out std_logic_vector (31 downto 0);
    RA,RB,RW: in std_logic_vector (3 downto 0);
    WE      : in std_logic;
    OP      : in std_logic_vector (1 downto 0);
    N       : out std_logic
);
end entity;

Architecture unite of ual_banc is

    signal busA,busB,busW : std_logic_vector (31 downto 0);

begin

    W <= busW;

    UB1 : entity work.alu port map (OP,busA,busB,busW,N);
    UB2 : entity work.banc_registr port map (clk,rst,busW,RA,RB,RW,WE,busA,busB);

end unite;
