LIBRARY IEEE;
	USE IEEE.STD_LOGIC_1164.ALL;
	USE IEEE.STD_LOGIC_UNSIGNED.ALL;
	USE IEEE.NUMERIC_STD.ALL;

ENTITY CONTROL IS
	PORT (
		CLK			:IN STD_LOGIC;
		INIT			:IN STD_LOGIC;
		WR				:IN STD_LOGIC;
		RD				:IN STD_LOGIC;
		ADDR_WR		:IN STD_LOGIC_VECTOR(31 downto 0);
		DRL_ASCD		:IN STD_LOGIC;
		DRL_PTX		:IN STD_LOGIC;
		TAG_CTR		:IN STD_LOGIC_VECTOR(7 downto 0);
		TAG_INTVL	:IN STD_LOGIC_VECTOR(15 downto 0);
		TAG_LEN		:IN STD_LOGIC_VECTOR(7 downto 0);
		
		WR_PTX		:OUT STD_LOGIC;
		WR_ASCD		:OUT STD_LOGIC;
		WR_CTX		:OUT STD_LOGIC;
		WR_TAG		:OUT STD_LOGIC;
		RD_PTX		:OUT STD_LOGIC;
		RD_ASCD		:OUT STD_LOGIC;
		RD_PARAMS	:OUT STD_LOGIC;
		RD_CTX		:OUT STD_LOGIC;
		RD_TAG		:OUT STD_LOGIC;
		WR_L			:OUT STD_LOGIC;
		DBL_L			:OUT STD_LOGIC;
		DBL_L1		:OUT STD_LOGIC;
		DBL_L2		:OUT STD_LOGIC;
		WR_IV			:OUT STD_LOGIC;
		RD_L			:OUT STD_LOGIC;
		RD_L1			:OUT STD_LOGIC;
		WR_RO			:OUT STD_LOGIC;
		LOAD_IV		:OUT STD_LOGIC;
		INIT_EK1		:OUT STD_LOGIC;
		INIT_EK3		:OUT STD_LOGIC;
		
		RUN_EK1		:OUT STD_LOGIC;
		RUN_EK3		:OUT STD_LOGIC
	);
END ENTITY;

ARCHITECTURE ARCH_CONTROL OF CONTROL IS
	SIGNAL COUNTER_ASCD	:STD_LOGIC_VECTOR(7 downto 0);
	SIGNAL COUNTER_PTX	:STD_LOGIC_VECTOR(7 downto 0);
	SIGNAL COUNTER_CTX	:STD_LOGIC_VECTOR(7 downto 0);
	SIGNAL TAG_CTR_VAL	:STD_LOGIC_VECTOR(7 downto 0);
	SIGNAL RUN_ENC_CTX	:STD_LOGIC := '0';
	SIGNAL WR_TAG_FL		:STD_LOGIC := '0';
