--------------------------------------------------------------------------------
-- WatchOut: 
--   myrom16.vhd        gets generated via script, do not modify
--   myrom16_head.vhd   edit here ...
--   myrom16_tail.vhd   ... or here
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- File: myrom.vhd   (c) 2022 by Anton Mause
--------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity myrom16 is 
generic( PLEN : natural := 10 );
port( i_clk : in  std_logic;
      i_adr : in  std_logic_vector(PLEN-1 downto 0);
      o_dat : out std_logic_vector(15 downto 0) );
end myrom16;

architecture rtl of myrom16 is

signal s_clk : std_logic;
type mem_array is array(0 to (2**PLEN)-1) of std_logic_vector(15 downto 0);
signal s_mem : mem_array := ( 
-- head -- head -- head -- head -- head -- head -- head -- head -- head --
    x"0800",
    x"2727",
    x"1ad5",
    x"5254",
    x"0012",
    x"3502",
    x"0800",
    x"4500",
    x"0054",
    x"1e49",
    x"4000",
    x"4001",
    x"0450",
    x"0a00",
    x"0202",
    x"0a00",
    x"020f",
    x"0000",
    x"59d6",
    x"0faf",
    x"0001",
    x"fdb5",
    x"f55a",
    x"0000",
    x"0000",
    x"e195",
    x"0300",
    x"0000",
    x"0000",
    x"1011",
    x"1213",
    x"1415",
    x"1617",
    x"1819",
    x"1a1b",
    x"1c1d",
    x"1e1f",
    x"2021",
    x"2223",
    x"2425",
    x"2627",
    x"2829",
    x"2a2b",
    x"2c2d",
    x"2e2f",
    x"3031",
    x"3233",
    x"3435",
    x"3637",
    x"e64c",
    x"b486",

-- tail -- tail -- tail -- tail -- tail -- tail -- tail -- tail -- tail -- 
    others=>x"0000" );
signal s_adr : std_logic_vector(PLEN-1 downto 0);
signal s_out : std_logic_vector(15 downto 0);

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

--  o_dat <= s_out;
  o_dat <= s_out(7 downto 0) & s_out(15 downto 8);

end rtl;