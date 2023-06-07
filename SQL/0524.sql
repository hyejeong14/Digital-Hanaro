--객체
--오라클 데이터베이스 테이블
--1) 사용자 테이블

--2) 데이터 사전
--scott 계정에서 보기
SELECT * FROM DICTIONARY;
SELECT * FROM DICT;

--scott 계정이 소유하고 있는 테이블 확인
SELECT * FROM USER_TABLES;

--모든 사용자가 소유하고 있는 테이블
SELECT * FROM ALL_TABLES;

--관리자 계정이 있어야 볼 수 있는 내용
SELECT * FROM DBA_TABLES; -- scott 계정 접속시 오류 구문 : 테이블 또는 뷰가 존재하지 않습니다.
-- 존재하는 테이블이 SCOTT 계정으로 확인이 불가한 이유?
-- 보안의 문제 때문에 존재 여부를 알려주지 않아야 안전
-- 존재하지만 권한이 없다고 알려주면 테이블이 존재한다는 정보 제공

-- 관리자 계정
SELECT * FROM DBA_TABLES; --system 계정에서 확인 가능

--관리자 계정으로 사용자 정보 확인
SELECT * FROM DBA_USERS WHERE USERNAME = 'SCOTT';

--scott 계정
--인덱스 : DB에 있는 데이터를 더 빠르게 찾도록 도와주는 객체
--인덱스가 없다면 풀스캔
SELECT * FROM USER_INDEXES;

--인덱스 열 정보 확인
SELECT * FROM USER_IND_COLUMNS;

--인덱스 생성
CREATE INDEX IDX_EMP_SAL ON EMP(SAL);

--생성한 인덱스 확인
SELECT * FROM USER_IND_COLUMNS;

--인덱스 삭제
DROP INDEX IDX_EMP_SAL;

--삭제 인덱스 확인
SELECT * FROM USER_IND_COLUMNS;

--뷰 : 테이블처럼 사용할 수 있는 객체
--사용목적 : 1) 편리성 2) 보안성
--뷰 생성 권한이 필요
--관리자 계정으로 권한 부여

--명령 프롬프트에서 실행
sqlplus system/oracle

--권한 부여 =GRANT 권한 TO 계정
GRANT CREATE VIEW TO SCOTT;

--SCOTT 계정으로 실행
SELECT * FROM EMP WHERE DEPTNO = 10;
CREATE VIEW VW_EMP10
    AS (SELECT * FROM EMP WHERE DEPTNO = 10);

--뷰 생성 확인
SELECT * FROM USER_VIEWS; --쿼리문만 저장되어 있는 객체, 물리적 데이터 저장 XX

--sqlplus에서 다시 확인
sqlplus scott/tiger
SELECT * FROM USER_VIEWS;
SELECT VIEW_NAME, TEXT FROM USER_VIEWS;

--생성한 뷰 사용
SELECT * FROM EMP WHERE DEPNO=10; -- SELECT * FROM VW_EMP10;으로 대체하여 사용
SELECT * FROM VW_EMP10; --쿼리문이 길어지면 뷰로 확인하는게 간편해진당

--뷰 삭제
DROP VIEW VW_EMP10;

--삭제 확인
SELECT * FROM VW_EMP10; 
SELECT * FROM USER_VIEWS; --데이터 사전으로 뷰 확인하기

--ROWNUM = 테이블의 열이 아닌 가상의 열
SELECT ROWNUM,A.* FROM EMP A;

--급여가 높은 순으로 정렬
SELECT ROWNUM, A.* FROM EMP A ORDER BY SAL DESC; -- 정렬 안댐 ㅡㅅㅡ;;
--급여가 높은 순으로 정렬해서 ROWNUM을 붙이려면 VIEW 사용!
SELECT * FROM EMP ORDER BY SAL DESC;
SELECT ROWNUM, A.* FROM (SELECT * FROM EMP ORDER BY SAL DESC) A; --인라인뷰

--인라인뷰 WITH절로 변환
WITH A AS (SELECT * FROM EMP ORDER BY SAL DESC)
SELECT ROWNUM, A.* FROM A;

--급여가 높은 상위 5개 보기

--인라인뷰
SELECT ROWNUM, A.*
    FROM (SELECT * FROM EMP ORDER BY SAL DESC) A
    WHERE ROWNUM<=5;

--WITH절 사용
WITH A AS (SELECT * FROM EMP ORDER BY SAL DESC)
SELECT ROWNUM, A.* FROM A WHERE ROWNUM <= 5;

--시퀀스 = 일련번호 생성하는 객체 = 규칙을 설정
--DEPT 테이블의 열 구조만 복사해서 테이블 생성
DROP TABLE DEPT_COPY;
CREATE TABLE DEPT_COPY
    AS SELECT * FROM DEPT WHERE 1=2;
