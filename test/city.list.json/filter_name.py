import json
# import pandas as pd

with open("./vietnam.json", "r", encoding="utf-8") as file:
    data = json.load(file)

list_city = dict()
for item in data:
    list_city[item["name"]] = item["id"]    

# # in list_city ra file txt
# with open("./vietnam_city_list.txt", "w", encoding="utf-8") as file:
#     for city in list_city:
#         city = city.split()
#         city = "+".join(city)
#         file.write(city + "\n")

with open("./city_id.json", "w", encoding="utf-8") as outfile:
    json.dump(list_city, outfile, ensure_ascii=False, indent=4)