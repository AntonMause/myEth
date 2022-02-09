----------------------------------------------------------------------
-- Created by Microsemi SmartDesign Sun Jan  2 17:16:32 2022
-- Testbench Template
-- This is a basic testbench that instantiates your design with basic 
-- clock and reset pins connected.  If your design has special
-- clock/reset or testbench driver requirements then you should 
-- copy this file and modify it. 
----------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Company: <Name>
--
-- File: fcs1_tb.vhd
-- File history:
--      <Revision number>: <Date>: <Comments>
--      <Revision number>: <Date>: <Comments>
--      <Revision number>: <Date>: <Comments>
--
-- Description: 
--
-- <Description here>
--
-- Targeted device: <Family::IGLOO2> <Die::M2GL010> <Package::144 TQ>
-- Author: <Name>
--
--------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;

entity fcs1_tb is
end fcs1_tb;

architecture behavioral of fcs1_tb is

    constant SYSCLK_PERIOD : time := 100 ns; -- 10MHZ

    signal SYSCLK : std_logic := '0';
    signal NSYSRESET : std_logic := '0';

    component fcs1
        -- ports
        port( 
            -- Inputs
            i_clk : in std_logic;
            i_rst_n : in std_logic;

            -- Outputs
            o_dat : out std_logic_vector(7 downto 0);
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
    fcs1_0 : fcs1
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

