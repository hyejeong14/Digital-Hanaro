--��ü
--����Ŭ �����ͺ��̽� ���̺�
--1) ����� ���̺�

--2) ������ ����
--scott �������� ����
SELECT * FROM DICTIONARY;
SELECT * FROM DICT;

--scott ������ �����ϰ� �ִ� ���̺� Ȯ��
SELECT * FROM USER_TABLES;

--��� ����ڰ� �����ϰ� �ִ� ���̺�
SELECT * FROM ALL_TABLES;

--������ ������ �־�� �� �� �ִ� ����
SELECT * FROM DBA_TABLES; -- scott ���� ���ӽ� ���� ���� : ���̺� �Ǵ� �䰡 �������� �ʽ��ϴ�.
-- �����ϴ� ���̺��� SCOTT �������� Ȯ���� �Ұ��� ����?
-- ������ ���� ������ ���� ���θ� �˷����� �ʾƾ� ����
-- ���������� ������ ���ٰ� �˷��ָ� ���̺��� �����Ѵٴ� ���� ����

-- ������ ����
SELECT * FROM DBA_TABLES; --system �������� Ȯ�� ����

--������ �������� ����� ���� Ȯ��
SELECT * FROM DBA_USERS WHERE USERNAME = 'SCOTT';

--scott ����
--�ε��� : DB�� �ִ� �����͸� �� ������ ã���� �����ִ� ��ü
--�ε����� ���ٸ� Ǯ��ĵ
SELECT * FROM USER_INDEXES;

--�ε��� �� ���� Ȯ��
SELECT * FROM USER_IND_COLUMNS;

--�ε��� ����
CREATE INDEX IDX_EMP_SAL ON EMP(SAL);

--������ �ε��� Ȯ��
SELECT * FROM USER_IND_COLUMNS;

--�ε��� ����
DROP INDEX IDX_EMP_SAL;

--���� �ε��� Ȯ��
SELECT * FROM USER_IND_COLUMNS;

--�� : ���̺�ó�� ����� �� �ִ� ��ü
--������ : 1) ���� 2) ���ȼ�
--�� ���� ������ �ʿ�
--������ �������� ���� �ο�

--��� ������Ʈ���� ����
sqlplus system/oracle

--���� �ο� =GRANT ���� TO ����
GRANT CREATE VIEW TO SCOTT;

--SCOTT �������� ����
SELECT * FROM EMP WHERE DEPTNO = 10;
CREATE VIEW VW_EMP10
    AS (SELECT * FROM EMP WHERE DEPTNO = 10);

--�� ���� Ȯ��
SELECT * FROM USER_VIEWS; --�������� ����Ǿ� �ִ� ��ü, ������ ������ ���� XX

--sqlplus���� �ٽ� Ȯ��
sqlplus scott/tiger
SELECT * FROM USER_VIEWS;
SELECT VIEW_NAME, TEXT FROM USER_VIEWS;

--������ �� ���
SELECT * FROM EMP WHERE DEPNO=10; -- SELECT * FROM VW_EMP10;���� ��ü�Ͽ� ���
SELECT * FROM VW_EMP10; --�������� ������� ��� Ȯ���ϴ°� ����������

--�� ����
DROP VIEW VW_EMP10;

--���� Ȯ��
SELECT * FROM VW_EMP10; 
SELECT * FROM USER_VIEWS; --������ �������� �� Ȯ���ϱ�

--ROWNUM = ���̺��� ���� �ƴ� ������ ��
SELECT ROWNUM,A.* FROM EMP A;

--�޿��� ���� ������ ����
SELECT ROWNUM, A.* FROM EMP A ORDER BY SAL DESC; -- ���� �ȴ� �Ѥ���;;
--�޿��� ���� ������ �����ؼ� ROWNUM�� ���̷��� VIEW ���!
SELECT * FROM EMP ORDER BY SAL DESC;
SELECT ROWNUM, A.* FROM (SELECT * FROM EMP ORDER BY SAL DESC) A; --�ζ��κ�

