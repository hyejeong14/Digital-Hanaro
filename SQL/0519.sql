--�Լ�
--�����Լ�
--���ڿ� ���� �Լ�
SELECT ENAME, UPPER(ENAME),LOWER(ENAME),INITCAP(ENAME) FROM EMP;
--
SELECT*FROM EMP WHERE ENAME = 'SCOTT';
SELECT*FROM EMP WHERE UPPER(ENAME) = 'SCOTT';
SELECT*FROM EMP WHERE LOWER(ENAME) = 'scott';
SELECT*FROM EMP WHERE LOWER(ENAME) LIKE 's%';

--���ڿ� ����
SELECT ENAME, LENGTH(ENAME) FROM EMP;
SELECT ENAME, LENGTH(ENAME) FROM EMP WHERE LENGTH(ENAME)>=5;
SELECT ENAME FROM EMP WHERE LENGTH(ENAME)>=5;

--���ڿ� ����Ʈ ��
--DUAL : ������ ���� SYS ���� ���̺�, �Լ� ����̳� ���� �� �׽�Ʈ �������� ����ϴ� ���� ���̺�
SELECT*FROM ALL_TABLES;
SELECT ENAME, LENGTHB(ENAME) FROM EMP;
SELECT LENGTH('HELLO'),LENGTHB('HELLO') FROM DUAL;
SELECT LENGTH('�ȳ�'), LENGTHB('�ȳ�') FROM DUAL;

--���ڿ� �Ϻ� ����
SELECT JOB FROM EMP;

--SUBSTR(���� ����, ���� �ڸ���)
SELECT JOB, SUBSTR(JOB,1,2) FROM EMP; --����
SELECT JOB, SUBSTR(JOB,3,5) FROM EMP; -- 5����
SELECT JOB, SUBSTR(JOB,3) FROM EMP; --������ �� �̱�

--����, ���ڼ��� �����ϱ� ����� �� LENGTH()
--LENGTH('CLERK') : 1~5
SELECT JOB, LENGTH(JOB) FROM EMP;
--ó������ ������ ���
--   -LENGTH('CLERK') : -5~-1
SELECT JOB, SUBSTR(JOB, -LENGTH(JOB)) FROM EMP;
SELECT JOB, SUBSTR(JOB, -LENGTH(JOB),2) FROM EMP;

--�ڿ��� ã�� ���� ��
SELECT JOB, SUBSTR(JOB,LENGTH(JOB)) FROM EMP;
SELECT JOB, SUBSTR(JOB,LENGTH(JOB)-1) FROM EMP;
SELECT JOB, SUBSTR(JOB,LENGTH(JOB)-2) FROM EMP;
SELECT JOB, SUBSTR(JOB,LENGTH(JOB)-3) FROM EMP;

--INSTR() : Ư�� ������ ��ġ�� �˷��ִ� �Լ�
SELECT INSTR('HELLO,ORACLE!','L'),
    INSTR('HELLO,ORACLE!','L',5),
    INSTR('HELLO,ORACLE!','L',2,2)
    FROM DUAL;

SELECT '010-2122-1123',
        REPLACE('010-2122-1123','-',' '), -- => ��� ��ȣ�� BLANCK�� ��ü
        REPLACE('010-2122-1123','-','*'), -- => ��� ��ȣ�� *�� ��ü
        REPLACE('010-2122-1123','-') -- => ��� ��ȣ�� ����
    FROM DUAL;
    
--��ĭ�� Ư�� ���ڷ� ä���
--LPAD : LEFT ���� ���
--RPAD : RIGHT���� ���
SELECT 'Oracle',
        LPAD('Oracle',10,'#'), -- 10�ڸ�, ORACLE ���ڸ� �����ʺ��� �ְ�, ���� �ڸ��� ���ʿ��� # ä��
        RPAD('Oracle',10,'*'),
        LPAD('Oracle',10),
        RPAD('Oracle',10)    FROM DUAL;
        
