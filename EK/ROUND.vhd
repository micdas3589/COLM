LIBRARY IEEE;
	USE IEEE.STD_LOGIC_1164.ALL;
	USE IEEE.STD_LOGIC_UNSIGNED.ALL;
	USE IEEE.NUMERIC_STD.ALL;

ENTITY ROUND IS
	PORT (
		CLK			:IN STD_LOGIC;
		INIT			:IN STD_LOGIC;
		RUN			:IN STD_LOGIC;
		STATE_IN		:IN STD_LOGIC_VECTOR(127 downto 0);
		ROUND_KEY	:IN STD_LOGIC_VECTOR(127 downto 0);
		STATE_OUT	:OUT STD_LOGIC_VECTOR(127 downto 0)
	);
END ENTITY;

ARCHITECTURE ARCH_ROUND OF ROUND IS
	TYPE MEMORY_BLOCK IS ARRAY (0 to 15) OF STD_LOGIC_VECTOR(0 to 127);
	CONSTANT SBOX	:MEMORY_BLOCK :=
	(
		 X"637c777bf26b6fc53001672bfed7ab76"
		,X"ca82c97dfa5947f0add4a2af9ca472c0"
		,X"b7fd9326363ff7cc34a5e5f171d83115"
		,X"04c723c31896059a071280e2eb27b275"
		,X"09832c1a1b6e5aa0523bd6b329e32f84"
		,X"53d100ed20fcb15b6acbbe394a4c58cf"
		,X"d0efaafb434d338545f9027f503c9fa8"
		,X"51a3408f929d38f5bcb6da2110fff3d2"
		,X"cd0c13ec5f974417c4a77e3d645d1973"
		,X"60814fdc222a908846eeb814de5e0bdb"
		,X"e0323a0a4906245cc2d3ac629195e479"
		,X"e7c8376d8dd54ea96c56f4ea657aae08"
		,X"ba78252e1ca6b4c6e8dd741f4bbd8b8a"
		,X"703eb5664803f60e613557b986c11d9e"
		,X"e1f8981169d98e949b1e87e9ce5528df"
		,X"8ca1890dbfe6426841992d0fb054bb16"
	);
	SIGNAL COUNTER 	:STD_LOGIC_VECTOR(3 downto 0) := (OTHERS => '0');
	SIGNAL STATE		:STD_LOGIC_VECTOR(127 downto 0) := (OTHERS => '0');
	SIGNAL ROUND_NR	: STD_LOGIC_VECTOR(3 downto 0) := (OTHERS => '0');