--�ζ��κ� WITH���� ��ȯ
WITH A AS (SELECT * FROM EMP ORDER BY SAL DESC)
SELECT ROWNUM, A.* FROM A;

--�޿��� ���� ���� 5�� ����

--�ζ��κ�
SELECT ROWNUM, A.*
    FROM (SELECT * FROM EMP ORDER BY SAL DESC) A
    WHERE ROWNUM<=5;

--WITH�� ���
WITH A AS (SELECT * FROM EMP ORDER BY SAL DESC)
SELECT ROWNUM, A.* FROM A WHERE ROWNUM <= 5;

--������ = �Ϸù�ȣ �����ϴ� ��ü = ��Ģ�� ����
--DEPT ���̺��� �� ������ �����ؼ� ���̺� ����
DROP TABLE DEPT_COPY;
CREATE TABLE DEPT_COPY
    AS SELECT * FROM DEPT WHERE 1=2;
SELECT * FROM DEPT_COPY;

--������ ����
CREATE SEQUENCE SEQ_DEPT
    INCREMENT BY 10 --����
    START WITH 0 --���۰�
    MAXVALUE 90 --�ִ밪
    MINVALUE 0
    NOCYCLE --�ִ밪�� �����ϸ� �ε��� ��
    CACHE 2; 

--������ Ȯ��
SELECT * FROM USER_SEQUENCES;

--������ �̿��ؼ� ������ �߰��ϱ� * 9�� �ݺ�
INSERT INTO DEPT_COPY (DEPTNO, DNAME, LOC)
    VALUES (SEQ_DEPT.NEXTVAL, 'DA', 'SEOUL'); -- ���۰� 0�� ���� ������ 10
    --10��° �ݺ��ϸ� ���� : MAXVALUE ������ ���� ��ʷ� �� �� ����
    --�ִ밪 ����, NOCYCLE�̱� ������ �߰� �Ұ�
    
--������ Ȯ��
SELECT * FROM DEPT_COPY;

--������ ��� ���
SELECT SEQ_DEPT.CURRVAL FROM DUAL; -- ���� ������ CURRVAL
SELECT SEQ_DEPT.NEXTVAL FROM DUAL; -- ���� ������ Ȯ��

--������ ���� ���
ALTER SEQUENCE SEQ_DEPT
    INCREMENT BY 3 --����
    MAXVALUE 99
    CYCLE; --������ ���������� ó�� �������� ���ư�

--���̺� ���� Ȯ��
SELECT * FROM DEPT_COPY; --10������ 90������ 9���� ������ ����

--3�� ����
INSERT INTO DEPT_COPY (DEPTNO, DNAME, LOC)
    VALUES (SEQ_DEPT.NEXTVAL, 'DA', 'SEOUL');
    
--���̺� ���� Ȯ��
SELECT * FROM DEPT_COPY; --93,96,99 3�� ������ �߰�, �ִ밪 99�� ����

--3�� �� ����
INSERT INTO DEPT_COPY (DEPTNO, DNAME, LOC)
    VALUES (SEQ_DEPT.NEXTVAL, 'DA', 'SEOUL');

--���̺� ���� Ȯ��
SELECT * FROM DEPT_COPY; -- 0,3,6 ������ �߰�, 99 �ִ밪 ���� 0���� ���ư�

--������ ����
DROP SEQUENCE SEQ_DEPT;

--������ ���� Ȯ��
SELECT * FROM USER_SEQUENCES;

--�ó�� = �������� ��Ī = ��ȸ�� ��Ī�� �ƴ� = �ó�� ��ü ���� ������ ���������� ��� ����
--SELECT �� �̸� AS ��Ī => ��ȸ��

--�ó�� ���� ���� �ʿ�
--������ �������� ���� �ο�
--CMD���� ����
sqlplus system/oracle
--���� �ο� = GRANT ���� TO ����
GRANT CREATE SYNONYM TO SCOTT;
GRANT CREATE PUBLIC SYNONYM TO SCOTT;

--SCOTT �������� ����
CREATE SYNONYM E FOR EMP;

--�ó�� ���
SELECT * FROM EMP;
SELECT * FROM E;

--�ó�� ����
DROP SYNONYM E;

--���� Ȯ��
SELECT * FROM E;
SELECT * FROM EMP; --���� �̸� EMP�� ��� ����

--���� ����
--1) NOT NULL = �� ������� ���� = �� �Ұ�
CREATE TABLE TABLE_NOTNULL (
    LOG_ID VARCHAR2(15) NOT NULL ,
    LOG_PW VARCHAR2(15) NOT NULL ,
    CP     VARCHAR2(15) 
    );
    
SELECT * FROM TABLE_NOTNULL;

DESC TABLE_NOTNULL;

--NULL �� �߰�
INSERT INTO TABLE_NOTNULL (LOG_ID, LOG_PW, CP)
    VALUES ('TEST_ID_1',NULL,'010-1234-5678'); -- NOT NULL ���� �������� �߰� �Ұ�

INSERT INTO TABLE_NOTNULL (LOG_ID, CP)
    VALUES ('TEST_ID_1','010-1234-5678'); -- �Ͻ��� �Է� : ���� ���� NULL������ �νĵǾ� �߰� �Ұ�
    
INSERT INTO TABLE_NOTNULL (LOG_ID, LOG_PW, CP)
    VALUES ('TEST_ID_1', 'TEST_PW_1', '010-1234-5678'); 

--��ȭ��ȣ�� NULL�� �߰�
INSERT INTO TABLE_NOTNULL (LOG_ID, LOG_PW)
    VALUES ('TEST_ID_1', 'TEST_PW_1'); --�������� �����Ƿ� �߰� ����
    
SELECT * FROM TABLE_NOTNULL;
DELETE FROM TABLE_NOTNULL WHERE CP='010-1234-5678';

-- NULL ������ ����
UPDATE TABLE_NOTNULL
    SET LOG_PW = NULL --���� �������� ���� ���� �Ұ�
    WHERE LOG_ID = 'TEST_ID_1';

--�������� Ȯ�� ��� : ������ �������� Ȯ���ϱ�
--CONSTRAINT_TYPE : P = PRIMARY KEY, R = REFERENCE, C = CHECK/NOT NULL, U = UNIQUE
SELECT * FROM USER_CONSTRAINTS;

--�������� �̸� ����
CREATE TABLE TABLE_NOTNULL1(
    LOG_ID VARCHAR2(15) CONSTRAINT TBNN1_LOGID_NN NOT NULL,
    LOG_PW VARCHAR2(15) CONSTRAINT TBNN1_LOGPW_NN NOT NULL,
    CP VARCHAR2(15)
);

--���� ���� Ȯ��    
SELECT * FROM USER_CONSTRAINTS;

--���� ���� ���� (�߰�)
ALTER TABLE TABLE_NOTNULL1
    MODIFY (CP NOT NULL);
    
SELECT * FROM USER_CONSTRAINTS;

--�̹� ���̺� NULL���� �ֱ� ������ ���� �ȵ�
ALTER TABLE TABLE_NOTNULL
    MODIFY (CP NOT NULL);

SELECT * FROM TABLE_NOTNULL;

--��ȭ��ȣ NULL ���� �ٸ� ������ ����
UPDATE TABLE_NOTNULL
    SET CP='010-1234-5678'
    WHERE LOG_ID = 'TEST_ID_1';

SELECT * FROM TABLE_NOTNULL;

ALTER TABLE TABLE_NOTNULL
    MODIFY (CP NOT NULL); --�������� ���� / �̸� ���� X

SELECT * FROM USER_CONSTRAINTS;