SELECT * FROM DEPT_COPY;

--시퀀스 생성
CREATE SEQUENCE SEQ_DEPT
    INCREMENT BY 10 --간격
    START WITH 0 --시작값
    MAXVALUE 90 --최대값
    MINVALUE 0
    NOCYCLE --최대값에 도달하면 인덱스 끝
    CACHE 2; 

--시퀀스 확인
SELECT * FROM USER_SEQUENCES;

--시퀀스 이용해서 데이터 추가하기 * 9번 반복
INSERT INTO DEPT_COPY (DEPTNO, DNAME, LOC)
    VALUES (SEQ_DEPT.NEXTVAL, 'DA', 'SEOUL'); -- 시작값 0의 다음 시퀀스 10
    --10번째 반복하면 오류 : MAXVALUE 값으로 인해 사례로 될 수 없음
    --최대값 도달, NOCYCLE이기 때문에 추가 불가
    
--데이터 확인
SELECT * FROM DEPT_COPY;

--시퀀스 사용 방법
SELECT SEQ_DEPT.CURRVAL FROM DUAL; -- 현재 시퀀스 CURRVAL
SELECT SEQ_DEPT.NEXTVAL FROM DUAL; -- 다음 시퀀스 확인

--시퀀스 수정 방법
ALTER SEQUENCE SEQ_DEPT
    INCREMENT BY 3 --간격
    MAXVALUE 99
    CYCLE; --마지막 시퀀스에서 처음 시퀀스로 돌아감

--테이블 상태 확인
SELECT * FROM DEPT_COPY; --10번부터 90번까지 9개의 시퀀스 존재

--3번 실행
INSERT INTO DEPT_COPY (DEPTNO, DNAME, LOC)
    VALUES (SEQ_DEPT.NEXTVAL, 'DA', 'SEOUL');
    
--테이블 상태 확인
SELECT * FROM DEPT_COPY; --93,96,99 3개 시퀀스 추가, 최대값 99에 도달

--3번 더 실행
INSERT INTO DEPT_COPY (DEPTNO, DNAME, LOC)
    VALUES (SEQ_DEPT.NEXTVAL, 'DA', 'SEOUL');

--테이블 상태 확인
SELECT * FROM DEPT_COPY; -- 0,3,6 시퀀스 추가, 99 최대값 이후 0으로 돌아감

--시퀀스 삭제
DROP SEQUENCE SEQ_DEPT;

--시퀀스 삭제 확인
SELECT * FROM USER_SEQUENCES;

--시노님 = 공식적인 별칭 = 일회성 별칭이 아님 = 시노님 객체 삭제 전까지 지속적으로 사용 가능
--SELECT 열 이름 AS 별칭 => 일회성

--시노님 생성 권한 필요
--관리자 계정으로 권한 부여
--CMD에서 실행
sqlplus system/oracle
--권한 부여 = GRANT 권한 TO 계정
GRANT CREATE SYNONYM TO SCOTT;
GRANT CREATE PUBLIC SYNONYM TO SCOTT;

--SCOTT 계정으로 실행
CREATE SYNONYM E FOR EMP;

--시노님 사용
SELECT * FROM EMP;
SELECT * FROM E;

--시노님 삭제
DROP SYNONYM E;

--삭제 확인
SELECT * FROM E;
SELECT * FROM EMP; --원래 이름 EMP는 사용 가능

--제약 조건
--1) NOT NULL = 빈값 허용하지 않음 = 빈값 불가
CREATE TABLE TABLE_NOTNULL (
    LOG_ID VARCHAR2(15) NOT NULL ,
    LOG_PW VARCHAR2(15) NOT NULL ,
    CP     VARCHAR2(15) 
    );
    
SELECT * FROM TABLE_NOTNULL;

DESC TABLE_NOTNULL;

--NULL 값 추가
INSERT INTO TABLE_NOTNULL (LOG_ID, LOG_PW, CP)
    VALUES ('TEST_ID_1',NULL,'010-1234-5678'); -- NOT NULL 제약 조건으로 추가 불가

INSERT INTO TABLE_NOTNULL (LOG_ID, CP)
    VALUES ('TEST_ID_1','010-1234-5678'); -- 암시적 입력 : 생략 값은 NULL값으로 인식되어 추가 불가
    
INSERT INTO TABLE_NOTNULL (LOG_ID, LOG_PW, CP)
    VALUES ('TEST_ID_1', 'TEST_PW_1', '010-1234-5678'); 

--전화번호에 NULL값 추가
INSERT INTO TABLE_NOTNULL (LOG_ID, LOG_PW)
    VALUES ('TEST_ID_1', 'TEST_PW_1'); --제약조건 없으므로 추가 가능
    
