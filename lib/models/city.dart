class City{
  bool isSelected;
  final String city;
  final int id;
  bool isDefault;

  City(this.isSelected, this.city, this.id, this.isDefault);

  static List<City> citiesList = [
    City(false, 'Hà Nội', 1581130, true),
    City(false, 'Thành phố Hồ Chí Minh', 1580578, false),
    City(false, 'Hà Nội', 1581130, false),
    City(false, 'Hà Nội', 1581130, false),
    City(false, 'Hà Nội', 1581130, false),
    City(false, 'Hà Nội', 1581130, false),
    City(false, 'Hà Nội', 1581130, false),

  ];
}