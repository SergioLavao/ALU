LIBRARY IEEE;
USE ieee.std_logic_1164.all;

 ENTITY Suma_complemento_a2 IS
		GENERIC ( max:INTEGER := 16);
		PORT(		Data_1		:IN	  STD_LOGIC_VECTOR(max-1 DOWNTO 0);
					Data_2		:IN	  STD_LOGIC_VECTOR(max-1 DOWNTO 0);
					Data_suma_a2 :OUT    STD_LOGIC_VECTOR(max-1 DOWNTO 0);
					Vec_suma     :OUT    STD_LOGIC_VECTOR(2 DOWNTO 0));---overflow-zero-negativo

END ENTITY  Suma_complemento_a2;
-------------------------------------------------------------
ARCHITECTURE gatelevel OF  Suma_complemento_a2 IS
		CONSTANT ZEROS   :     STD_LOGIC_VECTOR(max-1 DOWNTO 0) := (OTHERS =>'0');
      SIGNAL overflow  :     STD_LOGIC;
		SIGNAL zero      :     STD_LOGIC;
		SIGNAL negativo  :     STD_LOGIC;
		SIGNAL aux       :     STD_LOGIC;
		SIGNAL igual     :     STD_LOGIC;
		SIGNAL suma     :     STD_LOGIC_VECTOR(max-1 DOWNTO 0);
		SIGNAL vex_aux   :     STD_LOGIC_VECTOR(max-1 DOWNTO 0);
		SIGNAL vex_aux_2 :     STD_LOGIC_VECTOR(max-1 DOWNTO 0);
BEGIN 
		Vec_suma <= overflow & zero & negativo;
		
		overflow<= ((Data_1(max-1))AND Data_2(max-1)AND(NOT suma(max-1)))OR(NOT Data_1(max-1)AND (NOT Data_2(max-1))AND( suma(max-1)));--verificacion overflow
		Negativo<= (overflow AND Data_1(max-1))OR (suma(max-1)AND (NOT overflow))
		zero<= igual OR (NOT(overflow));
		Data_suma_a2<= suma;
				  
		vec_aux<= suma XOR ZEROS;	
		igual <= vec_aux_2(max-1);
 
		vex_aux_2(0)<= vec_aux(0);
		herarquia: FOR i IN 1 To max-1 GENERATE-- esto es equivalente a vec_aux(0)OR vec_aux(1)...OR vec_aux(max-1) 
			vex_aux_2(i)<= vec_aux(i) OR vex_aux_2(i-1);
		END GENERATE;
		
		
		suma_:  ENTITY work.full_ader_n_bit--sumador restador
		GENERIC MAP (max => 16)
		PORT MAP (  x=>Data_1,
					  	y=>Data_2,
						Carry=>aux ,
						resul =>suma  ,
						enable=> '0');	-- si esta enable en 0 suma				
											
END ARCHITECTURE gatelevel;