BEGIN
	PROCESS(CLK, INIT)
	BEGIN
		IF INIT = '1' THEN
			COUNTER	<= (OTHERS => '0');
			STATE		<= (OTHERS => '0');
			ROUND_NR	<= (OTHERS => '0');
		ELSIF CLK = '1' AND CLK'EVENT THEN
			IF RUN = '1' THEN
				COUNTER	<= COUNTER + 1;
			ELSE
				COUNTER	<= X"F";
			END IF;
		
			IF ROUND_NR = X"0" AND COUNTER = X"1" THEN
				STATE	<= STATE_IN XOR ROUND_KEY;
				ROUND_NR	<= ROUND_NR + 1;
				COUNTER	<= (OTHERS => '0');
			END IF;
			IF ROUND_NR > X"0" AND ROUND_NR < X"B" THEN
				IF COUNTER = X"0" THEN
					STATE(127 downto 120) <= SBOX(CONV_INTEGER(STATE(127 downto 124)))(CONV_INTEGER(STATE(123 downto 120) & "000") to CONV_INTEGER(STATE(123 downto 120) & "000")+7);
					STATE(119 downto 112) <= SBOX(CONV_INTEGER(STATE(119 downto 116)))(CONV_INTEGER(STATE(115 downto 112) & "000") to CONV_INTEGER(STATE(115 downto 112) & "000")+7);
					STATE(111 downto 104) <= SBOX(CONV_INTEGER(STATE(111 downto 108)))(CONV_INTEGER(STATE(107 downto 104) & "000") to CONV_INTEGER(STATE(107 downto 104) & "000")+7);
					STATE(103 downto  96) <= SBOX(CONV_INTEGER(STATE(103 downto 100)))(CONV_INTEGER(STATE(99  downto  96) & "000") to CONV_INTEGER(STATE(99  downto  96) & "000")+7);
					STATE(95  downto  88) <= SBOX(CONV_INTEGER(STATE(95  downto  92)))(CONV_INTEGER(STATE(91  downto  88) & "000") to CONV_INTEGER(STATE(91  downto  88) & "000")+7);
					STATE(87  downto  80) <= SBOX(CONV_INTEGER(STATE(87  downto  84)))(CONV_INTEGER(STATE(83  downto  80) & "000") to CONV_INTEGER(STATE(83  downto  80) & "000")+7);
					STATE(79  downto  72) <= SBOX(CONV_INTEGER(STATE(79  downto  76)))(CONV_INTEGER(STATE(75  downto  72) & "000") to CONV_INTEGER(STATE(75  downto  72) & "000")+7);
					STATE(71  downto  64) <= SBOX(CONV_INTEGER(STATE(71  downto  68)))(CONV_INTEGER(STATE(67  downto  64) & "000") to CONV_INTEGER(STATE(67  downto  64) & "000")+7);
					STATE(63  downto  56) <= SBOX(CONV_INTEGER(STATE(63  downto  60)))(CONV_INTEGER(STATE(59  downto  56) & "000") to CONV_INTEGER(STATE(59  downto  56) & "000")+7);
					STATE(55  downto  48) <= SBOX(CONV_INTEGER(STATE(55  downto  52)))(CONV_INTEGER(STATE(51  downto  48) & "000") to CONV_INTEGER(STATE(51  downto  48) & "000")+7);
					STATE(47  downto  40) <= SBOX(CONV_INTEGER(STATE(47  downto  44)))(CONV_INTEGER(STATE(43  downto  40) & "000") to CONV_INTEGER(STATE(43  downto  40) & "000")+7);
					STATE(39  downto  32) <= SBOX(CONV_INTEGER(STATE(39  downto  36)))(CONV_INTEGER(STATE(35  downto  32) & "000") to CONV_INTEGER(STATE(35  downto  32) & "000")+7);
					STATE(31  downto  24) <= SBOX(CONV_INTEGER(STATE(31  downto  28)))(CONV_INTEGER(STATE(27  downto  24) & "000") to CONV_INTEGER(STATE(27  downto  24) & "000")+7);
					STATE(23  downto  16) <= SBOX(CONV_INTEGER(STATE(23  downto  20)))(CONV_INTEGER(STATE(19  downto  16) & "000") to CONV_INTEGER(STATE(19  downto  16) & "000")+7);
					STATE(15  downto   8) <= SBOX(CONV_INTEGER(STATE(15  downto  12)))(CONV_INTEGER(STATE(11  downto   8) & "000") to CONV_INTEGER(STATE(11  downto   8) & "000")+7);
					STATE(7   downto   0) <= SBOX(CONV_INTEGER(STATE(7   downto   4)))(CONV_INTEGER(STATE(3   downto   0) & "000") to CONV_INTEGER(STATE(3   downto   0) & "000")+7);
				END IF;
				IF COUNTER = X"1" THEN
					STATE	<= STATE(127 downto 120) &
								STATE(87  downto  80) &
								STATE(47  downto  40) &
								STATE(7   downto   0) &
								STATE(95  downto  88) &
								STATE(55  downto  48) &
								STATE(15  downto   8) &
								STATE(103 downto  96) &
								STATE(63  downto  56) &
								STATE(23  downto  16) &
								STATE(111 downto 104) &
								STATE(71  downto  64) &
								STATE(31  downto  24) &
								STATE(119 downto 112) &
								STATE(79  downto  72) &
								STATE(39  downto  32);
				END IF;
				IF COUNTER = X"2" AND ROUND_NR /= X"A" THEN
					-- 127-96
					IF (STATE(127) XOR STATE(119)) = '1' THEN
						STATE(127 downto 120)	<= (STATE(126 downto 120) & '0') XOR (STATE(118 downto 112) & '0') XOR
														STATE(119 downto 112) XOR STATE(111 downto 104) XOR STATE(103 downto 96) XOR X"1B";
					ELSE
						STATE(127 downto 120)	<= (STATE(126 downto 120) & '0') XOR (STATE(118 downto 112) & '0') XOR
														STATE(119 downto 112) XOR STATE(111 downto 104) XOR STATE(103 downto 96);
					END IF;
					IF (STATE(119) XOR STATE(111)) = '1' THEN
						STATE(119 downto 112)	<= STATE(127 downto 120) XOR (STATE(118 downto 112) & '0') XOR (STATE(110 downto 104) & '0') XOR
														STATE(111 downto 104) XOR STATE(103 downto 96) XOR X"1B";
					ELSE
						STATE(119 downto 112)	<= STATE(127 downto 120) XOR (STATE(118 downto 112) & '0') XOR (STATE(110 downto 104) & '0') XOR
														STATE(111 downto 104) XOR STATE(103 downto 96);
					END IF;
					IF (STATE(111) XOR STATE(103)) = '1' THEN
						STATE(111 downto 104)	<= STATE(127 downto 120) XOR STATE(119 downto 112) XOR (STATE(110 downto 104) & '0') XOR
														(STATE(102 downto 96) & '0') XOR STATE(103 downto 96) XOR X"1B";
					ELSE
						STATE(111 downto 104)	<= STATE(127 downto 120) XOR STATE(119 downto 112) XOR (STATE(110 downto 104) & '0') XOR
														(STATE(102 downto 96) & '0') XOR STATE(103 downto 96);
					END IF;
					IF (STATE(127) XOR STATE(103)) = '1' THEN
						STATE(103 downto 96)		<= (STATE(126 downto 120) & '0') XOR STATE(127 downto 120) XOR STATE(119 downto 112) XOR
														STATE(111 downto 104) XOR (STATE(102 downto 96) & '0') XOR X"1B";
					ELSE
						STATE(103 downto 96)		<= (STATE(126 downto 120) & '0') XOR STATE(127 downto 120) XOR STATE(119 downto 112) XOR
														STATE(111 downto 104) XOR (STATE(102 downto 96) & '0');
					END IF;
					
					-- 95-64
					IF (STATE(95) XOR STATE(87)) = '1' THEN
						STATE(95 downto 88)	<= (STATE(94 downto 88) & '0') XOR (STATE(86 downto 80) & '0') XOR
														STATE(87 downto 80) XOR STATE(79 downto 72) XOR STATE(71 downto 64) XOR X"1B";
					ELSE
						STATE(95 downto 88)	<= (STATE(94 downto 88) & '0') XOR (STATE(86 downto 80) & '0') XOR
														STATE(87 downto 80) XOR STATE(79 downto 72) XOR STATE(71 downto 64);
					END IF;
					IF (STATE(87) XOR STATE(79)) = '1' THEN
						STATE(87 downto 80)	<= STATE(95 downto 88) XOR (STATE(86 downto 80) & '0') XOR (STATE(78 downto 72) & '0') XOR
														STATE(79 downto 72) XOR STATE(71 downto 64) XOR X"1B";
					ELSE
						STATE(87 downto 80)	<= STATE(95 downto 88) XOR (STATE(86 downto 80) & '0') XOR (STATE(78 downto 72) & '0') XOR
														STATE(79 downto 72) XOR STATE(71 downto 64);
					END IF;
					IF (STATE(79) XOR STATE(71)) = '1' THEN
						STATE(79 downto 72)	<= STATE(95 downto 88) XOR STATE(87 downto 80) XOR (STATE(78 downto 72) & '0') XOR
														(STATE(70 downto 64) & '0') XOR STATE(71 downto 64) XOR X"1B";
					ELSE
						STATE(79 downto 72)	<= STATE(95 downto 88) XOR STATE(87 downto 80) XOR (STATE(78 downto 72) & '0') XOR
														(STATE(70 downto 64) & '0') XOR STATE(71 downto 64);
					END IF;
					IF (STATE(95) XOR STATE(71)) = '1' THEN
						STATE(71 downto 64)		<= (STATE(94 downto 88) & '0') XOR STATE(95 downto 88) XOR STATE(87 downto 80) XOR
														STATE(79 downto 72) XOR (STATE(70 downto 64) & '0') XOR X"1B";
					ELSE
						STATE(71 downto 64)		<= (STATE(94 downto 88) & '0') XOR STATE(95 downto 88) XOR STATE(87 downto 80) XOR
														STATE(79 downto 72) XOR (STATE(70 downto 64) & '0');
					END IF;
					
					-- 63-32
					IF (STATE(63) XOR STATE(55)) = '1' THEN
						STATE(63 downto 56)	<= (STATE(62 downto 56) & '0') XOR (STATE(54 downto 48) & '0') XOR
														STATE(55 downto 48) XOR STATE(47 downto 40) XOR STATE(39 downto 32) XOR X"1B";
					ELSE
						STATE(63 downto 56)	<= (STATE(62 downto 56) & '0') XOR (STATE(54 downto 48) & '0') XOR
														STATE(55 downto 48) XOR STATE(47 downto 40) XOR STATE(39 downto 32);
					END IF;
					IF (STATE(55) XOR STATE(47)) = '1' THEN
						STATE(55 downto 48)	<= STATE(63 downto 56) XOR (STATE(54 downto 48) & '0') XOR (STATE(46 downto 40) & '0') XOR
														STATE(47 downto 40) XOR STATE(39 downto 32) XOR X"1B";
					ELSE
						STATE(55 downto 48)	<= STATE(63 downto 56) XOR (STATE(54 downto 48) & '0') XOR (STATE(46 downto 40) & '0') XOR
														STATE(47 downto 40) XOR STATE(39 downto 32);
					END IF;
					IF (STATE(47) XOR STATE(39)) = '1' THEN
						STATE(47 downto 40)	<= STATE(63 downto 56) XOR STATE(55 downto 48) XOR (STATE(46 downto 40) & '0') XOR
														(STATE(38 downto 32) & '0') XOR STATE(39 downto 32) XOR X"1B";
					ELSE
						STATE(47 downto 40)	<= STATE(63 downto 56) XOR STATE(55 downto 48) XOR (STATE(46 downto 40) & '0') XOR
														(STATE(38 downto 32) & '0') XOR STATE(39 downto 32);
					END IF;
					IF (STATE(63) XOR STATE(39)) = '1' THEN
						STATE(39 downto 32)		<= (STATE(62 downto 56) & '0') XOR STATE(63 downto 56) XOR STATE(55 downto 48) XOR
														STATE(47 downto 40) XOR (STATE(38 downto 32) & '0') XOR X"1B";
					ELSE
						STATE(39 downto 32)		<= (STATE(62 downto 56) & '0') XOR STATE(63 downto 56) XOR STATE(55 downto 48) XOR
														STATE(47 downto 40) XOR (STATE(38 downto 32) & '0');
					END IF;
					
					-- 31-0
					IF (STATE(31) XOR STATE(23)) = '1' THEN
						STATE(31 downto 24)	<= (STATE(30 downto 24) & '0') XOR (STATE(22 downto 16) & '0') XOR
														STATE(23 downto 16) XOR STATE(15 downto 8) XOR STATE(7 downto 0) XOR X"1B";
					ELSE
						STATE(31 downto 24)	<= (STATE(30 downto 24) & '0') XOR (STATE(22 downto 16) & '0') XOR
														STATE(23 downto 16) XOR STATE(15 downto 8) XOR STATE(7 downto 0);
					END IF;
					IF (STATE(23) XOR STATE(15)) = '1' THEN
						STATE(23 downto 16)	<= STATE(31 downto 24) XOR (STATE(22 downto 16) & '0') XOR (STATE(14 downto 8) & '0') XOR
														STATE(15 downto 8) XOR STATE(7 downto 0) XOR X"1B";
					ELSE
						STATE(23 downto 16)	<= STATE(31 downto 24) XOR (STATE(22 downto 16) & '0') XOR (STATE(14 downto 8) & '0') XOR
														STATE(15 downto 8) XOR STATE(7 downto 0);
					END IF;
					IF (STATE(15) XOR STATE(7)) = '1' THEN
						STATE(15 downto 8)	<= STATE(31 downto 24) XOR STATE(23 downto 16) XOR (STATE(14 downto 8) & '0') XOR
														(STATE(6 downto 0) & '0') XOR STATE(7 downto 0) XOR X"1B";
					ELSE
						STATE(15 downto 8)	<= STATE(31 downto 24) XOR STATE(23 downto 16) XOR (STATE(14 downto 8) & '0') XOR
														(STATE(6 downto 0) & '0') XOR STATE(7 downto 0);
					END IF;
					IF (STATE(31) XOR STATE(7)) = '1' THEN
						STATE(7 downto 0)		<= (STATE(30 downto 24) & '0') XOR STATE(31 downto 24) XOR STATE(23 downto 16) XOR
														STATE(15 downto 8) XOR (STATE(6 downto 0) & '0') XOR X"1B";
					ELSE
						STATE(7 downto 0)		<= (STATE(30 downto 24) & '0') XOR STATE(31 downto 24) XOR STATE(23 downto 16) XOR
														STATE(15 downto 8) XOR (STATE(6 downto 0) & '0');
					END IF;
				END IF;
				IF COUNTER = X"3" THEN
					STATE		<= STATE XOR ROUND_KEY;
					COUNTER	<= (OTHERS => '0');
					ROUND_NR	<= ROUND_NR + 1;
				END IF;
			END IF;
		END IF;
	END PROCESS;
	
	STATE_OUT	<= STATE;
END ARCHITECTURE;