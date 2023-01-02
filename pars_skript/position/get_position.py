import time
from dadata import Dadata
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
from selenium.webdriver import ActionChains

api_key = '43b0036c75f55f532a18d6291423bd960c45304b'
secret = '14a01cfb738a67787f176342817c8c6aabbeda77'

driver = webdriver.Chrome()

url = 'https://yandex.ru/maps'

with Dadata(api_key, secret) as dadata:
    address = dadata.suggest(name='address', query='Калининград 3-я Б. Окружная 243')[0]['value']

driver.get(url)

while True:
    try:
        action = ActionChains(driver)
        el = driver.find_element(By.TAG_NAME, 'input')
        el.send_keys(address, Keys.ENTER)
        time.sleep(3)
        break
    except Exception as e:
        time.sleep(3)

coord = driver.find_element(By.CLASS_NAME, 'toponym-card-title-view__coords-badge').text.split(', ')

lat = float(coord[0])
lon = float(coord[1])

print(lat)
print(lon)
