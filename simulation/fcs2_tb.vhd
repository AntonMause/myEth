----------------------------------------------------------------------
-- File: fcs2_tb.vhd
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity fcs2_tb is
end fcs2_tb;

architecture behavioral of fcs2_tb is

    constant SYSCLK_PERIOD : time := 100 ns; -- 10MHZ

    signal SYSCLK : std_logic := '0';
    signal NSYSRESET : std_logic := '0';

    component fcs2
        -- ports
        port( 
            -- Inputs
            i_clk : in std_logic;
            i_rst_n : in std_logic;

            -- Outputs
            o_dat : out std_logic_vector(15 downto 0);
            o_fcs : out std_logic_vector(31 downto 0)

            -- Inouts

        );
    end component;

begin

    process
        variable vhdl_initial : BOOLEAN := TRUE;

    begin
        if ( vhdl_initial ) then
            -- Assert Reset
            NSYSRESET <= '0';
            wait for ( SYSCLK_PERIOD * 2 );
            
            NSYSRESET <= '1';
            wait;
        end if;
    end process;

    -- Clock Driver
    SYSCLK <= not SYSCLK after (SYSCLK_PERIOD / 2.0 );

    -- Instantiate Unit Under Test:  fcs1
    fcs2_0 : fcs2
        -- port map
        port map( 
            -- Inputs
            i_clk => SYSCLK,
            i_rst_n => NSYSRESET,

            -- Outputs
            o_dat => open,
            o_fcs => open

            -- Inouts

        );

end behavioral;

