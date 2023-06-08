import cx_Oracle as oci

con = oci.connect("scott/tiger@localhost:1521/orcl") #DB연결
cur = con.cursor() #커서 생성

# sql 실행
sql = "SELECT ID,NAME FROM TEST"
cur.execute(sql)

# 
rows = cur.execute(sql).fetchall()

if rows:
    print(" ID        NAME")
    print("-"*15)
    for row in rows:
        id = row[0]
        name = row[1]
        print("%3s %10s" % (id, name))

#db 연결 종료
con.close()