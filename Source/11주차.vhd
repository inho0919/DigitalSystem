-- hb_piano.VHD

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY hb_piano IS
PORT(
	RESETN : IN STD_LOGIC;						-- RESET 입력
	CLK : IN STD_LOGIC;							-- CLK (1MHz)
    BCD : IN STD_LOGIC_VECTOR(15 DOWNTO 0);		-- 16개의 입력버튼
    a, b, c, d, e, f, g : OUT STD_LOGIC;		-- DECODE용 번호
	PIEZO : OUT STD_LOGIC						-- 피에조
);
END hb_piano;

-- -------------------------------------------------------------------------
-- C : 도, D : 레, E : 미, F : 파, G : 솔, A : 라, B : 시 
-- -------------------------------------------------------------------------

ARCHITECTURE HB OF hb_piano IS

	SIGNAL DECODE : STD_LOGIC_VECTOR(6 DOWNTO 0);		--DECODE 시그널
	
	CONSTANT CNT_DO : INTEGER RANGE 0 TO 2047 := 1910;	--낮은 도(5옥타브)          
	CONSTANT CNT_MI : INTEGER RANGE 0 TO 2047 := 1516;  --낮은 미(5옥타브)   
	CONSTANT CNT_SOL : INTEGER RANGE 0 TO 2047 := 1275; --낮은 솔(5옥타브)      
	CONSTANT CNT_HDO : INTEGER RANGE 0 TO 2047 := 955;  --높은 도(6옥타브)
	
	-- 계이름 작성 ----------------------------------------------
	
	-- 5옥타브 도, 레, 미, 파, 솔, 라, 시 작성
	
	
    -- 6옥타브 도, 레, 미, 파, 솔, 라, 시 작성
    
	
	-- 7옥타브 도 작성
    
	
	-- 5, 6옥타브 도#, 레#, 파#, 솔#, 라# 작성 
	
	
	-- --------------------------------------------------------
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


PROCESS(-- 입력변수)
 
-- 계이름 피에조 작성 -----------------------------------------------
	
-- 5옥타브 도, 레, 미, 파, 솔, 라, 시 작성
	
	
-- 6옥타브 도, 레, 미, 파, 솔, 라, 시 작성
    
	
-- 7옥타브 도 작성
    
	
-- 5, 6옥타브 도#, 레#, 파#, 솔#, 라# 작성 

	
-- ---------------------------------------------------
 
END PROCESS; 


PROCESS(-- 입력변수)

-- 계이름 디코더 작성 ----------------------------------------------
	
-- 5옥타브 도, 레, 미, 파, 솔, 라, 시 작성	
	
	
-- 6옥타브 도, 레, 미, 파, 솔, 라, 시 작성
    
	
-- 7옥타브 도 작성
    
	
-- 5, 6옥타브 도#, 레#, 파#, 솔#, 라# 작성 
	
	
-- --------------------------------------------------------
	
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