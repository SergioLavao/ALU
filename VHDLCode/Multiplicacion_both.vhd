LIBRARY IEEE;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
---------------------------------------10011000100101101000000==5M
---------------------------------------
ENTITY Multiplicacion_both IS
   GENERIC ( N			   :	INTEGER	:= 8);
	PORT    ( clk        :  IN   STD_LOGIC;
	         ena         :  IN   STD_LOGIC;
				ena_mul     :  IN   STD_LOGIC;
				rst	    	:	IN	  STD_LOGIC;
				disponible	:	OUT	  STD_LOGIC;
				Data_1	   :	IN	  STD_LOGIC_VECTOR(N-1 DOWNTO 0);
				Data_2	   :	IN	  STD_LOGIC_VECTOR(N-1 DOWNTO 0);
				Outmul	   :	OUT  STD_LOGIC_VECTOR(2*N-1 DOWNTO 0)
				);

END ENTITY;
----------------------------------------				 
ARCHITECTURE  rtl OF Multiplicacion_both IS
	CONSTANT ZEROS    :STD_LOGIC_VECTOR(N-1 DOWNTO 0) := (OTHERS =>'0');
	CONSTANT UNOS     :STD_LOGIC_VECTOR(2 DOWNTO 0) := (OTHERS =>'1');
	SIGNAL   ena_fdp  :STD_LOGIC;
	SIGNAL   ena_df   :STD_LOGIC;
	SIGNAL   ena_f    :STD_LOGIC;
	SIGNAL   ena_d    :STD_LOGIC;
	SIGNAL   ena_p    :STD_LOGIC;
	SIGNAL   res      :STD_LOGIC;
	SIGNAL   count    :STD_LOGIC;
	SIGNAL   aux      :STD_LOGIC;
	SIGNAL   aux_2    :STD_LOGIC;
	SIGNAL   counter  :STD_LOGIC_VECTOR(2 DOWNTO 0);
	SIGNAL   menos_uno:STD_LOGIC_VECTOR(2 DOWNTO 0);
	SIGNAL   counter_next:STD_LOGIC_VECTOR(2 DOWNTO 0);
	SIGNAL   Q_menos  :STD_LOGIC_VECTOR(0 DOWNTO 0);
	SIGNAL   Q_menos_next:STD_LOGIC_VECTOR(0 DOWNTO 0);
	SIGNAL   Operacion:STD_LOGIC_VECTOR(N-1 DOWNTO 0);
	SIGNAL   Q       	:STD_LOGIC_VECTOR(N-1 DOWNTO 0);
	SIGNAL   vec_ena_d_2:STD_LOGIC_VECTOR(2 DOWNTO 0);
	SIGNAL   vec_ena_f_2:STD_LOGIC_VECTOR(2 DOWNTO 0);
	SIGNAL   vec_ena_d:STD_LOGIC_VECTOR(N-1 DOWNTO 0);
	SIGNAL   vec_ena_p:STD_LOGIC_VECTOR(N-1 DOWNTO 0);
	SIGNAL   vec_ena_f:STD_LOGIC_VECTOR(N-1 DOWNTO 0);
	SIGNAL   Q_next   :STD_LOGIC_VECTOR(N-1 DOWNTO 0);	
	SIGNAL   M       	:STD_LOGIC_VECTOR(N-1 DOWNTO 0);
	SIGNAL   A       	:STD_LOGIC_VECTOR(N-1 DOWNTO 0);
	SIGNAL   A_next   :STD_LOGIC_VECTOR(N-1 DOWNTO 0);
	SIGNAL   d        :STD_LOGIC_VECTOR(5 DOWNTO 0);
	SIGNAL   s        :STD_LOGIC_VECTOR(5 DOWNTO 0);
	SIGNAL   prn      :STD_LOGIC_VECTOR(5 DOWNTO 0);
