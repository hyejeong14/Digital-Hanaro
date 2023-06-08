#테이블 이름 test
#Column => ID(NUMBER(2)), NAME(VARCHAR2(10))
#Value 2개 INSERT

import cx_Oracle as oci

con = oci.connect("scott/tiger@localhost:1521/orcl") #DB연결
cur = con.cursor() #커서 생성

#create table
sql = "CREATE TABLE TEST (ID NUMBER(2), NAME VARCHAR2(10))" #테이블 생성
cur.execute(sql)
# 
print(cur.execute("SELECT * FROM TEST").fetchall()) #테이블 생성 확인 