--���ڿ���ġ�� CONCAT
SELECT EMPNO,ENAME FROM EMP WHERE ENAME ='SCOTT';
SELECT CONCAT(EMPNO,ENAME) FROM EMP WHERE ENAME='SCOTT';
SELECT CONCAT(':',ENAME), CONCAT(EMPNO,CONCAT(':',ENAME)) FROM EMP WHERE ENAME='SCOTT';

--||�� ���ڿ� ��ġ��
SELECT EMPNO || ENAME FROM EMP WHERE ENAME = 'SCOTT';
SELECT ':' || ENAME, EMPNO || ':' || ENAME FROM EMP WHERE ENAME = 'SCOTT';

--Ư�� ���ڸ� ����� �Լ�
--TRIM = �յ� = TRIM BOTH FROM
--LTRIM = �� = ���� = TRIM LEADING FROM
--RTRIM = �� = ������ = TRIM TRAILING FROM
--� ���ڸ� ������ ������ ������ ���� ����
SELECT '['||' _ _Oracle_ _ '||']',
       '['||TRIM(' _ _Oracle_ _ ')||']',
       '['||TRIM(BOTH FROM' _ _Oracle_ _ ')||']',
       '['||TRIM(LEADING FROM' _ _Oracle_ _ ')||']',
       '['||TRIM(TRAILING FROM' _ _Oracle_ _ ')||']'
       FROM DUAL;

--TRIM, LTRIM, RTRIM �Լ��� �ٲ㼭 �״�� ����
SELECT '['||' _ _Oracle_ _ '||']',
       '['||TRIM(' _ _Oracle_ _ ')||']',
       '['||LTRIM(' _ _Oracle_ _ ')||']',
       '['||RTRIM(' _ _Oracle_ _ ')||']'
       FROM DUAL;

--������� �ϴ� ���� �����ؼ� ���
SELECT '['||'_ _Oracle_ _'||']',
       '['||TRIM('_ _Oracle_ _')||']',
       '['||TRIM(BOTH '_' FROM '_ _Oracle_ _')||']',
       '['||TRIM(LEADING '_' FROM'_ _Oracle_ _')||']',
       '['||TRIM(TRAILING '_' FROM'_ _Oracle_ _')||']'
       FROM DUAL;

--TRIM, LTRIM, RTRIM �Լ��� �ٲ㼭 �״�� ����
SELECT '['||' _ _Oracle_ _ '||']',
       '['||TRIM('_ _Oracle_ _')||']', -- => TRIM �Լ��� Ư�� ���� ���� �Ұ���, ���鸸 ���� ����
       '['||LTRIM('_ _Oracle_ _','_')||']',
       '['||RTRIM('_ _Oracle_ _','_')||']'
       FROM DUAL;
       
--�����Լ�
--�ݿø�, ǥ���� �ڸ���
SELECT ROUND(1234.5678),
       ROUND(1234.5678 , 0),
       ROUND(1234.5678 , 1),
       ROUND(1234.5678 , 2),
       ROUND(1234.5678 , -1),
       ROUND(1234.5678 , -2)
    FROM DUAL;

--������, ǥ���� �ڸ���  
SELECT TRUNC(1234.5678),
       TRUNC(1234.5678 , 0),
       TRUNC(1234.5678 , 1),
       TRUNC(1234.5678 , 2),
       TRUNC(1234.5678 , -1),
       TRUNC(1234.5678 , -2)
    FROM DUAL;
    
--���� ��ȯ �Լ�
SELECT CEIL(3.14),
       FLOOR(3.14),  -- 3 < 3.14 < 4
       CEIL(-3.14),
       FLOOR(-3.14)  -- -4 < -3.14 < -3
    FROM DUAL;

--�������� ���ϱ�
SELECT MOD(6,4),
       MOD(15,6),
       MOD(10,2)
    FROM DUAL;

-- ��¥ ������ + ��¥ ������ ������ �Ұ��� 
-- ��¥ �Լ�
-- ���� ��¥
SELECT SYSDATE FROM DUAL;
SELECT SYSDATE - 1 FROM DUAL;
SELECT SYSDATE + 1 FROM DUAL;
SELECT SYSDATE +100 FROM DUAL;
-- Ư�� ���� ���� ��¥ Ȯ��
SELECT SYSDATE, ADD_MONTHS(SYSDATE,3) FROM DUAL;
SELECT SYSDATE, ADD_MONTHS(SYSDATE,120) FROM DUAL;

