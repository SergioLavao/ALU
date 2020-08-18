LIBRARY IEEE;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
---------------------------------------
ENTITY Control IS
	PORT    (clk          :  IN   STD_LOGIC;
	         ena          :  IN   STD_LOGIC;
				ena_alu      :  IN   STD_LOGIC;
				rst	    	 :  IN	STD_LOGIC;
				Selector     :  IN  STD_LOGIC(3 DOWNTO 0);
				disponible	 :	 IN	STD_LOGIC;
				ena_mul      :  OUT  STD_LOGIC;
				avaliable    :  OUT  STD_LOGIC;
				ena_almacenar:  OUT  STD_LOGIC;
				);

END ENTITY;
----------------------------------------				 
ARCHITECTURE  rtl OF Control IS
	CONSTANT ZEROS    :STD_LOGIC_VECTOR(N-1 DOWNTO 0) := (OTHERS =>'0');
	CONSTANT UNOS     :STD_LOGIC_VECTOR(2 DOWNTO 0) := (OTHERS =>'1');
	SIGNAL   ena_sel  :STD_LOGIC;
	SIGNAL   vec_aux  :STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL   d        :STD_LOGIC_VECTOR(4 DOWNTO 0);
	SIGNAL   s        :STD_LOGIC_VECTOR(4 DOWNTO 0);
	SIGNAL   prn      :STD_LOGIC_VECTOR(4 DOWNTO 0);
BEGIN 		
		
		prn<= "11110";

		
		herarquia: FOR i IN 0 To 4 GENERATE
		estado:  ENTITY work.flip_flop
		PORT MAP (  clk=> clk,
					  	rst=> rst,
						prn =>  prn(i) , 
						ena  =>ena,
						q  => s(i),
						d=> d(i));
		END GENERATE;

		
		
		d(0)<= ((NOT ena_alu)AND s(0))OR(s(3))
		d(1)<= ena_alu AND s(0);
		d(2)<= s(1)AND ena_sel;
		d(3)<= (s(1)AND (NOT ena_sel))OR(s(4)AND(disponible_multi))
		d(4)<= s(2)OR(s(4)AND(NOT disponible_multi));
		
		avaliable<= s(0);
		ena_mul<= s(2);
		ena_almacenar<= s(3);
		 
		vec_aux<= Selector XOR "0010";
		sel <= NOT(vec_aux(0) OR vec_aux(1) OR vec_aux(2) OR vec_aux(3)) ;
		
		
END ARCHITECTURE;	