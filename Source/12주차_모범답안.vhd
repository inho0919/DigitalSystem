-- OCTAVER.VHD

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED;

ENTITY OCTAVER IS
PORT(
	RESETN : IN STD_LOGIC;						-- RESET 입력
	CLK : IN STD_LOGIC;							-- CLK (1MHz)
   BCD : IN STD_LOGIC_VECTOR(7 DOWNTO 0);		-- 16개의 입력버튼
   a, b, c, d, e, f, g : OUT STD_LOGIC;		-- DECODE용 번호
	PIEZO : OUT STD_LOGIC;						-- 피에조

	HIG_OCT : IN STD_LOGIC_VECTOR(0 DOWNTO 0)   -- HIGH OCTABER
);
END OCTAVER;

ARCHITECTURE HB OF OCTAVER IS

	SIGNAL DECODE : STD_LOGIC_VECTOR(6 DOWNTO 0);		--DECODE 시그널

	CONSTANT CNT_DO : INTEGER RANGE 0 TO 2047 := 1910;     
	CONSTANT CNT_RE : INTEGER RANGE 0 TO 2047 := 1701;      
	CONSTANT CNT_MI : INTEGER RANGE 0 TO 2047 := 1516;     
	CONSTANT CNT_FA : INTEGER RANGE 0 TO 2047 := 1431;     
	CONSTANT CNT_SOL : INTEGER RANGE 0 TO 2047 := 1275;     
	CONSTANT CNT_RA : INTEGER RANGE 0 TO 2047 := 1135;     
	CONSTANT CNT_SI : INTEGER RANGE 0 TO 2047 := 1011;
	
	CONSTANT CNT_HDO : INTEGER RANGE 0 TO 2047 := 955;
	CONSTANT CNT_HRE : INTEGER RANGE 0 TO 2047 := 852;
	CONSTANT CNT_HMI : INTEGER RANGE 0 TO 2047 := 759;
	CONSTANT CNT_HFA: INTEGER RANGE 0 TO 2047 := 716;
	CONSTANT CNT_HSOL : INTEGER RANGE 0 TO 2047 := 638;
 	CONSTANT CNT_HRA : INTEGER RANGE 0 TO 2047 := 569;
	CONSTANT CNT_HSI : INTEGER RANGE 0 TO 2047 := 507;

	CONSTANT SHARP_DO : INTEGER RANGE 0 TO 2047 := 1804;
	CONSTANT SHARP_RE : INTEGER RANGE 0 TO 2047 := 1607;
	CONSTANT SHARP_FA : INTEGER RANGE 0 TO 2047 := 1352;
	CONSTANT SHARP_SOL : INTEGER RANGE 0 TO 2047 := 1204;
	CONSTANT SHARP_RA : INTEGER RANGE 0 TO 2047 := 1073;
	
	CONSTANT SHARP_HDO : INTEGER RANGE 0 TO 2047 := 902;
	CONSTANT SHARP_HRE : INTEGER RANGE 0 TO 2047 := 804;
	CONSTANT SHARP_HFA : INTEGER RANGE 0 TO 2047 := 676;
	CONSTANT SHARP_HSOL : INTEGER RANGE 0 TO 2047 := 602;
	CONSTANT SHARP_HRA : INTEGER RANGE 0 TO 2047 := 536;
	
	SIGNAL REG : STD_LOGIC;
	SIGNAL CNT : INTEGER RANGE 0 TO 2047;     
	SIGNAL LIMIT : INTEGER RANGE 0 TO 2047; 

BEGIN



PROCESS(RESETN, CLK) 
BEGIN  
   IF RESETN = '0' THEN 
	    CNT <= 0;     
	    REG <= '0';   
   ELSIF CLK'EVENT AND CLK = '1' THEN  
		IF CNT >= LIMIT THEN           
			CNT <= 0;         
			REG <= NOT REG;     
	    ELSE           
			CNT <= CNT + 1;      
	    END IF;  
   END IF; 
END PROCESS; 



PROCESS(BCD, HIG_OCT) 
BEGIN     
	IF HIG_OCT = "0" THEN
		CASE BCD IS    
			WHEN "10000000" => LIMIT <= CNT_DO;    
			WHEN "01000000" => LIMIT <= CNT_RE;    
			WHEN "00100000" => LIMIT <= CNT_MI;    
			WHEN "00010000" => LIMIT <= CNT_FA;   
			WHEN "00001000" => LIMIT <= CNT_SOL;    
			WHEN "00000100" => LIMIT <= CNT_RA;     
			WHEN "00000010" => LIMIT <= CNT_SI;   
			
			WHEN "10000001" => LIMIT <= SHARP_DO;
			WHEN "01000001" => LIMIT <= SHARP_RE;
			WHEN "00010001" => LIMIT <= SHARP_FA;
			WHEN "00001001" => LIMIT <= SHARP_SOL;
			WHEN "00000101" => LIMIT <= SHARP_RA;
			
			WHEN OTHERS => LIMIT <= 0;
		END CASE;	

	ELSIF HIG_OCT = "1" THEN
		CASE BCD IS	
			WHEN "10000000" => LIMIT <= CNT_HDO;
			WHEN "01000000" => LIMIT <= CNT_HRE;
			WHEN "00100000" => LIMIT <= CNT_HMI;
			WHEN "00010000" => LIMIT <= CNT_HFA;
			WHEN "00001000" => LIMIT <= CNT_HSOL;
			WHEN "00000100" => LIMIT <= CNT_HRA;
			WHEN "00000010" => LIMIT <= CNT_HSI;			
			
			WHEN "10000001" => LIMIT <= SHARP_HDO;
			WHEN "01000001" => LIMIT <= SHARP_HRE;
			WHEN "00010001" => LIMIT <= SHARP_HFA;
			WHEN "00001001" => LIMIT <= SHARP_HSOL;
			WHEN "00000101" => LIMIT <= SHARP_HRA;
			
			WHEN OTHERS => LIMIT <= 0;  
		END CASE; 
	END IF;
END PROCESS; 



 
PROCESS(BCD, HIG_OCT)
BEGIN
    IF HIG_OCT = "0" THEN	
		CASE BCD IS
			WHEN "10000000" | "01000000" | "00100000" | "00010000" | "00001000" | "00000100" | "00000010" | "10000001" | "01000001" | "00010001" |  "00001001" | "00000101" => DECODE <= "0001110";
			WHEN OTHERS => DECODE <= "0000000";
		END CASE;
	 ELSIF HIG_OCT = "1" THEN
		CASE BCD IS
			WHEN "10000000" | "01000000" | "00100000" | "00010000" |  "00001000" |  "00000100" | "00000010" | "10000001" | "01000001" | "00010001" | "00001001" |"00000101" => DECODE <= "0110111";
			WHEN OTHERS => DECODE <= "0000000";
		END CASE;
	END IF;
END PROCESS;



a <= DECODE(6);
b <= DECODE(5);
c <= DECODE(4);
d <= DECODE(3);
e <= DECODE(2);
f <= DECODE(1);
g <= DECODE(0);

PIEZO <= REG;
END HB;