LIBRARY IEEE;
	USE IEEE.STD_LOGIC_1164.ALL;
	USE IEEE.NUMERIC_STD.ALL;

ENTITY PTX_MEMORY_TB IS END ENTITY;

ARCHITECTURE ARCH_PTX_MEMORY_TB OF PTX_MEMORY_TB IS
	COMPONENT PTX_MEMORY IS PORT
	(
		CLK		:IN STD_LOGIC;
	INIT		:IN STD_LOGIC;
	STORE		:IN STD_LOGIC;
	LOAD		:IN STD_LOGIC;
	DIN		:IN STD_LOGIC_VECTOR(31 DOWNTO 0);
	
	DRL		:OUT STD_LOGIC;
	PTX_CTR	:OUT STD_LOGIC_VECTOR(7 downto 0);
	TAG_CTR	:OUT STD_LOGIC_VECTOR(7 downto 0);
	DOUT		:OUT STD_LOGIC_VECTOR(127 DOWNTO 0)	);
	END COMPONENT;

	SIGNAL CLK		: STD_LOGIC := '0';
	SIGNAL INIT		: STD_LOGIC := '0';
	SIGNAL STORE		: STD_LOGIC := '0';
	SIGNAL LOAD		: STD_LOGIC := '0';
	SIGNAL DIN		: STD_LOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => '0');
	SIGNAL DRL		: STD_LOGIC := '0';
	SIGNAL PTX_CTR	: STD_LOGIC_VECTOR(7 downto 0) := (OTHERS => '0');
	SIGNAL TAG_CTR	: STD_LOGIC_VECTOR(7 downto 0) := (OTHERS => '0');
	SIGNAL DOUT		: STD_LOGIC_VECTOR(127 DOWNTO 0) := (OTHERS => '0');
	
	SIGNAL CLKp :time := 40 ns;
BEGIN
	tb: PTX_MEMORY PORT MAP (CLK, INIT, STORE, LOAD, DIN, DRL, PTX_CTR, TAG_CTR, DOUT);

	PROCESS
	BEGIN
		CLK <= '0'; wait for CLKp / 2;
		CLK <= '1'; wait for CLKp / 2;
	END PROCESS;

	PROCESS
	BEGIN
		INIT <= '1'; STORE <= '0'; LOAD <= '0'; DIN <= X"00000000"; wait for CLKp;
		INIT <= '0'; STORE <= '1'; LOAD <= '0'; DIN <= X"11111111"; wait for CLKp;
		INIT <= '0'; STORE <= '1'; LOAD <= '0'; DIN <= X"22222222"; wait for CLKp;
		INIT <= '0'; STORE <= '1'; LOAD <= '0'; DIN <= X"11111111"; wait for CLKp;
		INIT <= '0'; STORE <= '1'; LOAD <= '0'; DIN <= X"11111111"; wait for CLKp;
		INIT <= '0'; STORE <= '1'; LOAD <= '0'; DIN <= X"11111111"; wait for CLKp;
		INIT <= '0'; STORE <= '1'; LOAD <= '0'; DIN <= X"11111111"; wait for CLKp;
		INIT <= '0'; STORE <= '1'; LOAD <= '0'; DIN <= X"FFFFFFFF"; wait for CLKp;
		INIT <= '0'; STORE <= '0'; LOAD <= '1'; DIN <= X"00000000"; wait for CLKp;

		wait;
	END PROCESS;
END ARCHITECTURE;