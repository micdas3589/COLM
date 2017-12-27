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
		RD	: IN STD_LOGIC;
		ADDR_WR :  IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
		DIN :  IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
		DOUT :  OUT  STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
	END COMPONENT;

	SIGNAL CLK :   STD_LOGIC := '0';
	SIGNAL INIT :    STD_LOGIC := '0';
	SIGNAL WR :    STD_LOGIC := '0';
	SIGNAL RD	: STD_LOGIC := '0';
	SIGNAL ADDR_WR :    STD_LOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => '0');
	SIGNAL DIN :    STD_LOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => '0');
	SIGNAL DOUT :    STD_LOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => '0');
	
	SIGNAL CLKp :time := 40 ns;
BEGIN
	tb: COLM PORT MAP (CLK, INIT, WR, RD, ADDR_WR, DIN, DOUT);

	PROCESS
	BEGIN
		CLK <= '0'; wait for CLKp / 2;
		CLK <= '1'; wait for CLKp / 2;
	END PROCESS;

	PROCESS
	BEGIN
--		INIT <= '1'; WR <= '0'; RD <= '0'; ADDR_WR <= X"00000000"; DIN <= X"00000000"; wait for CLKp;
--		INIT <= '0'; WR <= '1'; RD <= '0'; ADDR_WR <= X"00000000"; DIN <= X"00112233"; wait for CLKp;
--		INIT <= '0'; WR <= '1'; RD <= '0'; ADDR_WR <= X"00000001"; DIN <= X"44556677"; wait for CLKp;
--		INIT <= '0'; WR <= '1'; RD <= '0'; ADDR_WR <= X"00000002"; DIN <= X"8899aabb"; wait for CLKp;
--		INIT <= '0'; WR <= '1'; RD <= '0'; ADDR_WR <= X"00000003"; DIN <= X"ccddeeff"; wait for CLKp;
--		INIT <= '0'; WR <= '1'; RD <= '0'; ADDR_WR <= X"00000004"; DIN <= X"11111111"; wait for CLKp;
--		INIT <= '0'; WR <= '1'; RD <= '0'; ADDR_WR <= X"00000005"; DIN <= X"22222222"; wait for CLKp;
--		INIT <= '0'; WR <= '1'; RD <= '0'; ADDR_WR <= X"00000006"; DIN <= X"00028000"; wait for CLKp;
--		INIT <= '0'; WR <= '1'; RD <= '0'; ADDR_WR <= X"00000007"; DIN <= X"00000000"; wait for CLKp;
--		INIT <= '0'; WR <= '1'; RD <= '0'; ADDR_WR <= X"22222222"; DIN <= X"00000001"; wait for CLKp;
--		INIT <= '0'; WR <= '1'; RD <= '0'; ADDR_WR <= X"22222222"; DIN <= X"00000002"; wait for CLKp;
--		INIT <= '0'; WR <= '1'; RD <= '0'; ADDR_WR <= X"22222222"; DIN <= X"00000003"; wait for CLKp;
--		INIT <= '0'; WR <= '1'; RD <= '0'; ADDR_WR <= X"22222222"; DIN <= X"00000004"; wait for CLKp;
--		INIT <= '0'; WR <= '1'; RD <= '0'; ADDR_WR <= X"11111111"; DIN <= X"00000000"; wait for CLKp;
--		INIT <= '0'; WR <= '1'; RD <= '0'; ADDR_WR <= X"11111111"; DIN <= X"10000000"; wait for CLKp;
--		INIT <= '0'; WR <= '1'; RD <= '0'; ADDR_WR <= X"11111111"; DIN <= X"20000000"; wait for CLKp;
--		INIT <= '0'; WR <= '1'; RD <= '0'; ADDR_WR <= X"11111111"; DIN <= X"30000000"; wait for CLKp;
--		INIT <= '0'; WR <= '1'; RD <= '0'; ADDR_WR <= X"11111111"; DIN <= X"40000000"; wait for CLKp;
--		INIT <= '0'; WR <= '1'; RD <= '0'; ADDR_WR <= X"11111111"; DIN <= X"50000000"; wait for CLKp;
--		INIT <= '0'; WR <= '1'; RD <= '0'; ADDR_WR <= X"11111111"; DIN <= X"60000000"; wait for CLKp;
--		INIT <= '0'; WR <= '1'; RD <= '0'; ADDR_WR <= X"11111111"; DIN <= X"70000000"; wait for CLKp;
--		INIT <= '0'; WR <= '1'; RD <= '0'; ADDR_WR <= X"11111111"; DIN <= X"80000000"; wait for CLKp;
--		INIT <= '0'; WR <= '1'; RD <= '0'; ADDR_WR <= X"11111111"; DIN <= X"90000000"; wait for CLKp;
--		INIT <= '0'; WR <= '1'; RD <= '0'; ADDR_WR <= X"11111111"; DIN <= X"A0000000"; wait for CLKp;
--		INIT <= '0'; WR <= '1'; RD <= '0'; ADDR_WR <= X"11111111"; DIN <= X"B0000000"; wait for CLKp;
--		INIT <= '0'; WR <= '1'; RD <= '0'; ADDR_WR <= X"11111111"; DIN <= X"C0000000"; wait for CLKp;
--		INIT <= '0'; WR <= '1'; RD <= '0'; ADDR_WR <= X"11111111"; DIN <= X"D0000000"; wait for CLKp;
--		INIT <= '0'; WR <= '1'; RD <= '0'; ADDR_WR <= X"11111111"; DIN <= X"E0000000"; wait for CLKp;
--		INIT <= '0'; WR <= '1'; RD <= '0'; ADDR_WR <= X"11111111"; DIN <= X"F0000000"; wait for CLKp;
--		INIT <= '0'; WR <= '1'; RD <= '0'; ADDR_WR <= X"FFFFFFFF"; DIN <= X"00000000"; wait for CLKp;
--		INIT <= '0'; WR <= '0'; RD <= '0'; ADDR_WR <= X"00000000"; DIN <= X"00000000"; wait for 370*CLKp;
--		INIT <= '0'; WR <= '0'; RD <= '1'; ADDR_WR <= X"33333333"; DIN <= X"00000000"; wait for 16*CLKp;
--		INIT <= '0'; WR <= '0'; RD <= '1'; ADDR_WR <= X"44444444"; DIN <= X"00000000"; wait for 8*CLKp;
--		INIT <= '0'; WR <= '0'; RD <= '0'; ADDR_WR <= X"00000000"; DIN <= X"00000000"; wait for CLKp;

		INIT <= '1'; WR <= '0'; RD <= '0'; ADDR_WR <= X"00000000"; DIN <= X"00000000"; wait for CLKp;
		INIT <= '0'; WR <= '1'; RD <= '0'; ADDR_WR <= X"00000000"; DIN <= X"55565758"; wait for CLKp;
		INIT <= '0'; WR <= '1'; RD <= '0'; ADDR_WR <= X"00000001"; DIN <= X"595A5B5C"; wait for CLKp;
		INIT <= '0'; WR <= '1'; RD <= '0'; ADDR_WR <= X"00000002"; DIN <= X"5D5E5F60"; wait for CLKp;
		INIT <= '0'; WR <= '1'; RD <= '0'; ADDR_WR <= X"00000003"; DIN <= X"61626364"; wait for CLKp;
		INIT <= '0'; WR <= '1'; RD <= '0'; ADDR_WR <= X"00000004"; DIN <= X"B0B1B2B3"; wait for CLKp;
		INIT <= '0'; WR <= '1'; RD <= '0'; ADDR_WR <= X"00000005"; DIN <= X"B4B5B6B7"; wait for CLKp;
		INIT <= '0'; WR <= '1'; RD <= '0'; ADDR_WR <= X"00000006"; DIN <= X"00008000"; wait for CLKp;
		INIT <= '0'; WR <= '1'; RD <= '0'; ADDR_WR <= X"00000007"; DIN <= X"00000000"; wait for CLKp;
		INIT <= '0'; WR <= '1'; RD <= '0'; ADDR_WR <= X"22222222"; DIN <= X"A0A1A2A3"; wait for CLKp;
		INIT <= '0'; WR <= '1'; RD <= '0'; ADDR_WR <= X"22222222"; DIN <= X"A4A5A6A7"; wait for CLKp;
		INIT <= '0'; WR <= '1'; RD <= '0'; ADDR_WR <= X"22222222"; DIN <= X"A8A9AAAB"; wait for CLKp;
		INIT <= '0'; WR <= '1'; RD <= '0'; ADDR_WR <= X"22222222"; DIN <= X"ACADAEAF"; wait for CLKp;
		INIT <= '0'; WR <= '1'; RD <= '0'; ADDR_WR <= X"22222222"; DIN <= X"B0B1B2B3"; wait for CLKp;
		INIT <= '0'; WR <= '1'; RD <= '0'; ADDR_WR <= X"22222222"; DIN <= X"B4B5B6B7"; wait for CLKp;
		INIT <= '0'; WR <= '1'; RD <= '0'; ADDR_WR <= X"22222222"; DIN <= X"B8B9BABB"; wait for CLKp;
		INIT <= '0'; WR <= '1'; RD <= '0'; ADDR_WR <= X"22222222"; DIN <= X"BCBDBEBF"; wait for CLKp;
		
		INIT <= '0'; WR <= '1'; RD <= '0'; ADDR_WR <= X"11111111"; DIN <= X"FF000102"; wait for CLKp;
		INIT <= '0'; WR <= '1'; RD <= '0'; ADDR_WR <= X"11111111"; DIN <= X"03040506"; wait for CLKp;
		INIT <= '0'; WR <= '1'; RD <= '0'; ADDR_WR <= X"11111111"; DIN <= X"0708090A"; wait for CLKp;
		INIT <= '0'; WR <= '1'; RD <= '0'; ADDR_WR <= X"11111111"; DIN <= X"0B0C0D0E"; wait for CLKp;
		INIT <= '0'; WR <= '1'; RD <= '0'; ADDR_WR <= X"11111111"; DIN <= X"0F101112"; wait for CLKp;
		INIT <= '0'; WR <= '1'; RD <= '0'; ADDR_WR <= X"11111111"; DIN <= X"13141516"; wait for CLKp;
		INIT <= '0'; WR <= '1'; RD <= '0'; ADDR_WR <= X"11111111"; DIN <= X"1718191A"; wait for CLKp;
		INIT <= '0'; WR <= '1'; RD <= '0'; ADDR_WR <= X"11111111"; DIN <= X"1B1C1D1E"; wait for CLKp;
		INIT <= '0'; WR <= '1'; RD <= '0'; ADDR_WR <= X"11111111"; DIN <= X"00000000"; wait for CLKp;
		INIT <= '0'; WR <= '1'; RD <= '0'; ADDR_WR <= X"11111111"; DIN <= X"00000000"; wait for CLKp;
		INIT <= '0'; WR <= '1'; RD <= '0'; ADDR_WR <= X"11111111"; DIN <= X"00000000"; wait for CLKp;
		INIT <= '0'; WR <= '1'; RD <= '0'; ADDR_WR <= X"11111111"; DIN <= X"00000000"; wait for CLKp;

		INIT <= '0'; WR <= '1'; RD <= '0'; ADDR_WR <= X"FFFFFFFF"; DIN <= X"00000000"; wait for CLKp;
		INIT <= '0'; WR <= '0'; RD <= '0'; ADDR_WR <= X"00000000"; DIN <= X"00000000"; wait for 370*CLKp;
		INIT <= '0'; WR <= '0'; RD <= '1'; ADDR_WR <= X"33333333"; DIN <= X"00000000"; wait for 16*CLKp;
		INIT <= '0'; WR <= '0'; RD <= '1'; ADDR_WR <= X"44444444"; DIN <= X"00000000"; wait for 8*CLKp;
		INIT <= '0'; WR <= '0'; RD <= '0'; ADDR_WR <= X"00000000"; DIN <= X"00000000"; wait for CLKp;
		


		wait;
	END PROCESS;
END ARCHITECTURE;