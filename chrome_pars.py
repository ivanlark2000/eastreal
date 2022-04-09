# coding=utf-8
import random
import time
from bs4 import BeautifulSoup
from selenium import webdriver
from main import parsed

driver = webdriver.Firefox()

with open('html.txt', 'r') as file:
    html = file.read()


def getting_links(html):
    """Получаем список ссылок на квартиры"""
    list_of_links = []
    soup = BeautifulSoup(html, 'html.parser')
    links = soup.find_all('a', class_="iva-item-sliderLink-uLz1v")
    for link in links:
        list_of_links.append('https://' + parsed.netloc + link.get('href'))
    print(list_of_links)
    return list_of_links


list_of_links = getting_links(html)


def getting_rendom_link(list_links):
    """Получаем рандомную ссылку и фильтруем список"""
    link = random.choice(list_links)
    list_links.remove(link)  # Удаляем из списка выбраную ссылку.
    print(len(list_links))
    time.sleep(5)
    driver.get(link)
    html_flat = driver.page_source
    return link, list_links


def getting_html(link_html):
    """Получаем HTML"""
    driver.get(link_html)
    html_flat = driver.page_source
    with open('html_flat', 'w') as file_flat:
        file_flat.write(html_flat)
        driver.quit()


if '__naime__' == '__main__':
    while True:
        if len(list_of_links) == 51:
            break
        link = getting_rendom_link(list_of_links)[0]
        getting_html(link)