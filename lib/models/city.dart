class City{
  bool isSelected;
  final String name;
  final int id;
  bool isDefault;

  City(this.isSelected, this.name, this.id, this.isDefault);

  static List<City> citiesList = [
    City(false, 'Ha Noi', 1581130, true),
    City(false, 'Ho Chi Minh City', 1580578, false),
    City(false, 'Nghe An', 1559969, false),
    City(false, 'Ninh Binh', 1559970, false),
    City(false, 'Ninh Thuan', 1559971, false),
    City(false, 'Tuyen Quang', 1559976, false),
    City(false, 'Yen Bai', 1559978, false),
    City(false, 'Lao Cai', 1562412, false),
    City(false, 'Vung Tau', 1562414, false),
    City(false, 'Vinh', 1562798, false),
    City(false, 'Viet Tri', 1562820, false),
    City(false, 'Thua Thien Hue', 1565033, false),
    City(false, 'Thai Binh', 1566346, false),
    City(false, 'Soc Trang', 1567788, false),
    City(false, 'Quang Tri', 1568738, false),
    City(false, 'Pleiku', 1569684, false),
    City(false, 'Nha Trang', 1572151, false),
    City(false, 'Hoa Binh', 1567788, false),
  ];


}