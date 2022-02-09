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
    x"AAAAAAAA",
    x"AAAA5555",
    x"55555555",
    x"0004DEAD",

-- tail -- tail -- tail -- tail -- tail -- tail -- tail -- tail -- tail -- 
    others=>x"00000000" );
signal s_adr : std_logic_vector(PLEN-1 downto 0);
signal s_out : std_logic_vector(31 downto 0);

begin

  s_clk     <= i_clk;

adr_p : process (s_clk)
  begin
    if rising_edge(s_clk) then
--      s_adr <= i_adr(PLEN-1 downto 0);
    end if;
  end process;
s_adr <= i_adr(PLEN-1 downto 0);

dat_p : process (s_clk)
  begin
    if rising_edge(s_clk) then
--      s_out <= s_mem(to_integer(unsigned(s_adr)));
    end if;
  end process;
s_out <= s_mem(to_integer(unsigned(s_adr)));

  o_dat <= s_out;
--  o_dat <= s_out(7 downto 0) & s_out(15 downto 8);
  
end rtl;