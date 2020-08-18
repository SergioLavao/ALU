LIBRARY IEEE;
USE ieee.std_logic_1164.all;

 ENTITY mux_2 IS
		GENERIC ( max:INTEGER := 16);
		PORT(		vec_sum_a2		:IN	  STD_LOGIC_VECTOR(2 DOWNTO 0);
					vec_res_a2		:IN	  STD_LOGIC_VECTOR(2 DOWNTO 0);
					vec_multi		:IN	  STD_LOGIC_VECTOR(2 DOWNTO 0);
					vec_out        :OUT    STD_LOGIC_VECTOR(2 DOWNTO 0));

END ENTITY  mux_2;
-------------------------------------------------------------
ARCHITECTURE gatelevel OF  mux_2 IS
	SIGNAL vex_aux_0      :     STD_LOGIC_VECTOR(1 DOWNTO 0);
	SIGNAL vex_aux_1      :     STD_LOGIC_VECTOR(1 DOWNTO 0);
	SIGNAL vex_aux_2      :     STD_LOGIC_VECTOR(1 DOWNTO 0);
	SIGNAL vex_au_0       :     STD_LOGIC_VECTOR(1 DOWNTO 0);
	SIGNAL vex_au_1       :     STD_LOGIC_VECTOR(1 DOWNTO 0);
	SIGNAL vex_au_2       :     STD_LOGIC_VECTOR(1 DOWNTO 0);
	SIGNAL vec_ena_0      :     STD_LOGIC_VECTOR(2 DOWNTO 0);
	SIGNAL vec_ena_1      :     STD_LOGIC_VECTOR(2 DOWNTO 0);
	SIGNAL vec_ena_2      :     STD_LOGIC_VECTOR(2 DOWNTO 0);
	SIGNAL ena_0          :     STD_LOGIC;
	SIGNAL ena_1          :     STD_LOGIC;
	SIGNAL ena_2          :     STD_LOGIC;
BEGIN 
		Data_out<= (vec_ena_0 AND vec_sum_a2)OR	(vec_ena_1 AND vec_res_a2)OR (vec_ena_2 AND vec_multi);
	
	
		vec_aux_0<=  Selector_2 XOR "00";
		vec_aux_1<=  Selector_2 XOR "01";	
		vec_aux_2<=  Selector_2 XOR "10";
		
 
		vex_au_0(0)<= vec_aux_0(0);
		vex_au_1(0)<= vec_aux_1(0);
		vex_au_2(0)<= vec_aux_2(0);
		
		vex_au_0(1)<= vec_aux_0(1) OR vex_au_0(0);
		vex_au_1(1)<= vec_aux_1(1) OR vex_au_1(0);
		vex_au_2(1)<= vec_aux_2(1) OR vex_au_2(0);

		
		ena_0 <=NOT vec_au_0(1);
		ena_1 <=NOT vec_au_1(1);
		ena_2 <=NOT vec_au_2(1);
		
		vecs_mux: FOR i IN 0 To 2 GENERATE
			vec_ena_0(i)<= ena_0;
			vec_ena_1(i)<= ena_1;
			vec_ena_2(i)<= ena_2;
		END GENERATE;	
				
							
END ARCHITECTURE gatelevel;