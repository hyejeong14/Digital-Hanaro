# 주석 = ctrl + /
# extensions 에서
# 1) korean
# 2) python
# 3) python extension
# 설치

print("hello world")

# 실행하는 방법
# 1) 우측 상단 화살표 버튼 누르고 파이썬 파일 실행 클릭
# 2) 명령 프롬프트에서 이 파일이 저장된 위치로 가서 python print.py 실행
# 3) 한 줄 실행 = shift + enter

# 오라클 디비 접속
# 라이브러리 설치
# 새로운 터미널 열기 = shift + ctrl + ` (backtick 기호)
# python -m pip install cx_Oracle --upgrade
# 라이브러리 불러오기
import cx_Oracle as oci
# 디비 연결
# "ID/PW@localhost:1521/orcl"
con = oci.connect("scott/tiger@localhost:1521/orcl")
# 커서 생성
cur = con.cursor()
# 

# fetchone
# sql 실행
sql = "SELECT * FROM EMP"
cur.execute(sql)
# 
while True:
    row = cur.fetchone()
    if row is None:
        break
    print(row)
# 

# sql 실행
sql = "SELECT * FROM EMP"
cur.execute(sql)
# 
row = cur.fetchone()
while row is not None:
    print(": ".join([str(col) for col in row]))
    row = cur.fetchone()
# 

# sql 실행
sql = "SELECT EMPNO, ENAME FROM EMP"
cur.execute(sql)
# 
row = cur.fetchone()
while row is not None:
    empno, ename = row
    print(empno, ename)
    row = cur.fetchone()
# 

# sql 실행
sql = "SELECT EMPNO, ENAME FROM EMP"
cur.execute(sql)
# 
while True:
    row = cur.fetchone()
    if row is None:
        break
    data1 = row[0]
    data2 = row[1]
    print("%5s %10s" % (data1, data2))
# 

# fetchall
# sql 실행
sql = "SELECT * FROM EMP"
cur.execute(sql)
# 
rows = cur.fetchall()
if rows:
    for row in rows:
        print(row)
# 

# sql 실행
sql = "SELECT * FROM EMP"
cur.execute(sql)
# 
rows = cur.fetchall()
if rows:
    for row in rows:
        print(": ".join([str(col) for col in row]))
# 

# sql 실행
sql = "SELECT EMPNO, ENAME FROM EMP"
cur.execute(sql)
# 
rows = cur.fetchall()
if rows:
    for row in rows:
        empno, ename = row
        print(empno, ename)
# 

# sql 실행
sql = "SELECT EMPNO, ENAME FROM EMP"
cur.execute(sql)
# 
rows = cur.fetchall()
if rows:
    for row in rows:
        data1 = row[0]
        data2 = row[1]
        print("%5s %10s" % (data1, data2))
# 

# sql 실행
sql = "SELECT * FROM EMP A, SALGRADE B WHERE A.SAL BETWEEN B.LOSAL AND B.HISAL"
cur.execute(sql)
# 
rows = cur.fetchall()
if rows:
    for row in rows:
        print(row)
# 

# fetchmany
# sql 실행
sql = "SELECT * FROM EMP"
cur.execute(sql)
# 
rows = cur.fetchmany(5)
if rows:
    for row in rows:
        print(row)
# 

# pandas 로 sql 다루기
import pandas as pd
sql = "SELECT * FROM EMP"
df = pd.read_sql_query(sql, con)
print(df)
# 

# create table
# sql 실행 - DDL = 자동 커밋
sql = "CREATE TABLE EXAM_ID (ID INT)"
cur.execute(sql)
# 
print(cur.execute("SELECT * FROM EXAM_ID").fetchall())
# 

# insert
while True:
    data1 = input("ID 를 입력하세요(정수)> ")
    if data1 == "":
        break
    sql = "INSERT INTO EXAM_ID VALUES('" + data1 + "')"
    cur.execute(sql)
# 

# drop
sql = "DROP TABLE EXAM_ID"
cur.execute(sql)
# 
print(cur.execute("SELECT * FROM EXAM_ID").fetchall())
# 

# COMMIT
con.commit()

# ROLLBACK
con.rollback()

# 디비 연결 종료
con.close()