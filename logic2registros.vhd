LIBRARY IEEE;
USE ieee.std_logic_1164.all;

 ENTITY logic2registros IS
		GENERIC ( max:INTEGER := 16);
		PORT(		Data_1		:IN	  STD_LOGIC_VECTOR(max-1 DOWNTO 0);
					Data_2		:IN	  STD_LOGIC_VECTOR(max-1 DOWNTO 0);
					Data_OR   :OUT    STD_LOGIC_VECTOR(max-1 DOWNTO 0);
					Data_AND   :OUT    STD_LOGIC_VECTOR(max-1 DOWNTO 0));

END ENTITY  logic2registros;
-------------------------------------------------------------
ARCHITECTURE gatelevel OF  logic2registros IS

BEGIN 
		
		Data_AND<= Data_1 AND Data_2; 				
		Data_OR<= Data_1 OR  Data_2; 					
							
END ARCHITECTURE gatelevel;