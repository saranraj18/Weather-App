import 'dart:convert';

import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:weather/data/cities_list.dart';

class WeatherController {
  static const _apiKey = "f86a075881ad7ac24938bbd2c1f74a8d";

  static Future fetchWeather(String cityName) async {
    try {
      var url = Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$_apiKey');

      var headers = {"Content-type": "application/json"};

      final response = await http.post(
        url,
        headers: headers,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data;
      } else {
        print(response.statusCode);
        print(response.body);
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future fetchCityWeather() async {
    try {
      for (var city in CITY_LIST) {
        final data = await fetchWeather(city.cityName ?? "");
        city.temperature = _convertKtoC((data['main']['temp']).toDouble());
        city.weather = (data['weather'][0]['main']).toString();
        city.humidity = (data['main']['humidity']).toInt();
        city.pressure = (data['main']['pressure']).toInt();
        city.wind = (data['wind']['speed']).toDouble();
      }
    } catch (e) {
      print(e.toString());
    }
  }

  static Future fetchLocation() async {
    Location location = Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();

    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();

    await geocoding
        .placemarkFromCoordinates(
            _locationData.latitude!, _locationData.longitude!)
        .then((value) async {
      CURRENT_LOC.cityName = value[0].locality;
      CURRENT_LOC.country = value[0].country;

      final data = await fetchWeather(value[0].administrativeArea ?? "");

      CURRENT_LOC.temperature = _convertKtoC((data['main']['temp']).toDouble());
      CURRENT_LOC.weather = (data['weather'][0]['main']).toString();
      CURRENT_LOC.humidity = (data['main']['humidity']).toInt();
      CURRENT_LOC.pressure = (data['main']['pressure']).toInt();
      CURRENT_LOC.wind = (data['wind']['speed']).toDouble();
    });
  }

  static String getImage(String weather) {
    String image;

    switch (weather) {
      case "Clouds":
        image = "partly_sunny.png";
        break;
      case "Rain":
        image = "rain.png";
        break;
      case "Drizzle":
        image = "rain.png";
        break;
      case "Mist":
        image = "rain.png";
        break;
      case "Clear":
        image = "partly_rainy.png";
        break;
      case "Thunderstorm":
        image = "wind.png";
        break;
      default:
        image = "sunny.png";
        break;
    }
    return image;
  }

  static int _convertKtoC(double kelvin) {
    return (kelvin - 273.15).toInt();
  }
}
