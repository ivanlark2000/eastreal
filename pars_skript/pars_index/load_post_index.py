import dbfread
from pars_skript.settings.config import config

conn = config.make_con()
cursor = conn.cursor()

table = dbfread.read('PIndx01.dbf')

cursor.execute('SELECT * FROM fs_city')
response = cursor.fetchall()

lst = [(i[0], i[2]) for i in response]
for i in table:
    for row in lst:
        if row[1].lower() == i['CITY'].lower():
            sql = f"""INSERT INTO fs_post_index (f_city, n_index)
                    VALUES ({row[0]}, {i['INDEX']})"""
            cursor.execute(sql)
            conn.commit()



