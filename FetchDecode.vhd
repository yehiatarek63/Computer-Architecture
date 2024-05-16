library ieee;
use ieee.std_logic_1164.all;

entity FetchDecode is
    port(
        clk: in std_logic;
        reset: in std_logic;
        instructionIn: in std_logic_vector(15 downto 0);
        instructionOut: out std_logic_vector(15 downto 0);
        InPort: in std_logic_vector(31 downto 0);
        InPortOut: out std_logic_vector(31 downto 0);
        PCIN : in std_logic_vector(31 downto 0);
        PCOUT : out std_logic_vector(31 downto 0);
        flushDecodeRETfromDecode, flushDecodeRETfromExecute, flushDecodeRETfromMemory, flush_decode_branching1, flush_decode_branching2 : IN std_logic
    );
end FetchDecode;

ARCHITECTURE Behavior OF FetchDecode IS
BEGIN
    PROCESS (clk, reset)
    BEGIN
    IF reset = '1' or (flushDecodeRETfromDecode = '1' and falling_edge(clk)) or (flushDecodeRETfromExecute = '1' and falling_edge(clk)) or (flushDecodeRETfromMemory = '1' and falling_edge(clk)) or (flush_decode_branching1 = '1' and falling_edge(clk)) or (flush_decode_branching2 = '1' and falling_edge(clk)) THEN
            instructionOut <= "1100000000000000";
            InPortOut <= (others => '0');

        ELSIF rising_edge(clk) THEN
            instructionOut <= instructionIn;
            InPortOut <= InPort;
            PCOUT <= PCIN;
        END IF;
    END PROCESS;

END Behavior;