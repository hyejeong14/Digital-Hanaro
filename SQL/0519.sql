--함수
--내장함수
--문자열 관련 함수
SELECT ENAME, UPPER(ENAME),LOWER(ENAME),INITCAP(ENAME) FROM EMP;
--
SELECT*FROM EMP WHERE ENAME = 'SCOTT';
SELECT*FROM EMP WHERE UPPER(ENAME) = 'SCOTT';
SELECT*FROM EMP WHERE LOWER(ENAME) = 'scott';
SELECT*FROM EMP WHERE LOWER(ENAME) LIKE 's%';

--문자열 길이
SELECT ENAME, LENGTH(ENAME) FROM EMP;
SELECT ENAME, LENGTH(ENAME) FROM EMP WHERE LENGTH(ENAME)>=5;
SELECT ENAME FROM EMP WHERE LENGTH(ENAME)>=5;

--문자열 바이트 수
--DUAL : 관리자 계정 SYS 소유 테이블, 함수 기능이나 연산 등 테스트 목적으로 사용하는 가상 테이블
SELECT*FROM ALL_TABLES;
SELECT ENAME, LENGTHB(ENAME) FROM EMP;
SELECT LENGTH('HELLO'),LENGTHB('HELLO') FROM DUAL;
SELECT LENGTH('안녕'), LENGTHB('안녕') FROM DUAL;

--문자열 일부 추출
SELECT JOB FROM EMP;

--SUBSTR(시작 숫자, 숫자 자리수)
SELECT JOB, SUBSTR(JOB,1,2) FROM EMP; --글자
SELECT JOB, SUBSTR(JOB,3,5) FROM EMP; -- 5글자
SELECT JOB, SUBSTR(JOB,3) FROM EMP; --끝까지 다 뽑기

--응용, 글자수를 예측하기 어려울 때 LENGTH()
--LENGTH('CLERK') : 1~5
SELECT JOB, LENGTH(JOB) FROM EMP;
--처음부터 끝까지 출력
--   -LENGTH('CLERK') : -5~-1
SELECT JOB, SUBSTR(JOB, -LENGTH(JOB)) FROM EMP;
SELECT JOB, SUBSTR(JOB, -LENGTH(JOB),2) FROM EMP;

--뒤에서 찾고 싶을 때
SELECT JOB, SUBSTR(JOB,LENGTH(JOB)) FROM EMP;
SELECT JOB, SUBSTR(JOB,LENGTH(JOB)-1) FROM EMP;
SELECT JOB, SUBSTR(JOB,LENGTH(JOB)-2) FROM EMP;
SELECT JOB, SUBSTR(JOB,LENGTH(JOB)-3) FROM EMP;

--INSTR() : 특정 문자의 위치를 알려주는 함수
SELECT INSTR('HELLO,ORACLE!','L'),
    INSTR('HELLO,ORACLE!','L',5),
    INSTR('HELLO,ORACLE!','L',2,2)
    FROM DUAL;

SELECT '010-2122-1123',
        REPLACE('010-2122-1123','-',' '), -- => 대시 기호를 BLANCK로 대체
        REPLACE('010-2122-1123','-','*'), -- => 대시 기호를 *로 대체
        REPLACE('010-2122-1123','-') -- => 대시 기호를 삭제
    FROM DUAL;
    
--빈칸을 특정 문자로 채우기
--LPAD : LEFT 에서 사용
--RPAD : RIGHT에서 사용
SELECT 'Oracle',
        LPAD('Oracle',10,'#'), -- 10자리, ORACLE 글자를 오른쪽부터 넣고, 남은 자리를 왼쪽에서 # 채움
        RPAD('Oracle',10,'*'),
        LPAD('Oracle',10),
        RPAD('Oracle',10)    FROM DUAL;
        
--문자열합치기 CONCAT
SELECT EMPNO,ENAME FROM EMP WHERE ENAME ='SCOTT';
SELECT CONCAT(EMPNO,ENAME) FROM EMP WHERE ENAME='SCOTT';
SELECT CONCAT(':',ENAME), CONCAT(EMPNO,CONCAT(':',ENAME)) FROM EMP WHERE ENAME='SCOTT';

