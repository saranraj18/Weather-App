class CityModel {
  String? cityName;
  String? country;
  int? temperature;
  String? weather;
  int? humidity;
  int? pressure;
  double? wind;

  CityModel({
    required this.cityName,
    required this.country,
    this.temperature,
    this.weather,
    this.humidity,
    this.pressure,
    this.wind,
  });

  CityModel.fromJson(Map<String, dynamic> json) {
    cityName = json['cityName'];
    country = json['country'];
    temperature = json['temperature'];
    weather = json['weather'];
    humidity = json['humidity'];
    pressure = json['pressure'];
    wind = json['wind'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cityName'] = cityName;
    data['country'] = country;
    data['temperature'] = temperature;
    data['weather'] = weather;
    data['humidity'] = humidity;
    data['pressure'] = pressure;
    data['wind'] = wind;
    return data;
  }
}
