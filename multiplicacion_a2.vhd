LIBRARY IEEE;
USE ieee.std_logic_1164.all;

 ENTITY multiplicacion_a2 IS
		GENERIC ( max:INTEGER := 16);
		PORT(		Data_1		:IN	  STD_LOGIC_VECTOR(max-1 DOWNTO 0);
					Data_2		:IN	  STD_LOGIC_VECTOR(max-1 DOWNTO 0);
					clk         :IN     STD_LOGIC;
					enable      :IN     STD_LOGIC;
					rst         :IN     STD_LOGIC;
					ena_mul     :IN     STD_LOGIC;
					disponible  :OUT    STD_LOGIC;
					Data_mul_a2 :OUT    STD_LOGIC_VECTOR(max-1 DOWNTO 0);
					Vec_mul     :OUT    STD_LOGIC_VECTOR(2 DOWNTO 0));---overflow-zero-negativo

END ENTITY  multiplicacion_a2;
-------------------------------------------------------------
ARCHITECTURE gatelevel OF  multiplicacion_a2 IS
		CONSTANT ZEROS   :     STD_LOGIC_VECTOR(max-1 DOWNTO 0) := (OTHERS =>'0');
      SIGNAL overflow  :     STD_LOGIC;
		SIGNAL zero      :     STD_LOGIC;
		SIGNAL negativo  :     STD_LOGIC;
		SIGNAL multi     :     STD_LOGIC_VECTOR(max-1 DOWNTO 0);
		SIGNAL vec_aux   :     STD_LOGIC_VECTOR(max-1 DOWNTO 0);
		SIGNAL vec_aux_2 :     STD_LOGIC_VECTOR(max-1 DOWNTO 0);
		SIGNAL vec_over1 :     STD_LOGIC_VECTOR((max/2)-1 DOWNTO 0);
		SIGNAL vec_over2 :     STD_LOGIC_VECTOR((max/2)-1 DOWNTO 0);

BEGIN 
		Vec_res <= overflow&zero&negativo;
		Data_mul_a2<= multi;
		overflow<= vec_over1(max/2-1)OR vec_over2(max/2-1);
		Negativo<= Data_1(max-1)XOR Data_2(max-1);
		zero<= igual OR (NOT(overflow));

		vec_aux<= multi XOR ZEROS;	
		igual <= NOT vec_aux_2(max-1);
 
 
		vec_over1(0)<=Data_1(max/2);
		vec_over2(0)<=Data_2(max/2);
		herarquia: FOR i IN max/2+1 To max-1 GENERATE-- desde 9 a 15 
			vec_over1(i-max/2)<= Data_1(i) OR vec_over1(i-1);
			vec_over2(i-max/2)<= Data_2(i) OR vec_over2(i-1);
		END GENERATE;
 
		vex_aux_2(0)<= vec_aux(0);
		herarquia: FOR i IN 1 To max-1 GENERATE-- esto es equivalente a vec_aux(0)OR vec_aux(1)...OR vec_aux(max-1) 
			vex_aux_2(i)<= vec_aux(i) OR vex_aux_2(i-1);
		END GENERATE;
		
		resta_:  ENTITY work.Multiplicacion_both--sumador restador
		GENERIC MAP (N => max/2)
		PORT MAP (  x=>Data_1((max/2)-1 DOWNTO 0),
					  	y=>Data_2((max/2)-1 DOWNTO 0),
						Outmul =>multi ,
						ena_mul=>ena_mul,
						rst=> rst,
						disponible=>disponible,
						ena=>enable,
						clk=>clk );		
			

	
											
END ARCHITECTURE gatelevel;