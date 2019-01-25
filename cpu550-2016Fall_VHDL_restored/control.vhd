LIBRARY ieee;
USE ieee.std_logic_1164.all;

-- Control logic for the Duke 550 processor
-- Author: <INSERT YOUR NAME HERE!!!!>

ENTITY control IS
	PORT (	op	: IN STD_LOGIC_VECTOR(4 DOWNTO 0)	-- instruction opcode
			--TODO: Figure out what control signals you need here
			);
END control;

ARCHITECTURE Behavior OF control IS
BEGIN
	-- TODO: implement behavior of control unit
	-- NOTE: Behavioral WHEN... ELSE statements may be used
END Behavior;