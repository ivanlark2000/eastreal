import os
import re
import sys
import time
import openai
from PIL import Image


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
    question = """
                Дай характеристику из текста по пунктам, если описание в тексте пункта нет, оставь пункт пустым
                Тип квартиры
                Тип отопления
                Место расположения
                Тип дома
                Тип ремонта
                Наличие кухни
                Шумоизоляция
                Наличие прописанных людей
                Наличие холодильника"""
    try:
        res = openai.Completion.create(
            engine="text-davinci-002",
            prompt=f"{question} {text}",
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
        prompt="ядерный взрыв",
        n=1,
        size="1024x1024"
        )
    image_url = response['data'][0]['url']
    print(response)


def main():
    foto()

if __name__ == "__main__":
    main()
