# coding=utf-8
import time
import os
from def_list import (
    getting_total_html,
    getting_links,
    getting_rendom_link,
    getting_html_flat,
    getting_url,
    checking_status,
    clearing_none,
)
from class_list import Flats, Buildings


def main(page=1):
    # создаем временный файл
    file = open("temp.txt", "w")
    file.close()
    # clearing_none()
    # генерируем рандомную стартовую ссылку
    for url in getting_url():
        print(url)
        html = getting_total_html(url)  # Получаем html стартовой страницы
        list_links = getting_links(html)  # получаем список ссылок квартир
        while list_links is None:
            time.sleep(1)
            list_links = getting_links(html)
        links = getting_rendom_link(list_links)  # извлекаем рандомную ссылку
        for link in next(links):
            html_flat = getting_html_flat(link)
            if html_flat is None:
                continue

            time.sleep(2)
            build = Buildings(html_flat)  # Cоздаем объект с данными по дому
            if build.checking() is None:  # Проверяем есть ли дом в базе
                build.save()

            fl = Flats(html_flat)  # Создаем объект с данными по квартире
            if fl.checking() is None:  # Проверяем существует ли квартира в базе
                page = fl.save(page)

            else:  # Если есть квартира в базе меняем статус обновляем цену
                fl.adding_price()

            with open("temp.txt", "a") as file:
                file.write(str(fl.flat_id) + "\n")

    checking_status()
    os.remove("temp.txt")
    print("Operation completed!")


if __name__ == "__main__":
    main()