--||로 문자열 합치기
SELECT EMPNO || ENAME FROM EMP WHERE ENAME = 'SCOTT';
SELECT ':' || ENAME, EMPNO || ':' || ENAME FROM EMP WHERE ENAME = 'SCOTT';

--특정 문자를 지우는 함수
--TRIM = 앞뒤 = TRIM BOTH FROM
--LTRIM = 앞 = 왼쪽 = TRIM LEADING FROM
--RTRIM = 뒤 = 오른쪽 = TRIM TRAILING FROM
--어떤 문자를 지울지 정하지 않으면 공백 제거
SELECT '['||' _ _Oracle_ _ '||']',
       '['||TRIM(' _ _Oracle_ _ ')||']',
       '['||TRIM(BOTH FROM' _ _Oracle_ _ ')||']',
       '['||TRIM(LEADING FROM' _ _Oracle_ _ ')||']',
       '['||TRIM(TRAILING FROM' _ _Oracle_ _ ')||']'
       FROM DUAL;

--TRIM, LTRIM, RTRIM 함수로 바꿔서 그대로 재현
SELECT '['||' _ _Oracle_ _ '||']',
       '['||TRIM(' _ _Oracle_ _ ')||']',
       '['||LTRIM(' _ _Oracle_ _ ')||']',
       '['||RTRIM(' _ _Oracle_ _ ')||']'
       FROM DUAL;

--지우고자 하는 문자 지정해서 사용
SELECT '['||'_ _Oracle_ _'||']',
       '['||TRIM('_ _Oracle_ _')||']',
       '['||TRIM(BOTH '_' FROM '_ _Oracle_ _')||']',
       '['||TRIM(LEADING '_' FROM'_ _Oracle_ _')||']',
       '['||TRIM(TRAILING '_' FROM'_ _Oracle_ _')||']'
       FROM DUAL;

--TRIM, LTRIM, RTRIM 함수로 바꿔서 그대로 재현
SELECT '['||' _ _Oracle_ _ '||']',
       '['||TRIM('_ _Oracle_ _')||']', -- => TRIM 함수는 특정 문자 삭제 불가능, 공백만 제거 가능
       '['||LTRIM('_ _Oracle_ _','_')||']',
       '['||RTRIM('_ _Oracle_ _','_')||']'
       FROM DUAL;
       
--숫자함수
--반올림, 표현할 자리수
SELECT ROUND(1234.5678),
       ROUND(1234.5678 , 0),
       ROUND(1234.5678 , 1),
       ROUND(1234.5678 , 2),
       ROUND(1234.5678 , -1),
       ROUND(1234.5678 , -2)
    FROM DUAL;

--버리기, 표현할 자리수  
SELECT TRUNC(1234.5678),
       TRUNC(1234.5678 , 0),
       TRUNC(1234.5678 , 1),
       TRUNC(1234.5678 , 2),
       TRUNC(1234.5678 , -1),
       TRUNC(1234.5678 , -2)
    FROM DUAL;
    
--정수 반환 함수
SELECT CEIL(3.14),
       FLOOR(3.14),  -- 3 < 3.14 < 4
       CEIL(-3.14),
       FLOOR(-3.14)  -- -4 < -3.14 < -3
    FROM DUAL;

--나머지값 구하기
SELECT MOD(6,4),
       MOD(15,6),
       MOD(10,2)
    FROM DUAL;

-- 날짜 데이터 + 날짜 데이터 연산은 불가능 
-- 날짜 함수
-- 현재 날짜
SELECT SYSDATE FROM DUAL;
SELECT SYSDATE - 1 FROM DUAL;
SELECT SYSDATE + 1 FROM DUAL;
SELECT SYSDATE +100 FROM DUAL;
-- 특정 개월 후의 날짜 확인
SELECT SYSDATE, ADD_MONTHS(SYSDATE,3) FROM DUAL;
SELECT SYSDATE, ADD_MONTHS(SYSDATE,120) FROM DUAL;

--과거 < 미래 
SELECT * FROM EMP;
SELECT ENAME,HIREDATE, ADD_MONTHS(HIREDATE,120) FROM EMP;
SELECT ENAME,HIREDATE, ADD_MONTHS(HIREDATE,492),SYSDATE
    FROM EMP 
   WHERE ADD_MONTHS(HIREDATE,492)>SYSDATE;