--���� < �̷� 
SELECT * FROM EMP;
SELECT ENAME,HIREDATE, ADD_MONTHS(HIREDATE,120) FROM EMP;
SELECT ENAME,HIREDATE, ADD_MONTHS(HIREDATE,492),SYSDATE
    FROM EMP 
   WHERE ADD_MONTHS(HIREDATE,492)>SYSDATE;

--�ʰ�
SELECT * FROM EMP;
SELECT ENAME,HIREDATE, ADD_MONTHS(HIREDATE,120) FROM EMP;
SELECT ENAME,HIREDATE, ADD_MONTHS(HIREDATE,492),SYSDATE
    FROM EMP 
   WHERE ADD_MONTHS(HIREDATE,492)<SYSDATE;
   
--���� �� ����
SELECT EMPNO, ENAME,HIREDATE,SYSDATE,
    MONTHS_BETWEEN(HIREDATE,SYSDATE),
    MONTHS_BETWEEN(SYSDATE, HIREDATE),
    TRUNC(MONTHS_BETWEEN(SYSDATE,HIREDATE))
    FROM EMP;
    
--���ƿ��� ������ ��¥
--�ش� ���� ������ ��¥
SELECT SYSDATE, NEXT_DAY(SYSDATE,'������'),LAST_DAY(SYSDATE) FROM DUAL;

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

--��¥ �ð� ���� �Է��ؾ� ��
--���ڸ� ���ڷ� ��ȯ TO _CHAR()
--�������� /�� ����, �ú��ʴ� :���� ����
SELECT EMPNO,EMPNO+'1000' FROM EMP;
SELECT SYSDATE, TO_CHAR(SYSDATE,'YYYY/MM/DD HH24:MI:SS')FROM EMP;


SELECT SYSDATE,
     TO_CHAR(SYSDATE,'MM'), -- ���� ��
     TO_CHAR(SYSDATE,'MON'), -- �̸� ��, ����
     TO_CHAR(SYSDATE,'MONTH'), --�̸� ��, FULL NAME 
     TO_CHAR(SYSDATE,'DD'), --���� ��
     TO_CHAR(SYSDATE,'DY'),-- �̸� ����, ����
     TO_CHAR(SYSDATE,'DAY') -- �̸� ���� ,FULL NAME
    FROM DUAL;
    

SELECT SYSDATE,
     TO_CHAR(SYSDATE,'MM'), -- ���� ��
     TO_CHAR(SYSDATE,'MON'), -- �̸� ��, ����
     TO_CHAR(SYSDATE,'MONTH'), --�̸� ��, FULL NAME 
     TO_CHAR(SYSDATE,'DD'), --���� ��
     TO_CHAR(SYSDATE,'DY'),-- �̸� ����, ����
     TO_CHAR(SYSDATE,'DAY') -- �̸� ���� ,FULL NAME
    FROM DUAL;

SELECT SYSDATE,
     TO_CHAR(SYSDATE,'MM'), -- ���� ��
     
     TO_CHAR(SYSDATE,'MON','NLS_DATE_LANGUAGE=KOREAN'), -- �̸� ��, ����
     TO_CHAR(SYSDATE,'MON','NLS_DATE_LANGUAGE=JAPANESE'), -- �̸� ��, ����
     TO_CHAR(SYSDATE,'MON','NLS_DATE_LANGUAGE=ENGLISH'), -- �̸� ��, ����
    
     TO_CHAR(SYSDATE,'MONTH','NLS_DATE_LANGUAGE=KOREAN'), --�̸� ��, FULL NAME 
     TO_CHAR(SYSDATE,'MONTH','NLS_DATE_LANGUAGE=JAPANESE'), --�̸� ��, FULL NAME 
     TO_CHAR(SYSDATE,'MONTH','NLS_DATE_LANGUAGE=ENGLISH') --�̸� ��, FULL NAME 
    FROM DUAL;
    
