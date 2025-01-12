LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.math_real.ALL;
USE STD.textio.ALL;
USE std.env.finish;
ENTITY generatortb IS
	GENERIC (
		N : NATURAL := 45;
		P : NATURAL := 41;
		no : NATURAL := 125000 -- to generate no * 8 bits
	);
END generatortb;

ARCHITECTURE behavior OF generatortb IS

	COMPONENT generator
		GENERIC (
			N : NATURAL := N;
			p : NATURAL := P
		);
		PORT (
			x0 : IN unsigned(N - 1 DOWNTO 0);
			enable, clk, reset : IN std_logic;
			xout : OUT unsigned(7 DOWNTO 0)
		);
	END COMPONENT;
	SIGNAL x0 : unsigned(N - 1 DOWNTO 0) := "000010000000000010000000000000000000000000000";
	SIGNAL clk, reset, enable : std_logic := '1';

	SIGNAL xout : unsigned(7 DOWNTO 0);

	CONSTANT clk_period : TIME := 10 ns;
	SIGNAL data_char : STD_LOGIC_VECTOR(15 DOWNTO 0);

	TYPE character_file IS FILE OF INTEGER;
	FILE myfile : character_file;

	FILE Write_File : text OPEN Write_mode IS "bitstream";
BEGIN
	uut : generator
	PORT MAP(
		x0 => x0, 
		enable => enable, 
		clk => clk, 
		reset => reset, 
		xout => xout
	);
	clk_process : PROCESS
	BEGIN
		clk <= '0';
		WAIT FOR clk_period/2;
		clk <= '1';
		WAIT FOR clk_period/2;
	END PROCESS;

	stim_proc : PROCESS
		VARIABLE character_variable : CHARACTER;
		VARIABLE out_line : line;
	BEGIN
		WAIT FOR 2 * clk_period;
		reset <= '0';
		FOR J IN 0 TO no - 1 LOOP

			WAIT FOR clk_period;

			write(Write_File, to_string(xout));
		END LOOP;
		file_close(myfile);
		file_close(Write_File);
		WAIT FOR 2 * clk_period;
		finish;
	END PROCESS;

END;