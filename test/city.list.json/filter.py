import json

with open("./city.list.json", "r", encoding="utf-8") as file:
    data = json.load(file)

filtered_data = [item for item in data if item.get("country") == "VN"]

print(f"Found {len(filtered_data)} entries with country='VN'")
for city in filtered_data:
    print(city)

with open("./vietnam_city_list.json", "w", encoding="utf-8") as outfile:
    json.dump(filtered_data, outfile, ensure_ascii=False, indent=4)