--초과
SELECT * FROM EMP;
SELECT ENAME,HIREDATE, ADD_MONTHS(HIREDATE,120) FROM EMP;
SELECT ENAME,HIREDATE, ADD_MONTHS(HIREDATE,492),SYSDATE
    FROM EMP 
   WHERE ADD_MONTHS(HIREDATE,492)<SYSDATE;
   
--개월 수 차이
SELECT EMPNO, ENAME,HIREDATE,SYSDATE,
    MONTHS_BETWEEN(HIREDATE,SYSDATE),
    MONTHS_BETWEEN(SYSDATE, HIREDATE),
    TRUNC(MONTHS_BETWEEN(SYSDATE,HIREDATE))
    FROM EMP;
    
--돌아오는 요일의 날짜
--해당 월의 마지막 날짜
SELECT SYSDATE, NEXT_DAY(SYSDATE,'수요일'),LAST_DAY(SYSDATE) FROM DUAL;

SELECT SYSDATE,
     ROUND(SYSDATE,'CC'),
     ROUND(SYSDATE,'YYYY'),
     ROUND(SYSDATE,'Q'),
     ROUND(SYSDATE,'DDD'),
     ROUND(SYSDATE,'HH')
    FROM DUAL;
    
SELECT SYSDATE,
     TRUNC(SYSDATE,'CC'),
     TRUNC(SYSDATE,'YYYY'),
     TRUNC(SYSDATE,'Q'),
     TRUNC(SYSDATE,'HH')
    FROM DUAL;

--날짜 시간 포맷 입력해야 함
--숫자를 문자로 변환 TO _CHAR()
--연원일은 /로 연결, 시분초는 :으로 연결
SELECT EMPNO,EMPNO+'1000' FROM EMP;
SELECT SYSDATE, TO_CHAR(SYSDATE,'YYYY/MM/DD HH24:MI:SS')FROM EMP;


SELECT SYSDATE,
     TO_CHAR(SYSDATE,'MM'), -- 숫자 월
     TO_CHAR(SYSDATE,'MON'), -- 이름 월, 약자
     TO_CHAR(SYSDATE,'MONTH'), --이름 월, FULL NAME 
     TO_CHAR(SYSDATE,'DD'), --숫자 일
     TO_CHAR(SYSDATE,'DY'),-- 이름 요일, 약자
     TO_CHAR(SYSDATE,'DAY') -- 이름 요일 ,FULL NAME
    FROM DUAL;
    

SELECT SYSDATE,
     TO_CHAR(SYSDATE,'MM'), -- 숫자 월
     TO_CHAR(SYSDATE,'MON'), -- 이름 월, 약자
     TO_CHAR(SYSDATE,'MONTH'), --이름 월, FULL NAME 
     TO_CHAR(SYSDATE,'DD'), --숫자 일
     TO_CHAR(SYSDATE,'DY'),-- 이름 요일, 약자
     TO_CHAR(SYSDATE,'DAY') -- 이름 요일 ,FULL NAME
    FROM DUAL;

SELECT SYSDATE,
     TO_CHAR(SYSDATE,'MM'), -- 숫자 월
     
     TO_CHAR(SYSDATE,'MON','NLS_DATE_LANGUAGE=KOREAN'), -- 이름 월, 약자
     TO_CHAR(SYSDATE,'MON','NLS_DATE_LANGUAGE=JAPANESE'), -- 이름 월, 약자
     TO_CHAR(SYSDATE,'MON','NLS_DATE_LANGUAGE=ENGLISH'), -- 이름 월, 약자
    
     TO_CHAR(SYSDATE,'MONTH','NLS_DATE_LANGUAGE=KOREAN'), --이름 월, FULL NAME 
     TO_CHAR(SYSDATE,'MONTH','NLS_DATE_LANGUAGE=JAPANESE'), --이름 월, FULL NAME 
     TO_CHAR(SYSDATE,'MONTH','NLS_DATE_LANGUAGE=ENGLISH') --이름 월, FULL NAME 
    FROM DUAL;
    
