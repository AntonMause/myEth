--------------------------------------------------------------------------------
-- WatchOut: 
--   myrom32.vhd        gets generated via script, do not modify
--   myrom32_head.vhd   edit here ...
--   myrom32_tail.vhd   ... or here
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- File: myrom.vhd   (c) 2022 by Anton Mause
--------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity myrom32 is 
generic( PLEN : natural := 10 );
port( i_clk : in  std_logic;
      i_adr : in  std_logic_vector(PLEN-1 downto 0);
      o_dat : out std_logic_vector(31 downto 0) );
end myrom32;

architecture rtl of myrom32 is

signal s_clk : std_logic;
type mem_array is array(0 to (2**PLEN)-2) of std_logic_vector(31 downto 0);
signal s_mem : mem_array := ( 
-- head -- head -- head -- head -- head -- head -- head -- head -- head --