--NOTNULL1 �������� �̸� �����ؼ� �ٲٱ�
ALTER TABLE TABLE_NOTNULL1 DROP CONSTRAINT SYS_C0011057;

ALTER TABLE TABLE_NOTNULL1
    MODIFY (CP CONSTRAINT TBNN1_CP_NN NOT NULL); --�̸� ����

SELECT * FROM USER_CONSTRAINTS;
DESC TABLE_NOTNULL;
DESC TABLE_NOTNULL1;

--���� ���� �̸� ����
ALTER TABLE TABLE_NOTNULL1
    RENAME CONSTRAINT TBNN1_CP_NN TO TBNN1_CP_NN_AFTER;

SELECT * FROM USER_CONSTRAINTS;

--���� ���� ����
ALTER TABLE TABLE_NOTNULL1
    DROP CONSTRAINT TBNN1_CP_NN_AFTER;

SELECT * FROM USER_CONSTRAINTS;


-- UNIQUE = �ߺ� �Ұ�
-- �������� �̸� �����Ͽ� �����
CREATE TABLE TB_UNQ(
    LOG_ID VARCHAR2(15) CONSTRAINT TBUNQ_LOGID_UNQ UNIQUE,
    LOG_PW VARCHAR2(15) CONSTRAINT TBUNQ_LOGPW_UNQ UNIQUE,
    CP     VARCHAR2(15) 
    );

SELECT * FROM USER_CONSTRAINTS;

--���ϴ� ���� ���Ǹ� ����
--LIKE �����ڿ� ���ϵ�ī�� ���
SELECT * FROM USER_CONSTRAINTS WHERE CONSTRAINT_NAME LIKE '%TBUNQ%'; 

--������ �߰�
INSERT INTO TB_UNQ (LOG_ID, LOG_PW, CP)
    VALUES ('TEST_ID_1','TEST_PW_1','010-1234-5678'); 
    -- �� �� �� �����ϸ� ����
    -- ID�� PW�� UNIQUE ���� ������ �����Ƿ� �ߺ� ������ �߰� �Ұ�

INSERT INTO TB_UNQ (LOG_ID, LOG_PW, CP)
    VALUES ('TEST_ID_2','TEST_PW_2','010-1234-5678');
    -- ��ȭ��ȣ�� ���� ������ ���� ������ �ߺ� �Է��� �����ϴ�
SELECT*FROM TB_UNQ;

--UNIQUE ���� ���ǿ� NULL �� �߰�
INSERT INTO TB_UNQ (LOG_ID, LOG_PW, CP)
    VALUES ('NULL','TEST_PW_3','010-1234-5678'); -- UNIQUE ���� ������ NULL �� ����
SELECT*FROM TB_UNQ;

UPDATE TB_UNQ
    SET LOG_ID=NULL
    WHERE LOG_PW='TEST_PW_3';
    
INSERT INTO TB_UNQ (LOG_PW, CP)
    VALUES ('TEST_PW_4','010-1234-5678'); -- NULL���� �ߺ� ��� �ƴ�

SELECT*FROM TB_UNQ;

--������ ����
UPDATE TB_UNQ
    SET LOG_ID = 'TEST_ID_1' -- �ߺ� �����͹Ƿ� ���� �Ұ�
    WHERE LOG_PW = 'TEST_PW_3';

UPDATE TB_UNQ
    SET LOG_ID = 'TEST_ID_3'
    WHERE LOG_PW = 'TEST_PW_3';

SELECT*FROM TB_UNQ;

--�⺻Ű = PRIMARY KEY = NOT NULL + UNIQUE
CREATE TABLE TB_PK(
    LOG_ID VARCHAR2(15) CONSTRAINT TBPK_LOGID_PK PRIMARY KEY,
    LOG_PW VARCHAR2(15) CONSTRAINT TBPK_LOGPW_NN NOT NULL,
    CP     VARCHAR2(15)
    );

SELECT*FROM TB_PK;

