# coding=utf-8
import time
import random
import http.client
import urllib.error
from config import config
from bs4 import BeautifulSoup
from urllib.request import urlopen


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