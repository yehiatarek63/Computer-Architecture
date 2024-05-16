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
        flushDecodeRETfromDecode, flushDecodeRETfromExecute, flushDecodeRETfromMemory : IN std_logic
    );
end FetchDecode;

ARCHITECTURE Behavior OF FetchDecode IS
BEGIN
    PROCESS (clk, reset, flushDecodeRETfromDecode, flushDecodeRETfromExecute)
    BEGIN
    IF reset = '1' or flushDecodeRETfromDecode = '1' or flushDecodeRETfromExecute = '1' THEN
            instructionOut <= "1100000000000000";
            InPortOut <= (others => '0');

        ELSIF rising_edge(clk) THEN
            instructionOut <= instructionIn;
            InPortOut <= InPort;
            PCOUT <= PCIN;
        END IF;
    END PROCESS;

END Behavior;