SELECT SYSDATE,
     TO_CHAR(SYSDATE,'DD'), --숫자 일
     TO_CHAR(SYSDATE,'DY','NLS_DATE_LANGUAGE=KOREAN'),-- 이름 요일, 약자
     TO_CHAR(SYSDATE,'DY','NLS_DATE_LANGUAGE=JAPANESE'),-- 이름 요일, 약자
     TO_CHAR(SYSDATE,'DY','NLS_DATE_LANGUAGE=ENGLISH'),-- 이름 요일, 약자
     
     TO_CHAR(SYSDATE,'DAY','NLS_DATE_LANGUAGE=KOREAN'), -- 이름 요일 ,FULL NAME
     TO_CHAR(SYSDATE,'DAY','NLS_DATE_LANGUAGE=JAPANESE'), -- 이름 요일 ,FULL NAME
     TO_CHAR(SYSDATE,'DAY','NLS_DATE_LANGUAGE=ENGLISH') -- 이름 요일 ,FULL NAME
   FROM DUAL;
   
--시분초
SELECT SYSDATE, TO_CHAR(SYSDATE,'HH24:MI:SS'), --24시간
                TO_CHAR(SYSDATE,'HH12:MI:SS'), --12시간
                TO_CHAR(SYSDATE,'HH12:MI:SS PM'), --12시간 오전/오후 구분
                TO_CHAR(SYSDATE,'HH:MI:SS PM') -- 12시간 오전/오후 구분
        FROM DUAL;
        
--숫자 형식
--숫자를 문자로 변환
SELECT SAL,
       TO_CHAR(SAL,'$999,999'), -- $, 천단위에 (,)표시
       TO_CHAR(SAL,'L999,999'), -- L => 로컬 통화량 (한국 : 원), 천단위 (,) 표시
       TO_CHAR(SAL,'999,999.00'), -- 천단위 (,)표시, 소수점 2자리 (숫자로만 표현, 단위 표시X)
       TO_CHAR(SAL,'000,999,999.00'), --정수 9자리 & 소수점 2자리, 천단위 (,) 표시, 숫자 채우고 남은 자리는 0으로 채움
       TO_CHAR(SAL,'000999999.99'), -- 정수 9자리, 소수점 2자리, 천단위 표시 X, 숫자 채우고 남은 자리는 0으로 채움
       TO_CHAR(SAL,'999,999,00') -- 백의 자리에서 ,표시
    
    FROM EMP;

--숫자 형 변환
--암시적 형 변환 = 문자를 숫자로 변환 : TO_NUMBER 함수를 사용하지 않아도 형 변환이 된당 알아서 알아서~
SELECT 1300-'1500','1300'+1500 FROM DUAL;

--명시적 형 변환
SELECT 1300-TO_NUMBER('1500'),TO_NUMBER('1300')+1500 FROM DUAL;

--TO_NUMBER 함수를 사용하여 문제 해결
SELECT '1,300'-'1,500' FROM DUAL; -- 천단위 ,표시 하려면 오류난당~~~!~!~!!~@#@#@#!
SELECT TO_NUMBER('1,300','999,999')-TO_NUMBER('1,500','999,999') FROM DUAL;

--날짜 형 변환
SELECT TO_DATE('2023-05-19','YYYY/MM/DD') FROM DUAL;
SELECT TO_DATE('20230519','YYYY/MM/DD') FROM DUAL;
SELECT TO_DATE('2023-05-19','YYYY-MM-DD') FROM DUAL; -- 출력형태는 -가 아닌 /로 출력
SELECT TO_DATE('20230519','YYYY-MM-DD') FROM DUAL;
SELECT TO_DATE('2023-05-19','YY.MM.DD') FROM DUAL;
SELECT TO_DATE('2023 05 19','YYYY/MM/DD') FROM DUAL;

--사원 데이터에서 81년 7월 1일 이후에 입사한 사람과 이전에 입사한 사람
SELECT ENAME,HIREDATE 
FROM EMP 
WHERE HIREDATE >= TO_DATE('1981/07/01','YYYY/MM/DD'); 

SELECT ENAME,HIREDATE 
FROM EMP 
WHERE HIREDATE < TO_DATE('1981/07/01','YYYY/MM/DD'); 

