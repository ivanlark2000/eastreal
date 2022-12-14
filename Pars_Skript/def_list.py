# coding=utf-8
import time
import random
import http.client
from config import logger
from bs4 import BeautifulSoup
from urllib.request import urlopen


def getting_url(city: str) -> list:
    lst = list(range(0, 101))
    random.shuffle(lst)
    for n in lst:
        for link in [
            f'https://www.avito.ru/{city}/kvartiry/prodam/vtorichka-ASgBAQICAUSSA8YQAUDmBxSMUg?cd=1&p={n}',
            f'https://www.avito.ru/{city}/kvartiry/prodam/novostroyka-ASgBAQICAUSSA8YQAUDmBxSOUg?cd=1&p={n}'
        ]:
            yield link


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
        print('Ошибка при создании рандомныx cсылок' + str(e))


def getting_html(url):
    """Получим html для дома и квартиры"""
    try:
        respose = urlopen(url).read().decode("utf-8")
        time.sleep(5)
        return respose
    except http.client.IncompleteRead as e:
        return e.partial.decode("utf-8")
