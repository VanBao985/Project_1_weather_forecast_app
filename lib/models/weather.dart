class Weather {
  // Các thuộc tính
  int _id; // ID kiểu thời tiết
  String _main; // Thời tiết chính: clouds, rain, sun,...
  String _description; // Mô tả: clear sky, overcast,...
  String _icon; // Icon kiểu thời tiết
  double _temp; // Nhiệt độ (°C)
  double _feels_like; // Cảm thấy như bao nhiêu độ
  double _wind; // Tốc độ gió (đơn vị: km/h)
  int _humidity; // Độ ẩm (%)
  String _sunrise; // Thời gian mặt trời mọc
  String _sunset; // Thời gian mặt trời lặn

  // Constructor
  Weather({
    int id = 0,
    String main = "",
    String description = "",
    String icon = "",
    double temp = 0.0,
    double feels_like = 0.0,
    double wind = 0.0,
    int humidity = 0,
    String sunrise = "",
    String sunset = "",
  })  : _id = id,
        _main = main,
        _description = description,
        _icon = icon,
        _temp = temp,
        _feels_like = feels_like,
        _wind = wind,
        _humidity = humidity,
        _sunrise = sunrise,
        _sunset = sunset;

  int get id => _id;
  String get main => _main;
  String get description => _description;
  String get icon => _icon;
  double get temp => _temp;
  double get feels_like => _feels_like;
  double get wind => _wind;
  int get humidity => _humidity;
  String get sunrise => _sunrise;
  String get sunset => _sunset;

}