--������ �߰�
INSERT INTO TB_PK (LOG_ID, LOG_PW, CP)
    VALUES ('TEST_ID_1','TEST_PW_1','010-1234-5678');
SELECT*FROM TB_PK;

--�ߺ�&NULL ������ �߰� : LOG_ID PK�� �ߺ�&NULL �Ұ�
INSERT INTO TB_PK (LOG_ID, LOG_PW, CP)
    VALUES ('TEST_ID_1','TEST_PW_1','010-1234-5678');
INSERT INTO TB_PK (LOG_PW, CP)
    VALUES ('TEST_PW_1','010-1234-5678');

INSERT INTO TB_PK (LOG_ID, LOG_PW, CP)
    VALUES ('TEST_ID_2','TEST_PW_1','010-1234-5678');
SELECT * FROM TB_PK;

--�ܷ�Ű FK (FOREIGN KEY) = ����Ű = �ٸ� ���̺��� �⺻Ű�� ����
--EMP, DEPT ���̺��� ������ �ִ� ��������  Ȯ����
SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME IN ('EMP', 'DEPT');

--EMP ���̺� DEPT ���̺� ���� �μ� ��ȣ�� �Է�
SELECT * FROM EMP;
SELECT * FROM DEPT;

INSERT INTO EMP
    VALUES(9999,'QUEEN','VICE',7839, '2023-05-23', 5000, NULL, 90); 
    --���� ���� : �θ� Ű�� �����ϴ�.
    -- => ������ �� �ִ� ���� ���� DEPT TABLE�� DEPTNO�� FK�� �ۿ�
    --�μ� ���̺� 90�� �μ� �����͸� ���� �Է� �� �߰��ؾ� ��
    
--���̺� ����
CREATE TABLE DEPT_FK(
    DEPTNO NUMBER(2) CONSTRAINT DEPTFK_DEPTNO_FK PRIMARY KEY,
    DNAME VARCHAR2(15)
    );

CREATE TABLE EMP_FK(
    EMPNO  NUMBER(4) CONSTRAINT EMPFK_EMPNO_PK PRIMARY KEY,
    ENAME  VARCHAR2(10),
    DEPTNO NUMBER(2) CONSTRAINT EMPFK_DEPTNO_FK REFERENCES DEPT_FK(DEPTNO)
    );

--��� �߰�
INSERT INTO EMP_FK
    VALUES (9999, 'QUEEN', 10); -- ���� : �θ� Ű�� �����ϴ�.

SELECT*FROM DEPT_FK; -- ������ ���� EMP_FK���� ������ �� �ִ� ���� ����

--DEPT_FK ������ ����
INSERT INTO DEPT_FK
    VALUES (10,'DA');

INSERT INTO EMP_FK
    VALUES (9999, 'QUEEN', 10); 
    
SELECT*FROM DEPT_FK;
SELECT*FROM EMP_FK;

--�ܷ�Ű�� ���� �� ������ �Է� ����
--1) �ܷ�Ű ����
--2) ������ ������ �Է� ( EX. DEPTNO 10 )
--3) ������ �Է� ���� ( EX. QUEEN 10 )
-- ������ ������ ���� �ݴ�� ������(�ڽķ��ڵ�) ���� �� ������ ������(�θ��ڵ�) ����

--�����ϱ�
--�μ� ����
DELETE FROM DEPT_FK WHERE DEPTNO=10; --���� ���� : �ڽ� ���ڵ尡 �߰ߵǾ����ϴ�. 
                                     --10�� �����ϰ� �ִ� �����Ͱ� ������ : QUEEN

--�����ϰ� �ִ� �����ͺ��� ���� : ��� ������ ���� ����
DELETE EMP_FK WHERE EMPNO=9999;
DELETE FROM DEPT_FK WHERE DEPTNO=10;

SELECT * FROM EMP_FK;
SELECT * FROM DEPT_FK;

