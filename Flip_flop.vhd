LIBRARY IEEE;
USE ieee.std_logic_1164.all;
------------------------------------------------------------
 ENTITY Flip_flop IS
		PORT(	clk	  :IN	  STD_LOGIC;
				rst	  :IN  STD_LOGIC;
				ena	  :IN  STD_LOGIC;
				prn     :IN  STD_LOGIC;
				d	     :IN  STD_LOGIC;
			   q		  :OUT  STD_LOGIC);
END ENTITY Flip_flop;
-------------------------------------------------------------
ARCHITECTURE rtl OF Flip_flop  IS

BEGIN 
	
	dff: PROCESS (clk,rst,d)
	BEGIN 
		IF(rst = '1') THEN 
			IF (prn = '0') THEN 
				q <= '1';
			ELSE	
				q<= '0';
			END IF;	
		ELSIF (rising_edge(clk)) THEN 
			IF (ena = '1') THEN 
				q<= d;
			END IF;
		END IF;
	END PROCESS;	

		
END ARCHITECTURE  ;