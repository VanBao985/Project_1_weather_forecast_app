class Weather{
  int id;  //id kieu thoi tiet
  String main;  //thoi tiet chinh: clouds, rain, sun,..
  String description;  //mo ta: clearly, overcast,...
  String icon;  // icon kieu thoi tiet
  double temp;  // thoi tiet do C
  double feels_like;  // cam thay nhu bao nhieu do
  double wind; //toc do gio donvi: km/h
  int humidity; // do am (%)
  String sunrise;  // thoi gian mat troi moc
  String sunset;


  Weather({
    this.id = 0,
    this.main = "",
    this.description = "",
    this.icon = "",
    this.temp = 0.0,
    this.feels_like = 0.0,
    this.wind = 0.0,
    this.humidity = 0,
    this.sunrise = "",
    this.sunset = ""
  });

}