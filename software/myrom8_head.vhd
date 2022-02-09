--------------------------------------------------------------------------------
-- WatchOut: 
--   myrom8.vhd        gets generated via script, do not modify
--   myrom8_head.vhd   edit here ...
--   myrom8_tail.vhd   ... or here
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- File: myrom8.vhd   (c) 2022 by Anton Mause
--------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity myrom8 is 
generic( PLEN : natural := 10 );
port( i_clk : in  std_logic;
      i_adr : in  std_logic_vector(PLEN-1 downto 0);
      o_len : out std_logic_vector(PLEN-1 downto 0);
      o_dat : out std_logic_vector(7 downto 0) );
end myrom8;

architecture rtl of myrom8 is

signal s_clk : std_logic;
type mem_array is array(0 to (2**PLEN)-1) of std_logic_vector(7 downto 0);
signal s_mem : mem_array := ( 
-- head -- head -- head -- head -- head -- head -- head -- head -- head --
