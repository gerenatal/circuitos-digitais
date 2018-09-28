library ieee;
use ieee.std_logic_1164.all;

entity flipflopJK is
port(
	J, K, clk, clr, set	:	in std_logic;
	Q, Qbar	:	out std_logic
);
end flipflopJK;

architecture flipflopJK of flipflopJK is
signal qsignal	: std_logic;
begin
	process (clk, clr, set)
	begin
		if(clr='0') then
			qsignal <= '0';
		elsif (set='0') then
			qsignal <='1';
		elsif(clk'event and clk='0') then
			if(J='0' and K='1') then
				qsignal <='1';
			elsif (J='1' and K='0') then
				qsignal <= '0';
			elsif(J='0' and K='0') then
				qsignal <= not qsignal;
			end if;
		end if;
	end process;
Q <= qsignal;
Qbar <= not qsignal;
end flipflopJK;