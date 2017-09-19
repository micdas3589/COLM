LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY OR128 IS
	PORT
	(
		DIN1	:IN STD_LOGIC_VECTOR(127 downto 0);
		DIN2	:IN STD_LOGIC_VECTOR(127 downto 0);
		DOUT	:OUT STD_LOGIC_VECTOR(127 downto 0)
	);
END ENTITY;

ARCHITECTURE OR128_ARCH OF OR128 IS
BEGIN
	DOUT	<= DIN1 OR DIN2;
END ARCHITECTURE;