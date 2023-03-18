# coding=utf-8
import time
import random
import urllib
import selenium
import http.client
from dadata import Dadata
from bs4 import BeautifulSoup
from selenium import webdriver
from load_to_base import config, logger
from urllib.request import urlopen
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.chrome.options import Options
from load_to_base import get_all_street_without_coord, add_coord_to_base, add_full_address


chrom_option = Options()
chrom_option.add_argument("--headless")
driver = webdriver.Chrome(options=chrom_option)


def save_html(html: str, file_name: str) -> None:
    with open(file_name, 'w') as file:
        file.write(html)


def load_html(file_name) -> str:
    return open(file_name, 'r').read()


def getting_url(city: str) -> list:
    lst = list(range(0, 101))
    random.shuffle(lst)
    for n in lst:
        for link in [
            f'https://www.avito.ru/{city}/kvartiry/prodam/vtorichka-ASgBAQICAUSSA8YQAUDmBxSMUg?cd=1&p={n}',
            f'https://www.avito.ru/{city}/kvartiry/prodam/novostroyka-ASgBAQICAUSSA8YQAUDmBxSOUg?cd=1&p={n}'
        ]:
            yield link


def getting_links(html:str) -> list[str]:
    """Получаем список ссылок на квартиры"""
    soup = BeautifulSoup(html, 'html.parser')
    prices = soup.find_all('span', {'data-marker': 'item-price'})
    lst_price = [ i.find('meta', {'itemprop':'price'}).get('content') for i in prices]
    tags = soup.find_all('a', class_="iva-item-sliderLink-uLz1v")
    list_links = ['https://' + 'www.avito.ru' + tag.get('href') for tag in tags]
    ids = soup.find_all('div', {'data-marker': 'item'})
    ids_lst = [id.get('data-item-id') for id in ids]
    return [(ids_lst[i], lst_price[i], list_links[i])  for i in range(len(ids_lst))]


def getting_rendom_link(list_links: list):
    """Получаем рандомную ссылку и фильтруем список"""
    link = random.choice(list_links)
    list_links.remove(link) 
    yield list_links


def getting_html(url:str):
    """Получим html для дома и квартиры"""
    try:
        respose = urlopen(url).read().decode("utf-8")
        return respose
    except http.client.IncompleteRead as e:
        return e.partial.decode("utf-8")
    except urllib.error.HTTPError:
        logger.warning(f'Ошибка при загрузке дынных со страницы {url}')
    finally:
        time.sleep(5)

    
def getting_html_sel(url: str) -> str:
    """Возвращает html посредством виртуально браузера """
    from main import logger
    count = 0
    while count < 5: 
        try:
            driver.get(url)
            time.sleep(5)
            return driver.page_source   
        except Exception as e:
            logger.warning(f'Oшибка при загрузке страницы {url} селениумом')
            time.sleep(20)
            count += 1
            continue


def get_right_street(street: str):
    try:
        with Dadata(config.API_KEY_DADATA, config.SECRET_KEY_DADATA) as dadata:
            address = dadata.suggest(name='address', query=street)
            if not address:
                return
            dadata.close()
        return address[0]['value']
    except Exception as e:
        config.logger.warning(f'Не удалось получить данные в Дадата адрес {street} '
                       f'ошибка {e}')


def get_position_ya(adress: str) -> tuple[float, float]:
    url = 'https://yandex.ru/maps'
    try:
        driver.get(url)
        while True:
            try:
                el = driver.find_element(By.TAG_NAME, 'input')
                el.send_keys(adress, Keys.ENTER)
                time.sleep(3)
                break
            except Exception as e:
                logger.info('Обновления id элемента яндекс')
        lst = driver.find_element(By.CLASS_NAME, 'toponym-card-title-view__coords-badge').text.split(', ')
        return float(lst[0]), float(lst[1])
    except selenium.common.exceptions.NoSuchElementException:
        logger.info(f'Адресс не коректен - {adress}')
    except Exception as e:
        logger.warning(f'Не удалось получить координаты с яндекс улица {adress} {e}', exc_info=True)


def add_coord():
    from main import logger
    data = get_all_street_without_coord()
    count = len(data)
    logger.info(f'к обновлению {count} домов')
    for row in data:
        try:
            if not row[5]:
                street = get_right_street(row[2] + " " + row[3].strip())
                if not street:
                    street = row[2] + " " + row[3].strip()
                else:
                    add_full_address(streetid=row[1], full_address=street)
                street = street + ' ' + row[4].strip()
                position = get_position_ya(street)
                if position:
                    lat, lon = position
                    add_coord_to_base(row[0], lat, lon)
            else:
                street = row[5] + ' ' + row[4].strip()
                position = get_position_ya(street)
                if position:
                    lat, lon = position
                    add_coord_to_base(row[0], lat, lon)
        except Exception as e:
            logger.info('inf', exc_info=True)
        finally:
            count -= 1
