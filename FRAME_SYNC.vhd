library IEEE;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_1164.ALL;

entity FRAME_SYNC is
	Generic(
		p_w_SIZE		: integer := 16;
		p_r_COUNT	: integer := 4
	);
	Port(
		i_CLK			: in STD_lOGIC;
		i_RST			: in STD_LOGIC;
		o_FS			: out STD_LOGIC
	);
end FRAME_SYNC;

architecture fs of FRAME_SYNC is

begin

	process(i_RST, i_CLK)
		variable count : integer range 0 to (p_w_SIZE*p_r_COUNT)	:= 0;
	begin
		if(i_RST = '0') then
			o_FS	<= '0';
			count := 0;
		elsif rising_edge(i_CLK) then
			if(count = ((p_w_SIZE*p_r_COUNT)-1)) then
				count	:= count + 1;
				o_FS	<= '1';
			elsif(count = (p_w_SIZE*p_r_COUNT)) then
				count	:= 0;
				o_FS	<= '0';
			else
				count	:= count + 1;
			end if;
		end if;
	end process;

end fs;