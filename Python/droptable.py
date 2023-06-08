import cx_Oracle as oci

con = oci.connect("scott/tiger@localhost:1521/orcl") #DB연결
cur = con.cursor() #커서 생성

# drop
sql = "DROP TABLE TEST"
cur.execute(sql)

#drop 확인 
#print(cur.execute("SELECT * FROM TEST").fetchall())

# 디비 연결 종료
con.close()