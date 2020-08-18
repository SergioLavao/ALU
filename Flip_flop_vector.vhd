LIBRARY IEEE;
USE ieee.std_logic_1164.all;
------------------------------------------------------------
 ENTITY Flip_flop_vector IS
		GENERIC ( N			:	INTEGER	:= 4);
		PORT(	clk	  :IN	  STD_LOGIC;
				rst	  :IN  STD_LOGIC;
				ena	  :IN  STD_LOGIC;
				prn     :IN  STD_LOGIC;
				d	     :IN  STD_LOGIC_VECTOR(N-1 DOWNTO 0);
			   q		  :OUT  STD_LOGIC_VECTOR(N-1 DOWNTO 0));
END ENTITY Flip_flop_vector;
-------------------------------------------------------------
ARCHITECTURE rtl OF Flip_flop_vector  IS
	CONSTANT ZEROS      : STD_LOGIC_VECTOR(N-1 DOWNTO 0) := (OTHERS =>'0');
	CONSTANT UNOS      : STD_LOGIC_VECTOR(N-1 DOWNTO 0) := (OTHERS =>'1');
BEGIN 
	
	dff: PROCESS (clk,rst,d)
	BEGIN 
		IF(rst = '1') THEN 
			IF (prn = '0') THEN 
				q <= UNOS;
			ELSE	
				q<= ZEROS;
			END IF;	
		ELSIF (rising_edge(clk)) THEN 
			IF (ena = '1') THEN 
				q<= d;
			END IF;
		END IF;
	END PROCESS;	

		
END ARCHITECTURE  ;