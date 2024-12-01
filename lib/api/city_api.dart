import '../models/city.dart';

class CityAPI{

// getSelectedCities(): lay ra danh sach cities da chon trong cua so Select City
static List<City> getSelectedCities(){
List<City> selectedCities = City.citiesList;
return selectedCities
    .where((city) => city.isSelected == true)
    .toList();
}
}