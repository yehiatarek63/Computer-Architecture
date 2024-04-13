LIBRARY IEEE;
 USE IEEE.STD_LOGIC_1164.ALL;
 USE IEEE.numeric_std.all;
 ENTITY DataMemory IS
    PORT (clk : IN std_logic;
          address : IN std_logic_vector(11 DOWNTO 0);
          data_in : IN std_logic_vector(31 DOWNTO 0);
          mem_write : IN std_logic;
          mem_read : IN std_logic;
          read_data : OUT std_logic_vector(31 DOWNTO 0)
        );
 END ENTITY DataMemory;

ARCHITECTURE sync_ram_a OF DataMemory IS  
    TYPE ram_type IS ARRAY(0 TO 4095) of std_logic_vector(15 DOWNTO 0);
        SIGNAL ram : ram_type ;
    BEGIN
    PROCESS(clk, mem_write, mem_read) IS  
        BEGIN
        IF rising_edge(clk) THEN   
            IF mem_write = '1' THEN        
                ram(to_integer(unsigned((address)))) <= data_in(15 downto 0);
                ram(to_integer(unsigned((address))) + 1) <= data_in(31 downto 16);
            ELSIF mem_read = '1' THEN
                read_data <= ram(to_integer(unsigned(address)) + 1) & ram(to_integer(unsigned(address)));
            END IF;
        END IF;
    END PROCESS;
 END sync_ram_a;