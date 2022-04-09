# coding=utf-8
from selenium import webdriver
from urllib.parse import urlparse
from fake_useragent import UserAgent
import time

useragent = UserAgent()
# option
# options = webdriver.FirefoxOptions()  # создание объекта с опциями
# options.set_preference('general.useragent.override', useragent.random)  # Вызываем метод изменения опций user agent

url = 'https://www.avito.ru/kaliningrad/kvartiry/prodam-ASgBAgICAUSSA8YQ?cd=1'
parsed = urlparse(url)
print(parsed)

# driver = webdriver.Firefox()

# try:
#     driver.get(url)
#     time.sleep(5)
#     html = driver.page_source  # получаем html страницы
#     with open('html.txt', 'w') as file:
#         file.write(html)
#
#
# except Exception as ex:
#     print(ex)
# finally:
#     driver.close()
#     driver.quit()