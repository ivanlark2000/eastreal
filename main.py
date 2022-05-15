# coding=utf-8
import time
import os
from class_list import Flats, Buildings
from def_list import getting_total_html, getting_links, getting_rendom_link
from def_list import getting_url, checking_status, getting_html_flat


def main(page=1):
    # создаем временный файл
    file = open("sys/temp.txt", "w")
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
            try:
                build = Buildings(html_flat)  # Cоздаем объект с данными по дому
                fl = Flats(html_flat)  # Создаем объект с данными по квартире
            except Exception as error:
                print('Не удалось создать объекты', error)
                with open('sys/flat.html', 'w') as file:
                    file.write(html_flat)
                continue

            if build.checking() is None:  # Проверяем есть ли дом в базе
                build.save()

            if fl.checking() is None:  # Проверяем существует ли квартира в базе
                page = fl.save(page)

            else:  # Если есть квартира в базе меняем статус обновляем цену
                fl.adding_price()

            with open("sys/temp.txt", "a") as file:
                file.write(str(fl.flat_id) + "\n")

    checking_status()
    os.remove("sys/temp.txt")
    print("Operation completed!")


if __name__ == "__main__":
    main()
