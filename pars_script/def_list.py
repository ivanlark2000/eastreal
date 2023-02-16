# coding=utf-8
import time
import random
import http.client
from bs4 import BeautifulSoup
from urllib.request import urlopen


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
    list_links.remove(link)  # Удаляем из списка выбранную ссылку.
    time.sleep(3)
    yield list_links


def getting_html(url:str):
    """Получим html для дома и квартиры"""
    try:
        respose = urlopen(url).read().decode("utf-8")
        return respose
    except http.client.IncompleteRead as e:
        return e.partial.decode("utf-8")
    finally:
        time.sleep(5)

