import json

with open("./vietnam_city_list.json", "r", encoding="utf-8") as file:
    data = json.load(file)

list_city = []
for item in data:
    list_city.append(item.get("name"))

# in list_city ra file txt
with open("./vietnam_city_list.txt", "w", encoding="utf-8") as file:
    for city in list_city:
        city = city.split()
        city = "+".join(city)
        file.write(city + "\n")