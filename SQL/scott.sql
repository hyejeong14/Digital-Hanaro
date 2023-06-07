--편집기
-- 주석 처리 ( -- )
-- 주석 ctrl+/
-- 실행 ctrl + enter

-- 사원 테이블
DESC EMP;

-- 부서 테이블
DESC DEPT;

-- 급여 등급 테이블
DESC SALGRADE;


--SQL 기본 문법
--SELECT ~ FROM
--SELECT 열 이름 FROM 테이블 이름
SELECT * FROM EMP;

--사원 이름 보기
-- 하나의 열만 출력 -> 프로젝션 ( 열 기준 출력 )
SELECT ENAME FROM EMP; 

-- 사원 이름과 직책 함께 출력
SELECT ENAME,JOB FROM EMP;

-- 부서테이블 전체보기
-- 행 4개 * 열 3개
SELECT * FROM DEPT;

-- 부서 이름만 출력 ( 특정 열 출력, 프로젝션 )
SELECT DNAME FROM DEPT;

-- 부서 이름 & 부서 위치 보기
SELECT DNAME,LOC FROM DEPT;

-- 중복 데이터 제거하기 DISTINCT
-- EX) SELECT DISTINCT DEPTNO FROM EMP;
-- EX) 열 두개 가능 SELECT DISTINCT JOB,DEPTNO FROM EMP; -> 두 열의 조합으로 처리

SELECT DEPTNO FROM EMP;
SELECT DISTINCT DEPTNO FROM EMP;
SELECT DISTINCT JOB,DEPTNO FROM EMP;

-- 별칭 설정
-- 공개하기 싫은 정보를 감추거나 열 이름이 길때 등등 별칭을 설정하여 해결
SELECT ENAME, SAL, SAL*12+COMM FROM EMP;
SELECT ENAME, SAL, SAL*12+COMM AS ANNSAL FROM EMP;
SELECT ENAME, SAL, SAL+SAL+SAL+SAL+SAL+SAL+SAL+SAL+SAL+SAL+SAL+COMM FROM EMP;
SELECT ENAME, SAL, SAL+SAL+SAL+SAL+SAL+SAL+SAL+SAL+SAL+SAL+SAL+COMM AS ANNSAL FROM EMP;

--원하는 순서대로 정렬하는 명령어 ORDER BY
--SELECT ~ FROM ~ ORDER BY 정렬하려는 열 이름과 정렬 옵션 ( DESC 내림 차순, ASC 오름 차순 ... )
--오름차순은 생략가능 ( 디폴트 값 )
SELECT * FROM EMP ORDER BY SAL ASC; --오름차순
SELECT * FROM EMP ORDER BY SAL; -- DEFAULT가 ASC이기 때문에 생략 가능
SELECT * FROM EMP ORDER BY SAL DESC; -- 내림차순
SELECT * FROM EMP ORDER BY ENAME DESC; 
SELECT * FROM EMP ORDER BY HIREDATE DESC;
SELECT * FROM EMP ORDER BY DEPTNO ASC, SAL DESC; --DEPTNO 먼저 정렬, 같은 값 내에서 SAL 내림차순 정렬

--셀렉션 ( 행 기준 출력 ) 
-- WHERE 절
-- SELECT ~ FORM ~ WHERE 조건식
SELECT * FROM EMP WHERE DEPTNO=30;
SELECT * FROM EMP WHERE SAL>=1600;
SELECT * FROM EMP WHERE EMPNO = 7782;
SELECT * FROM EMP WHERE DEPTNO=30 AND JOB='SALESMAN'; --AND 는 교집합

SELECT * FROM EMP ORDER BY HIREDATE DESC;
SELECT * FROM EMP WHERE HIREDATE < '81/05/23';

--OR 조건
SELECT * FROM EMP WHERE HIREDATE < '81/05/01' OR DEPTNO = 10;
SELECT * FROM EMP WHERE DEPTNO = 20 OR JOB='SALESMAN' ORDER BY DEPTNO;

--산술연산자 사칙연산
SELECT * FROM EMP WHERE SAL *12 <36000;

--비교연산자
SELECT * FROM EMP WHERE JOB>'C';
SELECT * FROM EMP WHERE JOB<'B';
SELECT * FROM EMP WHERE SAL < 3000 AND JOB = 'ANALYST';
SELECT * FROM EMP WHERE JOB!='ANALYST';
SELECT * FROM EMP WHERE JOB='ANALYST';
SELECT * FROM EMP WHERE DEPTNO!=30;

SELECT * FROM EMP WHERE NOT DEPTNO =30;
SELECT * FROM EMP WHERE NOT JOB='ANALYST' AND DEPTNO=30;

--IN 연산자 = OR 조건 여러 개
SELECT * FROM EMP WHERE JOB IN ('MANAGER','CLERK','SALESMAN');
--윗 줄 풀어쓰면?
SELECT * FROM EMP WHERE JOB = 'MANAGER' OR JOB='CLERK' OR JOB='SALESMAN';

