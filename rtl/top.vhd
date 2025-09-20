-- rtl/top.vhd (tiny stub with no functionality; use only to test CI flow)
library ieee;
use ieee.std_logic_1164.all;

entity top is
  port (
    clk : in std_logic := '0';
    rst : in std_logic := '0'
  );
end entity;

architecture rtl of top is
begin
  -- empty; purely to exercise GHDL analysis/elaboration
  process(clk, rst)
  begin
    if rst = '1' then
      null;
    elsif rising_edge(clk) then
      null;
    end if;
  end process;
end architecture;
