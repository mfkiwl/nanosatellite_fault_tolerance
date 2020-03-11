library IEEE;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity P2S is
	Generic(
		p_w_SIZE	: integer := 16
	);
	Port(
		i_DATA		: in STD_LOGIC_VECTOR((p_w_SIZE-1) DOWNTO 0);
		i_ND_OUT		: in STD_LOGIC;
		i_CLK			: in STD_LOGIC;
		i_EN			: in STD_LOGIC;
		i_RST			: in STD_LOGIC;
		o_DATA		: out STD_LOGIC
	);
end P2S;

architecture ps of P2S is

	signal w_RELEASE	: STD_LOGIC;
	signal w_REG		: STD_LOGIC_VECTOR((p_w_SIZE-1) DOWNTO 0);

begin
	
	-- COLOCA O DADO PRO FORA
	process(i_CLK, i_RST)
	begin
		if(i_RST =  '0') then
			w_RELEASE	<= '0';
		elsif rising_edge(i_CLK) then
			if(i_EN = '1') then
				o_DATA		<= w_REG(p_w_SIZE-1);
				w_RELEASE	<= '1';
			else
				w_RELEASE	<= '0';
			end if;
		end if;
	end process;
	
	-- SHIFT REGISTER
	process(i_CLK)
	begin
		if falling_edge(i_CLK) then
			if(i_ND_OUT = '1') then
				w_REG		<= i_DATA;
			else
				if(w_RELEASE = '1') then
					w_REG	<= w_REG((p_w_SIZE-2) DOWNTO 0)& '0';
				end if;
			end if;
		end if;
	end process;

end ps;