--NOT IN 연산자
SELECT * FROM EMP WHERE JOB NOT IN ('SALESMAN','CLERK');
SELECT * FROM EMP WHERE JOB NOT IN ('MANAGER','CLERK','SALESMAN');
--윗 줄 풀어쓰면?
SELECT * FROM EMP WHERE JOB != 'MANAGER' AND JOB!='CLERK' AND JOB!='SALESMAN';

--10번 20번 부서에서 근무하는 직원 / 30번 부서에서 근무하는 직원 나눠보래애래래래ㅐ내
SELECT ENAME,DEPTNO FROM EMP WHERE  DEPTNO NOT IN 30;
SELECT ENAME,DEPTNO FROM EMP WHERE DEPTNO IN (10,20);
SELECT ENAME,DEPTNO FROM EMP WHERE DEPTNO IN 30;
SELECT ENAME,DEPTNO FROM EMP WHERE DEPTNO NOT IN (10,20);

--BETWEEN A AND B 연산자
SELECT * FROM EMP WHERE SAL NOT BETWEEN 2000 AND 3000;
SELECT * FROM EMP WHERE SAL < 2000 OR SAL > 3000;
SELECT * FROM EMP WHERE SAL BETWEEN 2000 AND 3000;
SELECT * FROM EMP WHERE SAL > 2000 AND SAL <= 3000;

--LIKE연산자와 와일드카드
SELECT * FROM EMP;
SELECT * FROM EMP WHERE ENAME LIKE '%A%';
SELECT * FROM EMP WHERE ENAME LIKE 'S%';
SELECT * FROM EMP WHERE ENAME LIKE '_O%';
SELECT * FROM EMP WHERE ENAME LIKE '%E_';
SELECT * FROM EMP WHERE ENAME LIKE '___E%';
SELECT * FROM EMP WHERE ENAME LIKE '%AM%';

--IS NULL 연산자
SELECT ENAME,SAL,SAL*12+COMM AS ANNSAL, COMM FROM EMP;
SELECT ENAME,SAL,SAL*12+COMM AS ANNSAL, COMM FROM EMP WHERE COMM IS NOT NULL;
SELECT * FROM EMP WHERE COMM IS NOT NULL;
SELECT * FROM EMP WHERE COMM IS NULL;

--직속상관이 있는 사람과 없는 사람 
SELECT * FROM EMP WHERE MGR IS NOT NULL; -- 있는 사람
SELECT * FROM EMP WHERE MGR IS NULL; -- 없는 사람

--NULL을 이용한 AND/OR 연산자
SELECT * FROM EMP WHERE SAL IS NULL;
SELECT * FROM EMP WHERE SAL > NULL AND COMM IS NULL;
SELECT * FROM EMP WHERE SAL > NULL OR COMM IS NULL;
SELECT * FROM EMP WHERE COMM IS NULL;

--집합 연산자
SELECT EMPNO,ENAME, SAL, DEPTNO FROM EMP WHERE DEPTNO =10;
SELECT EMPNO,ENAME, SAL, DEPTNO FROM EMP WHERE DEPTNO =20;
--중복제거하여 합집합 UNION
SELECT EMPNO,ENAME, SAL, DEPTNO FROM EMP WHERE DEPTNO =10
UNION
SELECT EMPNO,ENAME, SAL, DEPTNO FROM EMP WHERE DEPTNO =20;

--중복 제거 확인
SELECT EMPNO,ENAME, SAL, DEPTNO FROM EMP WHERE DEPTNO =10
UNION
SELECT EMPNO,ENAME, SAL, DEPTNO FROM EMP WHERE DEPTNO =10;

SELECT EMPNO,ENAME, SAL, DEPTNO FROM EMP WHERE DEPTNO =10
UNION ALL
SELECT EMPNO,ENAME, SAL, DEPTNO FROM EMP WHERE DEPTNO =10;

--합집합을 사용할 때 주의할 점
--1) 두 번째 테이블의 DEPTNO 빼고 합치기 = 열의 개수가 맞아야 함
SELECT EMPNO,ENAME, SAL, DEPTNO FROM EMP WHERE DEPTNO =10
UNION
SELECT EMPNO,ENAME, SAL FROM EMP WHERE DEPTNO =20;
--2) 열의 순서를 바꿔서 합치기 & 데이터 타입 다르게
SELECT EMPNO,ENAME, SAL, DEPTNO FROM EMP WHERE DEPTNO =10
UNION
SELECT ENAME,EMPNO, SAL, DEPTNO FROM EMP WHERE DEPTNO =20;
--3) 데이터 타입 같게? => 정상으로 돌아가니 주의하자 열 순서 항상 같게!
SELECT EMPNO,ENAME, SAL, DEPTNO FROM EMP WHERE DEPTNO =10
UNION
SELECT EMPNO,ENAME, SAL, MGR FROM EMP WHERE DEPTNO =10;

--교집합 INTERSECT
SELECT EMPNO,ENAME,SAL,DEPTNO FROM EMP
INTERSECT
SELECT EMPNO, ENAME, SAL, DEPTNO FROM EMP WHERE DEPTNO=10;

--차집합 MINUS
SELECT EMPNO, ENAME, SAL, DEPTNO FROM EMP
MINUS
SELECT EMPNO, ENAME, SAL, DEPTNO FROM EMP WHERE DEPTNO=10;