SELECT SYSDATE,
     TO_CHAR(SYSDATE,'DD'), --���� ��
     TO_CHAR(SYSDATE,'DY','NLS_DATE_LANGUAGE=KOREAN'),-- �̸� ����, ����
     TO_CHAR(SYSDATE,'DY','NLS_DATE_LANGUAGE=JAPANESE'),-- �̸� ����, ����
     TO_CHAR(SYSDATE,'DY','NLS_DATE_LANGUAGE=ENGLISH'),-- �̸� ����, ����
     
     TO_CHAR(SYSDATE,'DAY','NLS_DATE_LANGUAGE=KOREAN'), -- �̸� ���� ,FULL NAME
     TO_CHAR(SYSDATE,'DAY','NLS_DATE_LANGUAGE=JAPANESE'), -- �̸� ���� ,FULL NAME
     TO_CHAR(SYSDATE,'DAY','NLS_DATE_LANGUAGE=ENGLISH') -- �̸� ���� ,FULL NAME
   FROM DUAL;
   
--�ú���
SELECT SYSDATE, TO_CHAR(SYSDATE,'HH24:MI:SS'), --24�ð�
                TO_CHAR(SYSDATE,'HH12:MI:SS'), --12�ð�
                TO_CHAR(SYSDATE,'HH12:MI:SS PM'), --12�ð� ����/���� ����
                TO_CHAR(SYSDATE,'HH:MI:SS PM') -- 12�ð� ����/���� ����
        FROM DUAL;
        
--���� ����
--���ڸ� ���ڷ� ��ȯ
SELECT SAL,
       TO_CHAR(SAL,'$999,999'), -- $, õ������ (,)ǥ��
       TO_CHAR(SAL,'L999,999'), -- L => ���� ��ȭ�� (�ѱ� : ��), õ���� (,) ǥ��
       TO_CHAR(SAL,'999,999.00'), -- õ���� (,)ǥ��, �Ҽ��� 2�ڸ� (���ڷθ� ǥ��, ���� ǥ��X)
       TO_CHAR(SAL,'000,999,999.00'), --���� 9�ڸ� & �Ҽ��� 2�ڸ�, õ���� (,) ǥ��, ���� ä��� ���� �ڸ��� 0���� ä��
       TO_CHAR(SAL,'000999999.99'), -- ���� 9�ڸ�, �Ҽ��� 2�ڸ�, õ���� ǥ�� X, ���� ä��� ���� �ڸ��� 0���� ä��
       TO_CHAR(SAL,'999,999,00') -- ���� �ڸ����� ,ǥ��
    
    FROM EMP;

--���� �� ��ȯ
--�Ͻ��� �� ��ȯ = ���ڸ� ���ڷ� ��ȯ : TO_NUMBER �Լ��� ������� �ʾƵ� �� ��ȯ�� �ȴ� �˾Ƽ� �˾Ƽ�~
SELECT 1300-'1500','1300'+1500 FROM DUAL;

--����� �� ��ȯ
SELECT 1300-TO_NUMBER('1500'),TO_NUMBER('1300')+1500 FROM DUAL;

--TO_NUMBER �Լ��� ����Ͽ� ���� �ذ�
SELECT '1,300'-'1,500' FROM DUAL; -- õ���� ,ǥ�� �Ϸ��� ��������~~~!~!~!!~@#@#@#!
SELECT TO_NUMBER('1,300','999,999')-TO_NUMBER('1,500','999,999') FROM DUAL;

--��¥ �� ��ȯ
SELECT TO_DATE('2023-05-19','YYYY/MM/DD') FROM DUAL;
SELECT TO_DATE('20230519','YYYY/MM/DD') FROM DUAL;
SELECT TO_DATE('2023-05-19','YYYY-MM-DD') FROM DUAL; -- ������´� -�� �ƴ� /�� ���
SELECT TO_DATE('20230519','YYYY-MM-DD') FROM DUAL;
SELECT TO_DATE('2023-05-19','YY.MM.DD') FROM DUAL;
SELECT TO_DATE('2023 05 19','YYYY/MM/DD') FROM DUAL;

