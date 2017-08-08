-- Copyright (C) 1991-2015 Altera Corporation. All rights reserved.
-- Your use of Altera Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Altera Program License 
-- Subscription Agreement, the Altera Quartus II License Agreement,
-- the Altera MegaCore Function License Agreement, or other 
-- applicable license agreement, including, without limitation, 
-- that your use is for the sole purpose of programming logic 
-- devices manufactured by Altera and sold by Altera or its 
-- authorized distributors.  Please refer to the applicable 
-- agreement for further details.

-- PROGRAM		"Quartus II 64-Bit"
-- VERSION		"Version 15.0.0 Build 145 04/22/2015 Patches 0.01we SJ Web Edition"
-- CREATED		"Sun Aug 06 11:53:23 2017"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY EK IS 
	PORT
	(
		CLK :  IN  STD_LOGIC;
		INIT :  IN  STD_LOGIC;
		RUN :  IN  STD_LOGIC;
		KEY :  IN  STD_LOGIC_VECTOR(127 DOWNTO 0);
		STATE_IN :  IN  STD_LOGIC_VECTOR(127 DOWNTO 0);
		STATE_OUT :  OUT  STD_LOGIC_VECTOR(127 DOWNTO 0)
	);
END EK;

ARCHITECTURE bdf_type OF EK IS 

COMPONENT key_schedule
	PORT(CLK : IN STD_LOGIC;
		 INIT : IN STD_LOGIC;
		 RUN : IN STD_LOGIC;
		 LOAD_KEY : IN STD_LOGIC;
		 KEY : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
		 ROUND_KEY : OUT STD_LOGIC_VECTOR(127 DOWNTO 0)
	);
END COMPONENT;

COMPONENT round
	PORT(CLK : IN STD_LOGIC;
		 INIT : IN STD_LOGIC;
		 RUN : IN STD_LOGIC;
		 ROUND_KEY : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
		 STATE_IN : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
		 STATE_OUT : OUT STD_LOGIC_VECTOR(127 DOWNTO 0)
	);
END COMPONENT;

COMPONENT round_ctrl
	PORT(CLK : IN STD_LOGIC;
		 INIT : IN STD_LOGIC;
		 RUN : IN STD_LOGIC;
		 LOAD_KEY : OUT STD_LOGIC
	);
END COMPONENT;

SIGNAL	LOAD_KEY :  STD_LOGIC;
SIGNAL	ROUND_KEY :  STD_LOGIC_VECTOR(127 DOWNTO 0);


BEGIN 



b2v_KEY_SCHEDULE : key_schedule
PORT MAP(CLK => CLK,
		 INIT => INIT,
		 RUN => RUN,
		 LOAD_KEY => LOAD_KEY,
		 KEY => KEY,
		 ROUND_KEY => ROUND_KEY);


b2v_ROUND : round
PORT MAP(CLK => CLK,
		 INIT => INIT,
		 RUN => RUN,
		 ROUND_KEY => ROUND_KEY,
		 STATE_IN => STATE_IN,
		 STATE_OUT => STATE_OUT);


b2v_ROUND_CTRL : round_ctrl
PORT MAP(CLK => CLK,
		 INIT => INIT,
		 RUN => RUN,
		 LOAD_KEY => LOAD_KEY);


END bdf_type;