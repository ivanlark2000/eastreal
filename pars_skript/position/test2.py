import requests


url = 'https://routing.openstreetmap.de/routed-car/route/v1/driving/20.5012317,54.6666872;20.5116650000000000,54.7423179000000000?overview=false&geometries=polyline&steps=true'

resp = requests.get(url)

