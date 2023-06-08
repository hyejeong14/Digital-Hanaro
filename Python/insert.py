import cx_Oracle as oci

con = oci.connect("scott/tiger@localhost:1521/orcl") #DB연결
cur = con.cursor() #커서 생성

while True:
    val_id= input("ID 를 입력하세요(2자리 정수)> ")
    val_name= input("이름을 입력하세요 > ")
    if (val_id == "")&(val_name == ""):
        break   #NAN 값 확인 시 while문 break
    sql = "INSERT INTO TEST (ID,NAME) VALUES('"+val_id+"','"+val_name+"')" #데이터삽입
    cur.execute(sql) #SQL문 실행

#print(cur.execute("SELECT * FROM TEST").fetchall()) #테이블 확인 

#commit
con.commit()

#db 종료
con.close()