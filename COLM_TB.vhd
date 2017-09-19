LIBRARY IEEE;
	USE IEEE.STD_LOGIC_1164.ALL;
	USE IEEE.NUMERIC_STD.ALL;

ENTITY COLM_TB IS END ENTITY;

ARCHITECTURE ARCH_COLM_TB OF COLM_TB IS
	COMPONENT COLM IS PORT
	(
		CLK :  IN  STD_LOGIC;
		INIT :  IN  STD_LOGIC;
		WR :  IN  STD_LOGIC;
		ADDR_WR :  IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
		DIN :  IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
		DOUT :  OUT  STD_LOGIC_VECTOR(127 DOWNTO 0)
	);
	END COMPONENT;

	SIGNAL CLK :   STD_LOGIC := '0';
	SIGNAL INIT :    STD_LOGIC := '0';
	SIGNAL WR :    STD_LOGIC := '0';
	SIGNAL ADDR_WR :    STD_LOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => '0');
	SIGNAL DIN :    STD_LOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => '0');
	SIGNAL DOUT :    STD_LOGIC_VECTOR(127 DOWNTO 0) := (OTHERS => '0');
	
	SIGNAL CLKp :time := 40 ns;
BEGIN
	tb: COLM PORT MAP (CLK, INIT, WR, ADDR_WR, DIN, DOUT);

	PROCESS
	BEGIN
		CLK <= '0'; wait for CLKp / 2;
		CLK <= '1'; wait for CLKp / 2;
	END PROCESS;

	PROCESS
	BEGIN
		INIT <= '1'; WR <= '0'; ADDR_WR <= X"00000000"; DIN <= X"00000000"; wait for CLKp;
		INIT <= '0'; WR <= '1'; ADDR_WR <= X"00000000"; DIN <= X"00112233"; wait for CLKp;
		INIT <= '0'; WR <= '1'; ADDR_WR <= X"00000001"; DIN <= X"44556677"; wait for CLKp;
		INIT <= '0'; WR <= '1'; ADDR_WR <= X"00000002"; DIN <= X"8899aabb"; wait for CLKp;
		INIT <= '0'; WR <= '1'; ADDR_WR <= X"00000003"; DIN <= X"ccddeeff"; wait for CLKp;
		INIT <= '0'; WR <= '1'; ADDR_WR <= X"00000004"; DIN <= X"11111111"; wait for CLKp;
		INIT <= '0'; WR <= '1'; ADDR_WR <= X"00000005"; DIN <= X"22222222"; wait for CLKp;
		INIT <= '0'; WR <= '1'; ADDR_WR <= X"00000006"; DIN <= X"33333333"; wait for CLKp;
		INIT <= '0'; WR <= '1'; ADDR_WR <= X"00000007"; DIN <= X"44444444"; wait for CLKp;
		INIT <= '0'; WR <= '1'; ADDR_WR <= X"22222222"; DIN <= X"00000001"; wait for CLKp;
		INIT <= '0'; WR <= '1'; ADDR_WR <= X"22222222"; DIN <= X"00000002"; wait for CLKp;
		INIT <= '0'; WR <= '1'; ADDR_WR <= X"22222222"; DIN <= X"00000003"; wait for CLKp;
		INIT <= '0'; WR <= '1'; ADDR_WR <= X"22222222"; DIN <= X"00000004"; wait for CLKp;
		INIT <= '0'; WR <= '1'; ADDR_WR <= X"11111111"; DIN <= X"10000000"; wait for CLKp;
		INIT <= '0'; WR <= '1'; ADDR_WR <= X"11111111"; DIN <= X"20000000"; wait for CLKp;
		INIT <= '0'; WR <= '1'; ADDR_WR <= X"11111111"; DIN <= X"30000000"; wait for CLKp;
		INIT <= '0'; WR <= '1'; ADDR_WR <= X"11111111"; DIN <= X"40000000"; wait for CLKp;
		INIT <= '0'; WR <= '1'; ADDR_WR <= X"11111111"; DIN <= X"50000000"; wait for CLKp;
		INIT <= '0'; WR <= '1'; ADDR_WR <= X"11111111"; DIN <= X"60000000"; wait for CLKp;
		INIT <= '0'; WR <= '1'; ADDR_WR <= X"11111111"; DIN <= X"70000000"; wait for CLKp;
		INIT <= '0'; WR <= '1'; ADDR_WR <= X"11111111"; DIN <= X"80000000"; wait for CLKp;
		INIT <= '0'; WR <= '1'; ADDR_WR <= X"FFFFFFFF"; DIN <= X"00000000"; wait for CLKp;
		INIT <= '0'; WR <= '0'; ADDR_WR <= X"00000000"; DIN <= X"00000000"; wait for 2000*CLKp;
		INIT <= '0'; WR <= '0'; ADDR_WR <= X"00000000"; DIN <= X"00000000"; wait for CLKp;
		
		wait;
	END PROCESS;
END ARCHITECTURE;