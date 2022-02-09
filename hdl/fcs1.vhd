--------------------------------------------------------------------------------
-- File: fcs1.vhd
--------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

--------------------------------------------------------------------------------
-- 413 MHz g4 -1 double pipelined memory, 8 bit bus
-- 500 MHz g5 -1 double pipelined memory, 8 bit bus
--------------------------------------------------------------------------------
entity fcs1 is 
generic( PLEN : natural := 10 );
port (
  i_clk     : in  std_logic;
  i_rst_n   : in  std_logic;
  o_dat     : out std_logic_vector(7 downto 0);
  o_fcs     : out std_logic_vector(31 downto 0) );
end fcs1;
--------------------------------------------------------------------------------
architecture rtl of fcs1 is
  signal s_clk, s_rst_n : std_logic;
  signal u_idx, u_adr   : unsigned(PLEN-1 downto 0);
  signal s_dat          : std_logic_vector(7 downto 0);
  signal s_crc, s_fcs   : std_logic_vector(31 downto 0);
  signal s_one, s_two   : std_logic_vector(31 downto 0);

component myrom8 is 
generic( PLEN : natural := 10 );
port( i_clk : in  std_logic;
      i_adr : in  std_logic_vector(PLEN-1 downto 0);
      o_dat : out std_logic_vector(7 downto 0) );
end component;

component crc32x8 is port ( 
    i_dat : in std_logic_vector (7 downto 0);
    i_crc : in std_logic_vector (31 downto 0);
    o_crc : out std_logic_vector (31 downto 0));
end component;

begin

  s_clk     <= i_clk;
  s_rst_n   <= i_rst_n;

----------------------------------------------------------------------
idx_p : process(s_clk,s_rst_n)
  begin
    if (s_rst_n = '0') then
      u_idx <= (others=>'0');
      s_crc <= (others=>'1');
    elsif (s_clk'event and s_clk = '1') then
      u_idx <= u_idx +1;
      s_crc <= s_fcs;
    end if;
  end process;
  u_adr <= u_idx;

----------------------------------------------------------------------
rom0 : myrom8
  generic map ( PLEN => PLEN )
  port map( 
    i_clk => s_clk,
    i_adr => std_logic_vector(u_adr),
    o_dat => s_dat);
  
----------------------------------------------------------------------
crc0 : crc32x8 port map ( 
    i_dat => s_dat,
    i_crc => s_crc,
    o_crc => s_fcs);
  s_one   <= s_fcs xor x"FFFFFFFF";

----------------------------------------------------------------------
out_p : process(s_clk)
  begin
    if (s_clk'event and s_clk = '1') then
      o_dat <= s_dat;
      o_fcs <= s_fcs;
    end if;
  end process;

end rtl;
