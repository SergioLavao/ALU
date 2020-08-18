LIBRARY IEEE;
USE ieee.std_logic_1164.all;
------------------------------------------------------------
-- es un bloque que hace una suma de 1 bit,  teniendo encuanta
--que puede entrar un carry de otro bloque anterior, y este 
--sacara su propio carry.
--------------------------------------------------------------
 ENTITY full_adder IS
		PORT(		A		:IN		STD_LOGIC;
					B    :IN		STD_LOGIC;
					Cin   :IN    STD_LOGIC;
					Cout     :OUT    STD_LOGIC;
					Sum     :OUT    STD_LOGIC);
END ENTITY full_adder;
-------------------------------------------------------------
ARCHITECTURE gatelevel OF full_adder IS
		SIGNAL p0  :     STD_LOGIC;
		SIGNAL p1  :     STD_LOGIC;
BEGIN 
	
		Sum <= A XOR B XOR Cin;
		Cout <= p0 OR p1;
		
		bothHigh:p0 <= B AND Cin;
		bothLow :p1 <=  A AND(B OR Cin);
		
		
END ARCHITECTURE  gatelevel;