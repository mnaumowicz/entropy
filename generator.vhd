LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE IEEE.std_logic_unsigned.ALL;
ENTITY generator IS
	GENERIC (
		N : NATURAL := 45;
		p : NATURAL := 41
	);
	PORT (
		x0 : IN unsigned(N - 1 DOWNTO 0);
		enable, clk, reset : IN std_logic;
		xout : OUT unsigned(7 DOWNTO 0)
	);
END generator;

ARCHITECTURE Flow OF generator IS
	SIGNAL xn : unsigned(N - 1 DOWNTO 0) := (OTHERS => '0');
	SIGNAL t1 : unsigned(N - 1 DOWNTO 0) := (OTHERS => '0');
	SIGNAL t2 : unsigned(2 * N - 1 DOWNTO 0) := (OTHERS => '0');
	SIGNAL t3 : unsigned(3 * N - 1 DOWNTO 0) := (OTHERS => '0');
BEGIN
	PROCESS (clk, reset, x0, enable)
	BEGIN
		IF rising_edge(clk) THEN
			IF (reset) THEN
				xn <= x0;
			ELSIF (enable) THEN
				xn <= t3(N + 2 * p - 1 DOWNTO 2 * p);
			END IF;
 
		END IF;
	END PROCESS;

	t3 <= ("001111111111111111111111111111111111111111111" * xn) * ("000100000000000000000000000000000000000000000" - xn);
	xout <= xn(8 DOWNTO 1);

END Flow;