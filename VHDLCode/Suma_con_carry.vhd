LIBRARY IEEE;
USE ieee.std_logic_1164.all;

 ENTITY Suma_con_carry IS
		GENERIC ( max:INTEGER := 16);
		PORT(		Data_1		:IN	  STD_LOGIC_VECTOR(max-1 DOWNTO 0);
					Data_2		:IN	  STD_LOGIC_VECTOR(max-1 DOWNTO 0);
					Data_suma   :OUT    STD_LOGIC_VECTOR(max-1 DOWNTO 0);
					Carry       :OUT    STD_LOGIC);

END ENTITY  Suma_con_carry;
-------------------------------------------------------------
ARCHITECTURE gatelevel OF  Suma_con_carry IS

BEGIN 
		
		suma_:  ENTITY work.full_ader_n_bit--sumador restador
		GENERIC MAP (max => 16)
		PORT MAP (  x=>Data_1,
					  	y=>Data_2,
						Carry=>Carry,
						resul =>Data_suma,
						enable=> '0');	-- si esta enable en 0 suma				
							
							
END ARCHITECTURE gatelevel;