SELECT * FROM TABLE_NOTNULL;
DELETE FROM TABLE_NOTNULL WHERE CP='010-1234-5678';

-- NULL 값으로 변경
UPDATE TABLE_NOTNULL
    SET LOG_PW = NULL --제약 조건으로 인해 변경 불가
    WHERE LOG_ID = 'TEST_ID_1';

--제약조건 확인 방법 : 데이터 사전으로 확인하기
--CONSTRAINT_TYPE : P = PRIMARY KEY, R = REFERENCE, C = CHECK/NOT NULL, U = UNIQUE
SELECT * FROM USER_CONSTRAINTS;

--제약조건 이름 지정
CREATE TABLE TABLE_NOTNULL1(
    LOG_ID VARCHAR2(15) CONSTRAINT TBNN1_LOGID_NN NOT NULL,
    LOG_PW VARCHAR2(15) CONSTRAINT TBNN1_LOGPW_NN NOT NULL,
    CP VARCHAR2(15)
);

--제약 조건 확인    
SELECT * FROM USER_CONSTRAINTS;

--제약 조건 변경 (추가)
ALTER TABLE TABLE_NOTNULL1
    MODIFY (CP NOT NULL);
    
SELECT * FROM USER_CONSTRAINTS;

--이미 테이블에 NULL값이 있기 때문에 변경 안됨
ALTER TABLE TABLE_NOTNULL
    MODIFY (CP NOT NULL);

SELECT * FROM TABLE_NOTNULL;

--전화번호 NULL 값을 다른 값으로 변경
UPDATE TABLE_NOTNULL
    SET CP='010-1234-5678'
    WHERE LOG_ID = 'TEST_ID_1';

SELECT * FROM TABLE_NOTNULL;

ALTER TABLE TABLE_NOTNULL
    MODIFY (CP NOT NULL); --제약조건 변경 / 이름 지정 X

SELECT * FROM USER_CONSTRAINTS;

--NOTNULL1 제약조건 이름 지정해서 바꾸기
ALTER TABLE TABLE_NOTNULL1 DROP CONSTRAINT SYS_C0011057;

ALTER TABLE TABLE_NOTNULL1
    MODIFY (CP CONSTRAINT TBNN1_CP_NN NOT NULL); --이름 지정

SELECT * FROM USER_CONSTRAINTS;
DESC TABLE_NOTNULL;
DESC TABLE_NOTNULL1;

--제약 조건 이름 변경
ALTER TABLE TABLE_NOTNULL1
    RENAME CONSTRAINT TBNN1_CP_NN TO TBNN1_CP_NN_AFTER;

SELECT * FROM USER_CONSTRAINTS;

--제약 조건 삭제
ALTER TABLE TABLE_NOTNULL1
    DROP CONSTRAINT TBNN1_CP_NN_AFTER;

SELECT * FROM USER_CONSTRAINTS;


-- UNIQUE = 중복 불가
-- 제약조건 이름 지정하여 만들기
CREATE TABLE TB_UNQ(
    LOG_ID VARCHAR2(15) CONSTRAINT TBUNQ_LOGID_UNQ UNIQUE,
    LOG_PW VARCHAR2(15) CONSTRAINT TBUNQ_LOGPW_UNQ UNIQUE,
    CP     VARCHAR2(15) 
    );

SELECT * FROM USER_CONSTRAINTS;

--원하는 제약 조건만 보기
--LIKE 연산자와 와일드카드 사용
SELECT * FROM USER_CONSTRAINTS WHERE CONSTRAINT_NAME LIKE '%TBUNQ%'; 

--데이터 추가
INSERT INTO TB_UNQ (LOG_ID, LOG_PW, CP)
    VALUES ('TEST_ID_1','TEST_PW_1','010-1234-5678'); 
    -- 한 번 더 실행하면 오류
    -- ID와 PW는 UNIQUE 제약 조건이 있으므로 중복 데이터 추가 불가

INSERT INTO TB_UNQ (LOG_ID, LOG_PW, CP)
    VALUES ('TEST_ID_2','TEST_PW_2','010-1234-5678');
    -- 전화번호는 제약 조건이 없기 때문에 중복 입력이 가능하다
SELECT*FROM TB_UNQ;

--UNIQUE 제약 조건에 NULL 값 추가
INSERT INTO TB_UNQ (LOG_ID, LOG_PW, CP)
    VALUES ('NULL','TEST_PW_3','010-1234-5678'); -- UNIQUE 제약 조건은 NULL 값 가능
SELECT*FROM TB_UNQ;

UPDATE TB_UNQ
    SET LOG_ID=NULL
    WHERE LOG_PW='TEST_PW_3';
    
