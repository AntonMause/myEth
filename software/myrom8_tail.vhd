
-- tail -- tail -- tail -- tail -- tail -- tail -- tail -- tail -- tail -- 
signal s_adr : std_logic_vector(PLEN-1 downto 0);
signal s_out : std_logic_vector(7 downto 0);

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

  o_len <= std_logic_vector(to_unsigned(s_len,PLEN));
  o_dat <= s_out;

end rtl;
