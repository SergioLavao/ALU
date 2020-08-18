LIBRARY IEEE;
USE ieee.std_logic_1164.all;

 ENTITY logic1registros IS
		GENERIC ( max:INTEGER := 16);
		PORT(		Data_1		:IN	  STD_LOGIC_VECTOR(max-1 DOWNTO 0);
					Data_despla :OUT	  STD_LOGIC_VECTOR(max-1 DOWNTO 0);
					Data_rota   :OUT	  STD_LOGIC_VECTOR(max-1 DOWNTO 0);
					Data_NOT    :OUT    STD_LOGIC_VECTOR(max-1 DOWNTO 0));

END ENTITY  logic1registros;
-------------------------------------------------------------
ARCHITECTURE gatelevel OF  logic1registros IS

BEGIN 
		
		Data_suma<= NOT Data_1; 
		
		Data_rota(max-1)<= Data_1(0);
		Data_despla(max-1)<= '0';
		rotacion: FOR i IN 0 To max-2 GENERATE
			Data_rota(i)<= Data_1(i+1);
			Data_despla(i)<= Data_1(i+1);
		END GENERATE;
							
				
							
END ARCHITECTURE gatelevel;