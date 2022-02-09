
-- tail -- tail -- tail -- tail -- tail -- tail -- tail -- tail -- tail -- 
    others=>x"0000" );
signal s_adr : std_logic_vector(PLEN-1 downto 0);
signal s_out : std_logic_vector(15 downto 0);

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

--  o_dat <= s_out;
  o_dat <= s_out(7 downto 0) & s_out(15 downto 8);
  
end rtl;