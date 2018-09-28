library ieee;
use ieee.std_logic_1164.all;

entity contador is
port(
	clockcont, s, enable, reset : in std_logic;
	qc : out std_logic_vector(2 downto 0);
	d : out std_logic_vector(6 downto 0)
);
end contador;

architecture contador of contador is

component flipflopJK is
port(
	J, K, clk, clear, preset: in std_logic;
	Q, Qbar : out std_logic
);
end component;

signal ds : std_logic_vector(6 downto 0);
signal qs : std_logic_vector(2 downto 0);
signal js : std_logic_vector(2 downto 0);
signal ks : std_logic_vector(2 downto 0);

signal ja : std_logic_vector(2 downto 0);
signal ka : std_logic_vector(2 downto 0);
signal jb : std_logic_vector(2 downto 0);
signal kb : std_logic_vector(2 downto 0);

signal jd : std_logic_vector(2 downto 0);
signal kd : std_logic_vector(2 downto 0);
signal jc : std_logic_vector(2 downto 0);
signal kc : std_logic_vector(2 downto 0);

signal ss, es, rs : std_logic;

begin

	FF00 : flipflopJK port map (js(0), ks(0), clockcont, '1', '1', qs(0));
	FF01 : flipflopJK port map (js(1), ks(1), clockcont, '1', '1', qs(1));
	FF02 : flipflopJK port map (js(2), ks(2), clockcont, '1', '1', qs(2));
	
	ja(2) <= (not ss and jc(2)) or (ss and jd(2));
	ka(2) <= (not ss and kc(2)) or (ss and kd(2));
	ja(1) <= (not ss and jc(1)) or (ss and jd(1));
	ka(1) <= (not ss and kc(1)) or (ss and kd(1));
	ja(0) <= jc(0) or jd(0);
	ka(0) <= kc(0) or kd(0);
	
	js(2) <= not es or ja(2); --(not es and (rs or ja(2))) or (rs xor ja(2));
	ks(2) <= (not es and rs) or (es and ka(2)); --(not es and not rs) or (es and ka(2));
	js(1) <= not es or ja(1); --(not es and (rs or ja(1))) or (rs xor ja(1)); --not es or ja(1);
	ks(1) <= (not es and rs) or (es and ka(1)); --(not es and not rs) or (es and ka(1));
	js(0) <= not es or ja(0); --(not es and (rs or ja(0))) or (rs xor ja(0)); --not es or ja(0);
	ks(0) <= (not es and rs) or (es and ka(0)); --(not es and not rs) or (es and ka(0));

	jd(2) <= qs(2) or qs(1) or qs(0);
	kd(2) <= not qs(2) or qs(1) or qs(0);
	jd(1) <= not qs(1) and qs(0);
	kd(1) <= qs(1) and qs(0);
	jd(0) <= qs(0);
	kd(0) <= not qs(0);
	
	kc(2) <= not qs(2) or not qs(1) or  not qs(0);
	jc(2) <= qs(2) or not qs(1) or  not qs(0);
	kc(1) <= qs(1) and not qs(0);
	jc(1) <= not qs(1) and not qs(0);
	kc(0) <= not qs(0);
	jc(0) <= qs(0);
		
	qc <= qs;
	ss <= s;
	es <= enable;
	rs <= reset;
	
	ds(0) <= not( (qs(2) and qs(0)) or (not qs(2) and not qs(0)) or qs(1));
	ds(1) <= not( not qs(2) or (not qs(1) and not qs(0)) or (qs(1) and qs(0)));
	ds(2) <= not( qs(2) or not qs(1) or qs(0));
	ds(3) <= not( (qs(2) and not qs(1) and qs(0)) or (not qs(2) and not qs(0)) or (qs(1) and not qs(0)) or (not qs(2) and qs(1)));
	ds(4) <= not( (not qs(2) and not qs(0)) or (qs(1) and not qs(0)));
	ds(5) <= not( (not qs(1) and not qs(0)) or (qs(2) and not qs(0)) or (qs(2) and not qs(1)));
	ds(6) <= not( (qs(2) xor qs(1)) or (qs(0) and (qs(2) or qs(1))));
	d <= ds;
	
end contador;