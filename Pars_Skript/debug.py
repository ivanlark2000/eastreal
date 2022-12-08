from load_to_base import load_to_base
from avito_pars import parsAvitoFlat
from def_list import getting_html

url = 'https://www.avito.ru/kaliningrad/kvartiry/2-k._kvartira_324m_22et._2551977485'


#with open('test.html', 'w') as file:
#    file.write(getting_html(url))

file = open('test.html').read()

test = parsAvitoFlat(file, url)
print(test)

load_to_base(test)
