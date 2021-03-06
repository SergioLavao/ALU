LIBRARY IEEE;
USE ieee.std_logic_1164.all;

 ENTITY mux_1 IS
		GENERIC ( max:INTEGER := 16);
		PORT(		Data_sum_a2		:IN	  STD_LOGIC_VECTOR(max-1 DOWNTO 0);
					Data_res_a2		:IN	  STD_LOGIC_VECTOR(max-1 DOWNTO 0);
					Data_multi		:IN	  STD_LOGIC_VECTOR(max-1 DOWNTO 0);
					Data_suma_car  :IN	  STD_LOGIC_VECTOR(max-1 DOWNTO 0);
					Data_AND		   :IN	  STD_LOGIC_VECTOR(max-1 DOWNTO 0);
					Data_OR   		:IN	  STD_LOGIC_VECTOR(max-1 DOWNTO 0);
					Data_NOT 		:IN	  STD_LOGIC_VECTOR(max-1 DOWNTO 0);
					Data_des 		:IN	  STD_LOGIC_VECTOR(max-1 DOWNTO 0);
					Data_rot 		:IN	  STD_LOGIC_VECTOR(max-1 DOWNTO 0);
					Selector       :IN     STD_LOGIC_VECTOR(3 DOWNTO 0);
					Data_out       :OUT    STD_LOGIC_VECTOR(max-1 DOWNTO 0));

END ENTITY  mux_1;
-------------------------------------------------------------
ARCHITECTURE gatelevel OF  mux_1 IS
	SIGNAL vex_aux_0      :     STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL vex_aux_1      :     STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL vex_aux_2      :     STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL vex_aux_3      :     STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL vex_aux_4      :     STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL vex_aux_5      :     STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL vex_aux_6      :     STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL vex_aux_7      :     STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL vex_aux_8      :     STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL vex_au_0       :     STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL vex_au_1       :     STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL vex_au_2       :     STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL vex_au_3       :     STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL vex_au_4       :     STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL vex_au_5       :     STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL vex_au_6       :     STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL vex_au_7       :     STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL vex_au_8       :     STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL vec_ena_0      :     STD_LOGIC_VECTOR(max-1 DOWNTO 0);
	SIGNAL vec_ena_1      :     STD_LOGIC_VECTOR(max-1 DOWNTO 0);
	SIGNAL vec_ena_2      :     STD_LOGIC_VECTOR(max-1 DOWNTO 0);
	SIGNAL vec_ena_3      :     STD_LOGIC_VECTOR(max-1 DOWNTO 0);
	SIGNAL vec_ena_4      :     STD_LOGIC_VECTOR(max-1 DOWNTO 0);
	SIGNAL vec_ena_5      :     STD_LOGIC_VECTOR(max-1 DOWNTO 0);
	SIGNAL vec_ena_6      :     STD_LOGIC_VECTOR(max-1 DOWNTO 0);
	SIGNAL vec_ena_7      :     STD_LOGIC_VECTOR(max-1 DOWNTO 0);
	SIGNAL vec_ena_8      :     STD_LOGIC_VECTOR(max-1 DOWNTO 0);
	SIGNAL ena_0          :     STD_LOGIC;
	SIGNAL ena_1          :     STD_LOGIC;
	SIGNAL ena_2          :     STD_LOGIC;
	SIGNAL ena_3          :     STD_LOGIC;
	SIGNAL ena_4          :     STD_LOGIC;
	SIGNAL ena_5          :     STD_LOGIC;
	SIGNAL ena_6          :     STD_LOGIC;
	SIGNAL ena_7          :     STD_LOGIC;
	SIGNAL ena_8          :     STD_LOGIC;
BEGIN 
		Data_out<= (vec_ena_0 AND Data_sum_a2)OR	(vec_ena_1 AND Data_res_a2)OR (vec_ena_2 AND Data_multi)OR (vec_ena_3 AND Data_suma_car)OR
		(vec_ena_4 AND Data_AND)OR (vec_ena_5 AND Data_OR)OR (vec_ena_6 AND Data_NOT)OR (vec_ena_7 AND Data_des)OR
		(vec_ena_8 AND Data_rot);
	
	
		vec_aux_0<=  Selector XOR "0000";
		vec_aux_1<=  Selector XOR "0001";	
		vec_aux_2<=  Selector XOR "0010";
		vec_aux_3<=  Selector XOR "0011";
		vec_aux_4<=  Selector XOR "0100";
		vec_aux_5<=  Selector XOR "0101";
		vec_aux_6<=  Selector XOR "0110";
		vec_aux_7<=  Selector XOR "0111";
		vec_aux_8<=  Selector XOR "1000";
		
 
		vex_au_0(0)<= vec_aux_0(0);
		vex_au_1(0)<= vec_aux_1(0);
		vex_au_2(0)<= vec_aux_2(0);
		vex_au_3(0)<= vec_aux_3(0);
		vex_au_4(0)<= vec_aux_4(0);
		vex_au_5(0)<= vec_aux_5(0);
		vex_au_6(0)<= vec_aux_6(0);
		vex_au_7(0)<= vec_aux_7(0);
		vex_au_8(0)<= vec_aux_8(0);
		
		herarquia: FOR i IN 1 To 3 GENERATE-- esto es equivalente a vec_aux(0)OR vec_aux(1)...OR vec_aux(max-1) 
			vex_au_0(i)<= vec_aux_0(i) OR vex_au_0(i-1);
			vex_au_1(i)<= vec_aux_1(i) OR vex_au_1(i-1);
			vex_au_2(i)<= vec_aux_2(i) OR vex_au_2(i-1);
			vex_au_3(i)<= vec_aux_3(i) OR vex_au_3(i-1);
			vex_au_4(i)<= vec_aux_4(i) OR vex_au_4(i-1);
			vex_au_5(i)<= vec_aux_5(i) OR vex_au_5(i-1);
			vex_au_6(i)<= vec_aux_6(i) OR vex_au_6(i-1);
			vex_au_7(i)<= vec_aux_7(i) OR vex_au_7(i-1);
			vex_au_8(i)<= vec_aux_8(i) OR vex_au_8(i-1);
		END GENERATE;
		
		ena_0 <=NOT vec_au_0(3);
		ena_1 <=NOT vec_au_1(3);
		ena_2 <=NOT vec_au_2(3);
		ena_3 <=NOT vec_au_3(3);
		ena_4 <=NOT vec_au_4(3);
		ena_5 <=NOT vec_au_5(3);
		ena_6 <=NOT vec_au_6(3);
		ena_7 <=NOT vec_au_7(3);
		ena_8 <=NOT vec_au_8(3);
		
		vecs_mux: FOR i IN 0 To max-1 GENERATE
			vec_ena_0(i)<= ena_0;
			vec_ena_1(i)<= ena_1;
			vec_ena_2(i)<= ena_2;
			vec_ena_3(i)<= ena_3;
			vec_ena_4(i)<= ena_4;
			vec_ena_5(i)<= ena_5;
			vec_ena_6(i)<= ena_6;
			vec_ena_7(i)<= ena_7;
			vec_ena_8(i)<= ena_8;
		END GENERATE;	
				
							
END ARCHITECTURE gatelevel;