BEGIN
	PROCESS(CLK, INIT)
	BEGIN
		IF INIT = '1' THEN
			COUNTER_ASCD	<= (OTHERS => '0');
			COUNTER_PTX		<= (OTHERS => '0');
			COUNTER_CTX		<= (OTHERS => '0');
			TAG_CTR_VAL		<= (OTHERS => '0');
			RUN_ENC_CTX		<= '0';
			WR_TAG_FL		<= '0';
		ELSIF CLK = '1' AND CLK'EVENT THEN
			IF (WR = '1' AND ADDR_WR = X"FFFFFFFF") OR COUNTER_ASCD /= X"0" THEN
				IF COUNTER_ASCD /= X"8B" AND COUNTER_ASCD /= X"FF" THEN
					COUNTER_ASCD	<= COUNTER_ASCD + 1;
				END IF;
				IF COUNTER_ASCD = X"8B" THEN
					COUNTER_ASCD	<= X"5D";
				END IF;
				IF COUNTER_ASCD = X"8B" AND DRL_ASCD = '0' THEN
					COUNTER_ASCD	<= X"FF";
				END IF;
				
				IF COUNTER_ASCD = X"FF" AND COUNTER_PTX /= X"2F" AND COUNTER_PTX /= X"FF" THEN
					COUNTER_PTX	<= COUNTER_PTX + 1;
				END IF;
				IF COUNTER_PTX = X"29" THEN -- START CTX BEFORE PTX ENDS
					RUN_ENC_CTX	<= '1';
				END IF;
				IF COUNTER_PTX = X"2F" THEN
					COUNTER_PTX	<= X"01";
				END IF;
				IF COUNTER_PTX = X"2F" AND DRL_PTX = '0' THEN
					COUNTER_PTX	<= X"FF";
				END IF;
				
				IF RUN_ENC_CTX = '1' AND COUNTER_CTX /= X"FF" THEN
					COUNTER_CTX	<= COUNTER_CTX + 1;
				END IF;
				IF COUNTER_CTX = X"2F" THEN
					COUNTER_CTX	<= X"01";
				END IF;
				IF COUNTER_PTX = X"FF" AND DRL_PTX = '0' AND COUNTER_CTX = X"2F" THEN
					COUNTER_CTX	<= X"FF";
				END IF;
				
				IF (COUNTER_CTX = X"2E" AND (TAG_CTR(7 downto 2)-1 = TAG_CTR_VAL + TAG_INTVL))
				OR (COUNTER_CTX = X"2E" AND COUNTER_PTX = X"FF" AND (TAG_CTR(7 downto 2)-1 = TAG_CTR_VAL + TAG_INTVL)) THEN
					WR_TAG_FL	<= '1';
					TAG_CTR_VAL	<= TAG_CTR_VAL + TAG_INTVL(7 downto 0);
				ELSE
					WR_TAG_FL	<= '0';
				END IF;
			END IF;
		END IF;
	END PROCESS;
	
	RUN_EK1		<= '1'
						WHEN (COUNTER_ASCD >= X"01" AND COUNTER_ASCD <= X"2E") -- GENERATE L
						  OR (COUNTER_ASCD >= X"30" AND COUNTER_ASCD <= X"5C") -- ENCRYPT PARAMS
						  OR (COUNTER_ASCD >= X"5E" AND COUNTER_ASCD <= X"8A") -- ENCRYPT ASCD
						  OR (COUNTER_PTX >= X"02" AND COUNTER_PTX <= X"2F") -- ENCRYPT PTX
						ELSE '0';
	INIT_EK1		<= '1'
						WHEN COUNTER_ASCD = X"00"
						  OR COUNTER_ASCD = X"2F"
						  OR COUNTER_ASCD = X"5D"
						  OR COUNTER_PTX = X"01"
						ELSE '0';
	WR_L			<= '1'
						WHEN COUNTER_ASCD = X"2E"
						ELSE '0';
	RD_PARAMS	<= '1'
						WHEN COUNTER_ASCD = X"33"
						ELSE '0';
	WR_IV			<= '1'
						WHEN (COUNTER_ASCD = X"5C" AND DRL_ASCD = '1')
						  OR COUNTER_ASCD = X"8A"
						ELSE '0';
	DBL_L1		<= '1'
						WHEN COUNTER_ASCD = X"5C"
						  OR COUNTER_ASCD = X"8A"
						ELSE '0';
	RD_ASCD		<= '1'
						WHEN COUNTER_ASCD = X"5F" AND DRL_ASCD = '1'
						ELSE '0';
	RD_PTX		<= '1'
						WHEN DRL_PTX = '1' AND DRL_ASCD = '0' AND COUNTER_PTX = X"03"
						ELSE '0';
	LOAD_IV		<= '1'
						WHEN COUNTER_ASCD = X"5D" OR COUNTER_ASCD = X"8B"
						ELSE '0';
	WR_RO			<= '1'
						WHEN COUNTER_PTX = X"2F"
						ELSE '0';
	DBL_L			<= '1'
						WHEN COUNTER_PTX = X"01"
						ELSE '0';
	DBL_L2		<= '1'
						WHEN COUNTER_CTX = X"01"
						  OR (COUNTER_CTX = X"20" AND (TAG_CTR(7 downto 2)-1 = TAG_CTR_VAL + TAG_INTVL))
						  OR (COUNTER_CTX = X"20" AND COUNTER_PTX = X"FF" AND (TAG_CTR(7 downto 2)-1 = TAG_CTR_VAL + TAG_INTVL))
						ELSE '0';
	RUN_EK3		<= '1'
						WHEN COUNTER_CTX >= X"01" AND COUNTER_CTX <= X"2E"
						ELSE '0';
	INIT_EK3		<= '1'
						WHEN COUNTER_PTX = X"2B"
						ELSE '0';
	WR_CTX		<= '1'
						WHEN COUNTER_CTX = X"2E"
						ELSE '0';
	WR_TAG		<= WR_TAG_FL;
						
						
	RD_L1			<= '1'
						WHEN COUNTER_ASCD = X"33" OR COUNTER_ASCD = X"61"
						ELSE '0';
	RD_L			<= '1'
						WHEN COUNTER_ASCD = X"FF" --DRL_PTX = '1' AND DRL_ASCD = '0'
						ELSE '0';
	WR_PTX		<= '1'
						WHEN WR = '1' AND (ADDR_WR = X"11111111" OR ADDR_WR = X"55555555")
						ELSE '0';
	WR_ASCD		<= '1'
						WHEN WR = '1' AND ADDR_WR = X"22222222"
						ELSE '0';
	RD_CTX		<= '1'
						WHEN RD = '1' AND ADDR_WR = X"33333333"
						ELSE '0';
	RD_TAG		<= '1'
						WHEN RD = '1' AND ADDR_WR = X"44444444"
						ELSE '0';
END ARCHITECTURE;