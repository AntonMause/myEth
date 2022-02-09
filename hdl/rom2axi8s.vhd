--------------------------------------------------------------------------------
-- File: rom2axi8s.vhd
--------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

--------------------------------------------------------------------------------
entity rom2axi8s is
generic( PLEN : natural := 10 );
port (
  ACLK            : in  std_logic;
  ARESETN         : in  std_logic;
  M_AXIS_TVALID   : out std_logic;
  M_AXIS_TDATA    : out std_logic_vector(7 downto 0);
  M_AXIS_TLAST    : out std_logic;
  M_AXIS_TREADY   : in  std_logic);
end rom2axi8s;

--------------------------------------------------------------------------------
architecture architecture_rom2axi8s of rom2axi8s is
  signal s_clk, s_rst_n : std_logic;
  signal s_dat          : std_logic_vector(7 downto 0);
  signal u_idx, u_adr   : unsigned(PLEN-1 downto 0);
  signal u_nxt, u_len   : unsigned(PLEN-1 downto 0);
  signal s_valid, s_ready   : std_logic;
  signal s_both,  s_last    : std_logic;

component myrom is 
generic( PLEN : natural := 10 );
port( i_clk : in  std_logic;
      i_adr : in  std_logic_vector(PLEN-1 downto 0);
      o_len : out std_logic_vector(PLEN-1 downto 0);
      o_dat : out std_logic_vector(7 downto 0) );
end component;

begin

  s_clk     <= ACLK;
  s_rst_n   <= ARESETN;
  s_ready   <= M_AXIS_TREADY;
  s_both    <= s_ready AND s_valid;

----------------------------------------------------------------------
  u_nxt  <= u_idx +1;
  s_last <= s_both when(u_len = u_nxt) else '0';
  
----------------------------------------------------------------------
idx_p : process(s_clk,s_rst_n)
  begin
    if (s_rst_n = '0') then
      u_idx   <= (others=>'0');
      u_adr   <= (others=>'0');
      s_valid <= '0';
    elsif (s_clk'event and s_clk = '1') then
      s_valid   <= '1';
      if (s_last = '1') then
        u_idx <= (others=>'0');
        u_adr <= (others=>'0');
        s_valid <= '0';
      elsif (s_both = '1') then
        u_idx <= u_nxt;
        u_adr <= u_nxt;
      end if;
    end if;
  end process;

----------------------------------------------------------------------
rom0 : myrom
  generic map ( PLEN => PLEN )
  port map( 
    i_clk => s_clk,
    i_adr => std_logic_vector(u_adr),
    unsigned(o_len) => u_len,
    o_dat => s_dat);

----------------------------------------------------------------------
dat_p : process(s_clk,s_rst_n)
  begin
    if (s_rst_n = '0') then
      M_AXIS_TDATA <= (others=>'0');
    elsif (s_clk'event and s_clk = '1') then
      M_AXIS_TDATA  <= s_dat;
    end if;
  end process;

  M_AXIS_TVALID <= s_valid;
  M_AXIS_TLAST  <= s_last;

end architecture_rom2axi8s;