--��� �����Ϳ��� 81�� 7�� 1�� ���Ŀ� �Ի��� ����� ������ �Ի��� ���
SELECT ENAME,HIREDATE 
FROM EMP 
WHERE HIREDATE >= TO_DATE('1981/07/01','YYYY/MM/DD'); 

SELECT ENAME,HIREDATE 
FROM EMP 
WHERE HIREDATE < TO_DATE('1981/07/01','YYYY/MM/DD'); 

--RR : 1950 ~ 2049 �� ���� ���� �� �ִ�
SELECT TO_DATE('49/12/10','YY/MM/DD') AS Y1, -- 2049 ���
       TO_DATE('49/12/10','RR/MM/DD') AS Y2, -- 2049 ���
       TO_DATE('50/12/10','YY/MM/DD') AS Y3, -- 2050 ���
       TO_DATE('50/12/10','RR/MM/DD') AS Y4, -- 1950 ���
       TO_DATE('51/12/10','YY/MM/DD') AS Y5, -- 2051 ���
       TO_DATE('51/12/10','RR/MM/DD') AS Y6  -- 1951 ���
    FROM DUAL;

--NULL�� ó���ϴ� �Լ�
--NVL�Լ� : NULL ���� ��, ���� ���ϴ� ������ ����
SELECT * FROM EMP;
SELECT EMPNO,ENAME,SAL,COMM,SAL+COMM,NVL(COMM,0),SAL+NVL(COMM,0) FROM EMP;

--NVL2 �Լ� : ù��° �Ű����� - NULL���� �ƴ� �� ������ ��, �ι�° �Ű����� - NULL���� �� ������ ��
SELECT EMPNO,ENAME,SAL,COMM,SAL+COMM,NVL2(COMM,'O','X'),SAL+NVL2(COMM,SAL*12+COMM,SAL*12) FROM EMP;

--��Ȳ�� ���� �ٸ� ������ ��ȯ
--DECODE : ���ٴ� ���Ǹ� ����
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
       
-- CASE���� ���ٶ�� ���� ���� ��밡��
SELECT EMPNO,ENAME,COMM, 
       CASE 
        WHEN COMM IS NULL THEN '�ش� ���� ����'
        WHEN COMM = 0 THEN '���� ����'
        WHEN COMM > 0 THEN '���� : '||COMM
       END AS COMM_CMT
    FROM EMP;

-- ������ �Լ� = ����� �Ѱ� = �ϳ��� ������ ���  ( ���� �Լ����� ������ �Լ� )
SELECT SAL FROM EMP; -- �� 14��
SELECT SUM(SAL) FROM EMP; -- �� 1��

-- ���� ���� ���� ���� ����Ϸ��� ���� ������ ���ƾ� ��
-- NULL ���� �ڵ����� �����ϰ� ������� ( NULL���� ���ԵǾ ��� ���� )
SELECT SUM(COMM),SUM(SAL) FROM EMP;

--����  ������ �����Ƿ� ���� ��� ����
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
    
--NULL ���� ���� ���    
SELECT COUNT(COMM) FROM EMP;
SELECT COUNT(*) FROM EMP WHERE COMM IS NULL;

--�ִ밪
SELECT MAX(SAL) FROM EMP;
SELECT MAX(SAL) FROM EMP WHERE DEPTNO=30;
SELECT MAX(HIREDATE) FROM EMP; -- ���� �ֱ� �Ի����� �Ի���
SELECT MAX(HIREDATE) FROM EMP WHERE SAL>3000;

--�ּҰ�
SELECT MIN(SAL) FROM EMP;
SELECT MIN(SAL) FROM EMP WHERE DEPTNO!=10;
SELECT MIN(HIREDATE) FROM EMP; -- ���� ������ �Ի����� �Ի���

--���
SELECT AVG(SAL) FROM EMP;
SELECT AVG(SAL) FROM EMP WHERE DEPTNO = 30;
SELECT AVG(COMM) FROM EMP; --�ڵ����� NULL�� ���� �� ���
SELECT AVG(COMM) FROM EMP WHERE DEPTNO = 30;

