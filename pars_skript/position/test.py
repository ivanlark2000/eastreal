from dadata import Dadata

api_key = '43b0036c75f55f532a18d6291423bd960c45304b'
secret = '14a01cfb738a67787f176342817c8c6aabbeda77'

addres = 'г. Калининград ул Изумрудная 14'

dadata = Dadata(api_key, secret)

address = dadata.suggest(name='address', query=addres)

print(address)