--RR : 1950 ~ 2049 의 값만 가질 수 있다
SELECT TO_DATE('49/12/10','YY/MM/DD') AS Y1, -- 2049 출력
       TO_DATE('49/12/10','RR/MM/DD') AS Y2, -- 2049 출력
       TO_DATE('50/12/10','YY/MM/DD') AS Y3, -- 2050 출력
       TO_DATE('50/12/10','RR/MM/DD') AS Y4, -- 1950 출력
       TO_DATE('51/12/10','YY/MM/DD') AS Y5, -- 2051 출력
       TO_DATE('51/12/10','RR/MM/DD') AS Y6  -- 1951 출력
    FROM DUAL;

--NULL값 처리하는 함수
--NVL함수 : NULL 값일 때, 내가 원하는 값으로 변경
SELECT * FROM EMP;
SELECT EMPNO,ENAME,SAL,COMM,SAL+COMM,NVL(COMM,0),SAL+NVL(COMM,0) FROM EMP;

--NVL2 함수 : 첫번째 매개변수 - NULL값이 아닐 때 변경할 값, 두번째 매개변수 - NULL값일 때 변경할 값
SELECT EMPNO,ENAME,SAL,COMM,SAL+COMM,NVL2(COMM,'O','X'),SAL+NVL2(COMM,SAL*12+COMM,SAL*12) FROM EMP;

--상황에 따라서 다른 데이터 반환
--DECODE : 같다는 조건만 가능
SELECT EMPNO,ENAME,JOB,SAL,
       DECODE(JOB,
              'MANAGER', SAL*1.1,
              'SALESMAN',SAL*1.05,
              'ANALYST', SAL,
              SAL*1.03) AS UPSAL
            FROM EMP;

SELECT EMPNO, ENAME, JOB, SAL,
       CASE JOB
       WHEN 'MANAGER' THEN SAL*1.1
       WHEN 'SALESMAN' THEN SAL*1.05
       WHEN 'ANALYST' THEN SAL
       ELSE SAL*1.03 
       END AS UPSAL
    FROM EMP;
       
-- CASE문은 같다라는 조건 말고도 사용가능
SELECT EMPNO,ENAME,COMM, 
       CASE 
        WHEN COMM IS NULL THEN '해당 사항 없음'
        WHEN COMM = 0 THEN '수당 없음'
        WHEN COMM > 0 THEN '수당 : '||COMM
       END AS COMM_CMT
    FROM EMP;

-- 다중행 함수 = 결과가 한개 = 하나의 값으로 요약  ( 앞의 함수들은 단일행 함수 )
SELECT SAL FROM EMP; -- 행 14개
SELECT SUM(SAL) FROM EMP; -- 행 1개

-- 여러 개의 열을 같이 출력하려면 행의 개수가 같아야 함
-- NULL 값을 자동으로 제외하고 계산해줌 ( NULL값이 포함되어도 계산 가능 )
SELECT SUM(COMM),SUM(SAL) FROM EMP;

--행의  개수가 같으므로 동시 출력 가능
SELECT SUM(DISTINCT SAL),
       SUM(ALL SAL),
       SUM(SAL)
    FROM EMP;
    
--
SELECT COUNT(SAL) FROM EMP;
SELECT COUNT(*) FROM EMP WHERE DEPTNO=30;
SELECT COUNT(*) FROM EMP WHERE SAL>3000;

SELECT COUNT(DISTINCT SAL),
       COUNT(ALL SAL),
       COUNT(SAL)
    FROM EMP;
    
--NULL 값을 빼고 계산    
SELECT COUNT(COMM) FROM EMP;
SELECT COUNT(*) FROM EMP WHERE COMM IS NULL;

--최대값
SELECT MAX(SAL) FROM EMP;
SELECT MAX(SAL) FROM EMP WHERE DEPTNO=30;
SELECT MAX(HIREDATE) FROM EMP; -- 가장 최근 입사자의 입사일
SELECT MAX(HIREDATE) FROM EMP WHERE SAL>3000;

--최소값
SELECT MIN(SAL) FROM EMP;
SELECT MIN(SAL) FROM EMP WHERE DEPTNO!=10;
SELECT MIN(HIREDATE) FROM EMP; -- 가장 오래된 입사자의 입사일

--평균
SELECT AVG(SAL) FROM EMP;
SELECT AVG(SAL) FROM EMP WHERE DEPTNO = 30;
SELECT AVG(COMM) FROM EMP; --자동으로 NULL값 제외 후 계산
SELECT AVG(COMM) FROM EMP WHERE DEPTNO = 30;

