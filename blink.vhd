
LIBRARY ieee;
USE ieee.std_logic_1164.all;


ENTITY blinking_led IS
   PORT(
	  LEDR : OUT STD_LOGIC;
	  LEDG : OUT STD_LOGIC
	  );
END blinking_led;

ARCHITECTURE behavior OF blinking_led IS
   SIGNAL clk  : STD_LOGIC;
   SIGNAL led : STD_LOGIC;
   --internal oscillator
   COMPONENT OSCH
      GENERIC(
            NOM_FREQ: string := "53.20");
      PORT( 
            STDBY    : IN  STD_LOGIC;
            OSC      : OUT STD_LOGIC;
            SEDSTDBY : OUT STD_LOGIC);
   END COMPONENT;
BEGIN
   --internal oscillator
   OSCInst0: OSCH
       GENERIC MAP (NOM_FREQ  => "133.00")
       PORT MAP (STDBY => '0', OSC => clk, SEDSTDBY => OPEN);
   PROCESS(clk)
		CONSTANT LIMIT : INTEGER := 10000000;
		VARIABLE count : INTEGER RANGE 0 TO LIMIT;
	BEGIN
	  IF rising_edge(clk) THEN
		 IF(count < LIMIT) THEN
			count := count + 1;
		 ELSE
			count := 0;
			led <= NOT led;
		 END IF;
	  END IF;
	END PROCESS;
	LEDG <= NOT led;
	LEDR <= led;   
END behavior;