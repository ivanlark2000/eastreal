# coding=utf-8
import time
import random
import psycopg2
from bs4 import BeautifulSoup
from psycopg2 import Error
from selenium import webdriver
from urllib import request
from app.class_list import user_DB, password_DB, host, port, db
from fake_useragent import UserAgent
from selenium.webdriver.chrome.service import Service
from webdriver_manager.chrome import ChromeDriverManager


def getting_url():
    """Генератор стартовых ссылок"""
    list120 = list(range(1, 21))
    list2140 = list(range(21, 41))
    list4160 = list(range(41, 61))
    list6180 = list(range(61, 81))
    list8199 = list(range(81, 100))
    list_gen = [list120, list2140, list4160, list6180, list8199]
    for list_ in list_gen:
        random.shuffle(list_)
        for number in list_:
            start_site = f'https://www.avito.ru/kaliningrad/kvartiry/prodam-ASgBAgICAUSSA8YQ?cd=1&p={number}'
            yield start_site


def getting_total_html(url):
    """Получим стартовый HTML"""
    while True:
        try:
            options = webdriver.ChromeOptions()
            ua = UserAgent()
            userAgent = ua.random
            options.add_argument("--disable-extensions")
            options.add_argument("--disable-gpu")
            options.add_argument("--headless")
            options.add_argument("--disable-blink-features")
            options.add_argument("--disable-blink-features=AutomationControlled")
            options.add_experimental_option("excludeSwitches", ["enable-automation"])
            options.add_experimental_option('useAutomationExtension', False)
            options.add_argument(f'user-agent={userAgent}')
            options.add_argument("start-maximized")
            driver = webdriver.Chrome(service=Service(ChromeDriverManager().install()), options=options)
            driver.get(url)
            driver.refresh()
            driver.set_page_load_timeout(30)  # Устанавливаем тайм-аут в 30 сек
            driver.execute_script("window.scrollTo(0, 2080)")  # прокрутка
            time.sleep(2)
            driver.execute_script("window.scrollTo(0, 2080)")  # прокрутка прокручиваем вниз страницы
            time.sleep(3)
            html = driver.page_source  # получаем html страницы
            if html is None:  # or sys.getsizeof(html) < 25000:
                time.sleep(20)
                driver.quit()
                continue
            driver.quit()
            return html
        except (Exception, Error) as error:
            print('Ошибка при работе с Селениумом', error)
            time.sleep(20)
            driver.quit()


def getting_links(html):
    """Получаем список ссылок на квартиры"""
    list_of_links = []
    soup = BeautifulSoup(html, 'html.parser')
    links = soup.find_all('a', class_="iva-item-sliderLink-uLz1v")
    for link in links:
        list_of_links.append('https://' + 'www.avito.ru' + link.get('href'))
    return list_of_links


def getting_rendom_link(list_links):
    """Получаем рандомную ссылку и фильтруем список"""
    try:
        link = random.choice(list_links)
        list_links.remove(link)  # Удаляем из списка выбранную ссылку.
        time.sleep(3)
        yield list_links
    except Exception as e:
        print('Ошибка при создании рандомные cсылок' + str(e))


def getting_html_flat(url):
    """Получим html для дома и квартиры"""
    while True:
        try:
            response = request.urlopen(url, timeout=30.0)
            html_flat = response.read().decode("utf-8")
            time.sleep(3)
            return html_flat
        except (Exception, Error) as error:
            print('Ошибка при получении HTML страницы c квартирой', error)
            time.sleep(20)


def clearing_none():
    """Очищаем None"""
    try:
        connection = psycopg2.connect(user=user_DB, password=password_DB, host=host, port=port, database=db)
        cursor = connection.cursor()
        cursor.execute(f"DELETE FROM flats WHERE address = 'None';")
        connection.commit()
        print('Non - ы успешно удалены')
    except (Exception, Error) as error:
        print("Ошибка при работе с PostgresSQL", error)


def checking_status():
    """Функция по сверке айдишников в базе и установке статуса 'продана'"""
    list_old_id, list_new_id = [], []
    try:
        connection = psycopg2.connect(user=user_DB, password=password_DB, host=host, port=port, database=db)
        cursor = connection.cursor()
        cursor.execute(f"SELECT flat_id FROM flats WHERE status = 'active';")
        result = cursor.fetchall()
        for res in result:
            for id in res:
                list_old_id.append(int(id))
        del result
        cursor.close()
        file = open('../sys/temp.txt', 'r')
        number = file.readline()
        while number != '':  # Считываем файл
            list_new_id.append(int(number.rstrip('\n')))
            number = file.readline()
        file.close()
        for new_id in list_new_id:  # сравниваем два списка
            if new_id in list_old_id:
                list_old_id.remove(new_id)
        count = 1
        for old_id in list_old_id:  # отправляем статут sail для старых айдишников
            try:
                connection = psycopg2.connect(user=user_DB, password=password_DB, host=host, port=port, database=db)
                cursor = connection.cursor()
                cursor.execute(f"UPDATE flats SET status = 'sales' WHERE flat_id = '{old_id}'")
                connection.commit()
                print(f'{count}. Квартира № {old_id} продана.')
                count += 1
            except (Exception, Error) as error:
                print("Ошибка при работе с PostgresSQL", error)
            finally:
                cursor.close()
    except (Exception, Error) as error:
        print("Ошибка при работе с PostgresSQL", error)