INSERT INTO TB_UNQ (LOG_PW, CP)
    VALUES ('TEST_PW_4','010-1234-5678'); -- NULL값은 중복 대상 아님

SELECT*FROM TB_UNQ;

--데이터 변경
UPDATE TB_UNQ
    SET LOG_ID = 'TEST_ID_1' -- 중복 데이터므로 변경 불가
    WHERE LOG_PW = 'TEST_PW_3';

UPDATE TB_UNQ
    SET LOG_ID = 'TEST_ID_3'
    WHERE LOG_PW = 'TEST_PW_3';

SELECT*FROM TB_UNQ;

--기본키 = PRIMARY KEY = NOT NULL + UNIQUE
CREATE TABLE TB_PK(
    LOG_ID VARCHAR2(15) CONSTRAINT TBPK_LOGID_PK PRIMARY KEY,
    LOG_PW VARCHAR2(15) CONSTRAINT TBPK_LOGPW_NN NOT NULL,
    CP     VARCHAR2(15)
    );

SELECT*FROM TB_PK;

--데이터 추가
INSERT INTO TB_PK (LOG_ID, LOG_PW, CP)
    VALUES ('TEST_ID_1','TEST_PW_1','010-1234-5678');
SELECT*FROM TB_PK;

--중복&NULL 데이터 추가 : LOG_ID PK로 중복&NULL 불가
INSERT INTO TB_PK (LOG_ID, LOG_PW, CP)
    VALUES ('TEST_ID_1','TEST_PW_1','010-1234-5678');
INSERT INTO TB_PK (LOG_PW, CP)
    VALUES ('TEST_PW_1','010-1234-5678');

INSERT INTO TB_PK (LOG_ID, LOG_PW, CP)
    VALUES ('TEST_ID_2','TEST_PW_1','010-1234-5678');
SELECT * FROM TB_PK;

--외래키 FK (FOREIGN KEY) = 참조키 = 다른 테이블의 기본키를 참조
--EMP, DEPT 테이블이 가지고 있는 제약조건  확ㅇ니
SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME IN ('EMP', 'DEPT');

--EMP 테이블에 DEPT 테이블에 없는 부서 번호를 입력
SELECT * FROM EMP;
SELECT * FROM DEPT;

INSERT INTO EMP
    VALUES(9999,'QUEEN','VICE',7839, '2023-05-23', 5000, NULL, 90); 
    --오류 구문 : 부모 키가 없습니다.
    -- => 참조할 수 있는 값이 없음 DEPT TABLE의 DEPTNO가 FK로 작용
    --부서 테이블에 90번 부서 데이터를 먼저 입력 후 추가해야 함
    
--테이블 생성
CREATE TABLE DEPT_FK(
    DEPTNO NUMBER(2) CONSTRAINT DEPTFK_DEPTNO_FK PRIMARY KEY,
    DNAME VARCHAR2(15)
    );

CREATE TABLE EMP_FK(
    EMPNO  NUMBER(4) CONSTRAINT EMPFK_EMPNO_PK PRIMARY KEY,
    ENAME  VARCHAR2(10),
    DEPTNO NUMBER(2) CONSTRAINT EMPFK_DEPTNO_FK REFERENCES DEPT_FK(DEPTNO)
    );

--사원 추가
INSERT INTO EMP_FK
    VALUES (9999, 'QUEEN', 10); -- 오류 : 부모 키가 없습니다.

SELECT*FROM DEPT_FK; -- 데이터 없음 EMP_FK에서 참조할 수 있는 값이 없음

--DEPT_FK 데이터 생성
INSERT INTO DEPT_FK
    VALUES (10,'DA');

INSERT INTO EMP_FK
    VALUES (9999, 'QUEEN', 10); 
    
SELECT*FROM DEPT_FK;
SELECT*FROM EMP_FK;

--외래키가 있을 때 데이터 입력 순서
--1) 외래키 생성
--2) 참조할 데이터 입력 ( EX. DEPTNO 10 )
--3) 데이터 입력 가능 ( EX. QUEEN 10 )
-- 데이터 삭제할 때는 반대로 데이터(자식레코드) 삭제 후 참조한 데이터(부모레코드) 삭제

--삭제하기
--부서 삭제
DELETE FROM DEPT_FK WHERE DEPTNO=10; --오류 구문 : 자식 레코드가 발견되었습니다. 
                                     --10을 참조하고 있는 데이터가 존재함 : QUEEN

--참조하고 있는 데이터부터 삭제 : 사원 데이터 먼저 삭제
DELETE EMP_FK WHERE EMPNO=9999;
DELETE FROM DEPT_FK WHERE DEPTNO=10;

SELECT * FROM EMP_FK;
SELECT * FROM DEPT_FK;

