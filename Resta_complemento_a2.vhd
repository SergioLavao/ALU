LIBRARY IEEE;
USE ieee.std_logic_1164.all;

 ENTITY Resta_complemento_a2 IS
		GENERIC ( max:INTEGER := 16);
		PORT(		Data_1		:IN	  STD_LOGIC_VECTOR(max-1 DOWNTO 0);
					Data_2		:IN	  STD_LOGIC_VECTOR(max-1 DOWNTO 0);
					Data_res_a2 :OUT    STD_LOGIC_VECTOR(max-1 DOWNTO 0);
					Vec_res     :OUT    STD_LOGIC_VECTOR(2 DOWNTO 0));---overflow-zero-negativo

END ENTITY  Resta_complemento_a2;
-------------------------------------------------------------
ARCHITECTURE gatelevel OF  Resta_complemento_a2 IS
		CONSTANT ZEROS   :     STD_LOGIC_VECTOR(max-1 DOWNTO 0) := (OTHERS =>'0');
      SIGNAL overflow  :     STD_LOGIC;
		SIGNAL zero      :     STD_LOGIC;
		SIGNAL negativo  :     STD_LOGIC;
		SIGNAL aux       :     STD_LOGIC;
		SIGNAL igual     :     STD_LOGIC;
		SIGNAL resta     :     STD_LOGIC_VECTOR(max-1 DOWNTO 0);
		SIGNAL vex_aux   :     STD_LOGIC_VECTOR(max-1 DOWNTO 0);
		SIGNAL vex_aux_2 :     STD_LOGIC_VECTOR(max-1 DOWNTO 0);
BEGIN 
		Vec_res <= overflow&zero&negativo;
		Data_res_a2<= resta;
		overflow<= (Not(Data_1(max-1))AND Data_2(max-1)AND(NOT resta(max-1)))OR( Data_1(max-1)AND (NOT Data_2(max-1))AND(NOT resta(max-1)));--verificacion overflow
		Negativo<= (overflow AND Data_1(max-1))OR (resta(max-1)AND (NOT overflow));
		zero<= igual OR (NOT(overflow));

				  
		vec_aux<= resta XOR ZEROS;	
		igual <= NOT vec_aux_2(max-1);
 
		vex_aux_2(0)<= vec_aux(0);
		herarquia: FOR i IN 1 To max-1 GENERATE-- esto es equivalente a vec_aux(0)OR vec_aux(1)...OR vec_aux(max-1) 
			vex_aux_2(i)<= vec_aux(i) OR vex_aux_2(i-1);
		END GENERATE;
		
		
		resta_:  ENTITY work.full_ader_n_bit--sumador restador
		GENERIC MAP (max => 16)
		PORT MAP (  x=>Data_1,
					  	y=>Data_2,
						Carry=>aux ,
						resul =>resta  ,
						enable=> '1');	-- si esta enable en 1 resta				
											
END ARCHITECTURE gatelevel;