BEGIN 		
		
		prn<= "101111";
		M<= Data_1;
		disponible<= s(4);
		Outmul<= A&Q;
		
		herarquia: FOR i IN 0 To 5 GENERATE
		estado:  ENTITY work.flip_flop
		PORT MAP (  clk=> clk,
					  	rst=> rst,
						prn =>  prn(i) , 
						ena  =>ena,
						q  => s(i),
						d=> d(i));
		END GENERATE;

		
		
		d(0)<= s(4)AND(ena_mul);
		d(1)<= ((s(5) AND (NOT Q_menos(0)) AND Q(0))OR(s(3)AND(NOT count)AND(NOT Q(0)) AND Q(1)));
		d(2)<= ((s(5) AND (Q_menos(0)) AND (NOT Q(0)))OR (s(3)AND(NOT count)AND Q(0) AND (NOT Q(1))));
		d(3)<= (((s(5)AND(NOT Q_menos(0))AND (NOT Q(0)))OR (s(3)AND(NOT count)AND((Q(0)AND Q(1))OR((NOT Q(0))AND (NOT Q(1))))))OR s(2)OR s(1));
		d(4)<=(s(3)AND count)OR (s(4)AND(NOT ena_mul));
		d(5)<=s(0);
		 
		 
		guardarA:  ENTITY work.flip_flop_vector
			GENERIC MAP (N => N)
			PORT MAP (clk=> clk,
					  	rst=> rst,
						prn => '1', 
						ena  =>ena_fdp,
						q => A,--lo que sale 
						d=> A_next);
						
		ena_fdp<= ena_f OR ena_d OR ena_p;	
		
		suma_Resta:  ENTITY work.full_ader_n_bit
		GENERIC MAP (max => N)
		PORT MAP (  x=>A,
					  	y=>M,
						Carry=>aux,
						resul => Operacion ,
						enable=> res);	
			
		res<= Q(0);--resta si res es 1 sino suma			
		A_next <=(ZEROS AND vec_ena_f)OR((A(N-1)&A(N-1 DOWNTO 1))AND vec_ena_d)OR(Operacion AND vec_ena_p);	 			
						
------------------------------------------------------------------------------------------------						
		guardarQ:  ENTITY work.flip_flop_vector
			GENERIC MAP (N => N)
			PORT MAP (clk=> clk,
					  	rst=> rst,
						prn => '1', 
						ena  =>ena_df,
						q => Q,--lo que sale 
						d=> Q_next);
		
----------------------------------------------------------------------------------------------
		
		Q_next <= (Data_2 AND vec_ena_f)	OR ((A(0)& Q(N-1 DOWNTO 1))AND vec_ena_d);	  
				  
		vecs_mux: FOR i IN 0 To N-1 GENERATE
			vec_ena_f(i)<= ena_f;--ena_f&ena_f&ena_f
			vec_ena_d(i)<= ena_d;
			vec_ena_p(i)<= ena_p;
		END GENERATE;		  
				  
		
		ena_d<= s(3);
		ena_f<= s(0);
		ena_p<= s(1)OR s(2);
					
		guardarQ_menos:  ENTITY work.flip_flop_vector
			GENERIC MAP (N => 1)
			PORT MAP (clk=> clk,
					  	rst=> rst,
						prn => '1', 
						ena => ena_df,
						q => Q_menos,--lo que sale 
						d=> Q_menos_next);	
			
		ena_df<= ena_d OR ena_f;			
							
							
		Q_menos_next(0)<= (Not ena_f)OR (Q(0)AND ena_d);					
												
		 
		guardarCun:  ENTITY work.flip_flop_vector
		GENERIC MAP (N => 3)
		PORT MAP (clk=> clk,
					 rst=> rst,
					 prn => '0', 
					 ena => ena_df,
					 q => counter,--lo que sale 
					 d=> counter_next);				
							
		counter_next<=(UNOS AND vec_ena_f_2)OR(menos_uno AND vec_ena_d_2);	
		
		vecs_mu: FOR i IN 0 To 2 GENERATE
			vec_ena_f_2(i)<= ena_f;--ena_f&ena_f&ena_f
			vec_ena_d_2(i)<= ena_d;
		END GENERATE;						
		
		count<= NOT((counter(0)XOR '0')OR(counter(1)XOR '0')OR(counter(2)XOR '0'));

		resta_uno:  ENTITY work.full_ader_n_bit
		GENERIC MAP (max => 3)
		PORT MAP (  x=>counter,
					  	y=>"001",
						Carry=>aux_2 ,
						resul => menos_uno ,
						enable=> '1');		
		
END ARCHITECTURE;	