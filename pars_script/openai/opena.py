import os
import re
import sys
import time
import openai


openai.api_key = os.environ.get("OPENAI_API_KEY")


def lst_des(conn: object) -> list:
    cursor = conn.cursor()
    cursor.execute("""
                   SELECT f_flat, c_name
                   FROM inf_descriptions
                   ORDER BY d_date_create
                   LIMIT 100;
                   """)
    return cursor.fetchall()


def get_api_resp(text) -> str:
    try:
        res = openai.Completion.create(
            engine="text-davinci-003",
            prompt=f"{text}",
            max_tokens=2048
            )["choices"][0]["text"]
        print(res)
        return res
    except Exception as e:
        print(f'Проблемы c получение данных с апишки {e}')
        time.sleep(20)


def project() -> None:
    sys.path.insert(1, '/home/lark/PROJECT/RealEstate/settings')
    from config import config
    conn = config.make_con()
    for row in lst_des(conn):
        text = re.findall(r'.{1,2048}(?:\s|$|.|!|)', row[1])
        for t in text:
            get_api_resp(t)
            time.sleep(5)


def foto():
    response = openai.Image.create(
        prompt="Дота 2 Костя",
        n=1,
        size="1024x1024"
        )
    image_url = response['data'][0]['url']
    print(response)


def main():
    get_api_resp('''Дан список пересекающихся периодов, написать запрос, который выведет объединенные
пересекающиеся периоды. решить на постгресс
                 CREATE TEMP TABLE temp_periods
(
d0 date,
d1 date
);
INSERT INTO temp_periods
(
d0,
d1
)
values (&#39;20220101&#39;, &#39;20220301&#39;),
(&#39;20220201&#39;, &#39;20220401&#39;),
(&#39;20220110&#39;, &#39;20220310&#39;),
(&#39;20220501&#39;, &#39;20220511&#39;),
(&#39;20220511&#39;, &#39;20220601&#39;),
(&#39;20221101&#39;, &#39;20221201&#39;),
(&#39;20221111&#39;, &#39;20221115&#39;);''')
    #foto()

if __name__ == "__main__":
    main()
