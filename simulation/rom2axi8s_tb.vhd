----------------------------------------------------------------------
-- File: rom2axi8s_tb.vhd
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity rom2axi8s_tb is
end rom2axi8s_tb;

--------------------------------------------------------------------------------
architecture behavioral of rom2axi8s_tb is

    constant SYSCLK_PERIOD : time := 10 ns; -- 100MHZ

    signal SYSCLK : std_logic := '1';
    signal NSYSRESET : std_logic := '0';
    signal s_ready   : std_logic := '0';

    component rom2axi8s
        port( 
            -- Inputs
            ACLK : in std_logic;
            ARESETN : in std_logic;
            M_AXIS_TREADY : in std_logic;
            -- Outputs
            M_AXIS_TVALID : out std_logic;
            M_AXIS_TDATA : out std_logic_vector(7 downto 0);
            M_AXIS_TLAST : out std_logic
        );
    end component;

begin

    process
        variable vhdl_initial : BOOLEAN := TRUE;

    begin
        if ( vhdl_initial ) then
            -- Assert Reset
            NSYSRESET <= '0';
            wait for ( SYSCLK_PERIOD * 2.0 );
            
            NSYSRESET <= '1';
            wait;
        end if;
    end process;

    -- Clock Driver
    SYSCLK  <= not SYSCLK  after (SYSCLK_PERIOD / 2.0 );
    s_ready <= not s_ready after (SYSCLK_PERIOD * 2.0 );

    -- Instantiate Unit Under Test:  rom2axi8s
    rom2axi8s_0 : rom2axi8s
        port map( 
            -- Inputs
            ACLK => SYSCLK,
            ARESETN => NSYSRESET,
            M_AXIS_TREADY => s_ready,
            -- Outputs
            M_AXIS_TVALID =>  open,
            M_AXIS_TDATA => open,
            M_AXIS_TLAST =>  open
        );

end behavioral;

