import 'package:objectbox_flutter/src/models/weather_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherService {
  Future<WeatherModel> getCurrentWeather(String cityName) async {
    late WeatherModel weather;
    String apiKey = "17cc0ba49361a4a0fe7db3bbe77e1ba9";

    String url =
        "https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey&units=metric";

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        weather = WeatherModel.fromJson(jsonDecode(response.body));
      }
      return weather;
    } catch (e) {
      rethrow;
    }
  }
}
