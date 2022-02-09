-------------------------------------------------------------------------------
-- crc32x8.vhd
-------------------------------------------------------------------------------
-- lfsr(31:0)=1+x^1+x^2+x^4+x^5+x^7+x^8+x^10+x^11+x^12+x^16+x^22+x^23+x^26+x^32;
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-------------------------------------------------------------------------------
entity crc32x8 is port ( 
    i_dat : in std_logic_vector (7 downto 0);
    i_crc : in std_logic_vector (31 downto 0);
    o_crc : out std_logic_vector (31 downto 0));
end crc32x8;

-------------------------------------------------------------------------------
architecture rtl of crc32x8 is
  signal xor0, xor1, xor2, xor3, xor4, xor5, xor6, xor7, xor8 : std_logic_vector (31 downto 0);
  signal crc0, crc1, crc2, crc3, crc4, crc5, crc6, crc7, crc8 : unsigned (31 downto 0);
  signal poly : std_logic_vector (31 downto 0) := x"EDB88320";
begin

    xor0 <= i_crc xor (x"000000" & i_dat);
    crc0 <= unsigned(xor0); 
    
    xor1 <= poly when  (crc0(0) = '1') else (others=>'0'); 
    crc1 <= shift_right(crc0,1) xor unsigned(xor1);

    xor2 <= poly when  (crc1(0) = '1') else (others=>'0');
    crc2 <= shift_right(crc1,1) xor unsigned(xor2);

    xor3 <= poly when  (crc2(0) = '1') else (others=>'0');
    crc3 <= shift_right(crc2,1) xor unsigned(xor3);

    xor4 <= poly when  (crc3(0) = '1') else (others=>'0');
    crc4 <= shift_right(crc3,1) xor unsigned(xor4);

    xor5 <= poly when  (crc4(0) = '1') else (others=>'0');
    crc5 <= shift_right(crc4,1) xor unsigned(xor5);

    xor6 <= poly when  (crc5(0) = '1') else (others=>'0');
    crc6 <= shift_right(crc5,1) xor unsigned(xor6);

    xor7 <= poly when  (crc6(0) = '1') else (others=>'0');
    crc7 <= shift_right(crc6,1) xor unsigned(xor7);

    xor8 <= poly when  (crc7(0) = '1') else (others=>'0');
    crc8 <= shift_right(crc7,1) xor unsigned(xor8);

    o_crc <= std_logic_vector(crc8);

end architecture rtl;