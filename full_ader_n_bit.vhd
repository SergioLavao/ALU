LIBRARY IEEE;
USE ieee.std_logic_1164.all;
------------------------------------------------------------
--suma y resta numeros, usando varias bloques del full_adder 
--antes de meter el bloque hace un xor xon l segunda entrada para poder 
-- acerle el complemento en caso de restar, y para el primer bloque le 
-- pone un cin de 0 o 1 para poder sumar y restar
 ENTITY full_ader_n_bit IS
		GENERIC ( max:INTEGER := 4);
		PORT(		x		:IN	  STD_LOGIC_VECTOR(max-1 DOWNTO 0);
					y		:IN	  STD_LOGIC_VECTOR(max-1 DOWNTO 0);
					resul :OUT    STD_LOGIC_VECTOR(max-1 DOWNTO 0);
					Carry :OUT    STD_LOGIC;
					enable:IN     STD_LOGIC);

END ENTITY  full_ader_n_bit;
-------------------------------------------------------------
ARCHITECTURE gatelevel OF  full_ader_n_bit IS
      SIGNAL Cout  :     STD_LOGIC_VECTOR(max DOWNTO 0);
		SIGNAL aux   :     STD_LOGIC_vector(max-1 DOWNTO 0);
BEGIN 
		
		Carry<= Cout(max);
      Def: Cout(0)<= enable;--enable es 1 resta 
		
		full_adder: FOR i IN 0 To max-1 GENERATE
		
		aux(i)<= enable XOR y(i);
		
		full:  ENTITY work.full_adder
		PORT MAP (  A=> x(i),
					  	B=> aux(i),
						Cin =>Cout(i),
						Cout=> Cout(i+1),
						Sum=> resul(i));
		END GENERATE;				
											
END ARCHITECTURE gatelevel;