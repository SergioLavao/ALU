LIBRARY IEEE;
USE ieee.std_logic_1164.all;

 ENTITY Almacenamiento IS
		GENERIC ( max:INTEGER := 16);
		PORT(		clk            :IN  STD_LOGIC;
					rst            :IN  STD_LOGIC;
					ena_almacenar  :IN  STD_LOGIC;
					Carry          :IN  STD_LOGIC;
					Vec_out        :IN  STD_LOGIC_VECTOR(2 DOWNTO 0);
					Data_out       :IN  STD_LOGIC_VECTOR(max-1 DOWNTO 0);
					C              :OUT STD_LOGIC;
					O              :OUT STD_LOGIC;
					Z              :OUT STD_LOGIC;
					N              :OUT STD_LOGIC;
					Result         :OUT STD_LOGIC_VECTOR(max-1 DOWNTO 0);
					);

END ENTITY  Almacenamiento;
-------------------------------------------------------------
ARCHITECTURE gatelevel OF  Almacenamiento IS
		SIGNAL vec_actual   :     STD_LOGIC_VECTOR(2 DOWNTO 0);
		SIGNAL carry_next   :     STD_LOGIC_VECTOR(0 DOWNTO 0);
		SIGNAL carry        :     STD_LOGIC_VECTOR(0 DOWNTO 0);
BEGIN 


		   guardar:  ENTITY work.flip_flop_vector
			GENERIC MAP (N => max-1)
			PORT MAP (clk=> clk,
					  	rst=> rst,
						prn => '1', 
						ena  =>ena_almacenar,
						q => Result,--en donde almacena 
						d=> Vec_out);
						
		   guardar_1:  ENTITY work.flip_flop_vector
			GENERIC MAP (N => 1)
			PORT MAP (clk=> clk,
					  	rst=> rst,
						prn => '1', 
						ena  =>ena_almacenar,
						q => carry,--en donde almacena 
						d=> carry_next);	
			C<= carry;	

		   guardar_2:  ENTITY work.flip_flop_vector
			GENERIC MAP (N => 3)
			PORT MAP (clk=> clk,
					  	rst=> rst,
						prn => '1', 
						ena  =>ena_almacenar,
						q => vec_actual,--en donde almacena 
						d=> Vec_out);	

			O<= vec_actual(2);
			Z<= vec_actual(1);
			N<= vec_actual(0);
		
		
							
				
							
END ARCHITECTURE gatelevel;