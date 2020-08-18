LIBRARY IEEE;
USE ieee.std_logic_1164.all;

 ENTITY Separacion IS
		PORT(		Selector		:IN	  STD_LOGIC_VECTOR(3 DOWNTO 0);
					Selector_2  :OUT    STD_LOGIC_VECTOR(1 DOWNTO 0));

END ENTITY  Separacion;
-------------------------------------------------------------
ARCHITECTURE gatelevel OF  Separacion IS

		SIGNAL aux          :     STD_LOGIC;

BEGIN 

	aux<= Selector(3)OR Selector(2);
	Selector_2<=(aux & aux)OR Selector(1 DOWNTO 0);
		
					
							
END ARCHITECTURE gatelevel;