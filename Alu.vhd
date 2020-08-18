LIBRARY IEEE;
USE ieee.std_logic_1164.all;
------------------------------------------------------------
-- es un bloque que hace una suma de 1 bit,  teniendo encuanta
--que puede entrar un carry de otro bloque anterior, y este 
--sacara su propio carry.
--------------------------------------------------------------
 ENTITY Alu IS
		PORT(		A		:IN		STD_LOGIC;
					Sum     :OUT    STD_LOGIC);
END ENTITY Alu;
-------------------------------------------------------------
ARCHITECTURE gatelevel OF full_adder IS
		SIGNAL p0  :     STD_LOGIC;

BEGIN 
	

		
		
END ARCHITECTURE  gatelevel;