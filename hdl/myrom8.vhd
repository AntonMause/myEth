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
    x"AA", --    0
    x"AA", --    1
    x"AA", --    2
    x"AA", --    3
    x"AA", --    4
    x"AA", --    5
    x"55", --    6
    x"55", --    7
    x"55", --    8
    x"55", --    9
    x"55", --   10
    x"55", --   11
    x"00", --   12
    x"04", --   13
    x"DE", --   14
    x"AD", --   15
    x"BE", --   16
    x"EF", --   17
    others=>x"00" ); 
signal s_len : integer := 18;

-- tail -- tail -- tail -- tail -- tail -- tail -- tail -- tail -- tail -- 
signal s_adr : std_logic_vector(PLEN-1 downto 0);
signal s_out : std_logic_vector(7 downto 0);

begin

  s_clk     <= i_clk;

adr_p : process (s_clk)
  begin
    if rising_edge(s_clk) then
      s_adr <= i_adr(PLEN-1 downto 0);
    end if;
  end process;
--s_adr <= i_adr(PLEN-1 downto 0);

dat_p : process (s_clk)
  begin
    if rising_edge(s_clk) then
      s_out <= s_mem(to_integer(unsigned(s_adr)));
    end if;
  end process;
--s_out <= s_mem(to_integer(unsigned(s_adr)));

  o_len <= std_logic_vector(to_unsigned(s_len,PLEN));
  o_dat <= s_out;

end rtl;
