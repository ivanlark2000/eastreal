import requests

url = 'https://routing.openstreetmap.de/routed-car/route/v1/driving/20.5031,54.71529;20.50416,54.7147?overview=false&geometries=polyline&steps=true'

response = requests.get(url)

print(response.json())
