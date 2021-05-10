-- Timebomb.VHD

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY Timebomb IS
PORT(
	START 	 : IN  STD_LOGIC_VECTOR(0 DOWNTO 0);
	RESETN : IN STD_LOGIC;
   	a, b, c, d, e, f, g : OUT STD_LOGIC;
	COUNT_OUT : BUFFER STD_LOGIC_VECTOR(0 TO 15); 
	SEG_COM : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
	
	--피에조, 클록, 클록p 포트작성
	PIEZO : 
	CLK_P : 
	CLK   : 
);
END Timebomb;

ARCHITECTURE HB OF Timebomb IS

	SIGNAL DECODE : STD_LOGIC_VECTOR(6 DOWNTO 0);
	SIGNAL REG : STD_LOGIC;
	SIGNAL CNT : INTEGER RANGE 0 TO 2047;     
	SIGNAL LIMIT : INTEGER RANGE 0 TO 2047; 
	SIGNAL CNT_8BIT : STD_LOGIC_VECTOR(0 TO 15);
	SIGNAL HOLD : STD_LOGIC_VECTOR(0 DOWNTO 0);
	
	CONSTANT CNT_DO : INTEGER RANGE 0 TO 2047 := 1910;   
	CONSTANT CNT_MI : INTEGER RANGE 0 TO 2047 := 1516;
	CONSTANT CNT_SOL : INTEGER RANGE 0 TO 2047 := 1275; 
	CONSTANT CNT_HDO : INTEGER RANGE 0 TO 2047 := 955; 

BEGIN

SEG_COM <= "1";

-- 클록 영역
PROCESS(START, RESETN, CLK)
	BEGIN
		IF START = 1 THEN
			IF RESETN = '0' THEN
				CNT_8BIT <= (OTHERS => '0');
			ELSIF CLK'EVENT AND CLK = '1' THEN
				IF CNT_8BIT = "11111111" THEN
					CNT_8BIT <= (OTHERS => '0');
				ELSE
					CNT_8BIT <= CNT_8BIT + 1;
				END IF;
			END IF;
		END IF;		
END PROCESS;


--클록_P영역
PROCESS(RESETN, CLK_P) 
BEGIN  
   IF RESETN = '0' THEN 
	    CNT <= 0;     
	    REG <= '0';   
   ELSIF CLK_P'EVENT AND CLK_P = '1' THEN  
		IF CNT >= LIMIT THEN           
			CNT <= 0;         
			REG <= NOT REG;     
	    ELSE           
			CNT <= CNT + 1;      
	    END IF;  
   END IF; 
END PROCESS; 

-- -----------------------------------------------------------------------
-- 코드 작성영역 (기존 코드 수정X)
-- 프로그램구동시 5개의 프로세스 필요 
--(클록 1Hz, 클록 1MHz, 피에조출력, LED출력, 디코더)
-- IF문 활용 (다른 방법으로 사용해도 무방)
-- -----------------------------------------------------------------------


PROCESS(CLK) 
-- 1~4초일때 피에조 출력 코드


--
END PROCESS; 


PROCESS(CLK)
--LED 불빛 출력 영역


--
END PROCESS;

	
PROCESS( -- 입력변수 )
--디코더 프로세스 영역


--	
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