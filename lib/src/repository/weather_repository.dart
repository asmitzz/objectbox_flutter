import 'package:objectbox_flutter/src/models/weather_model.dart';
import 'package:objectbox_flutter/src/services/weather_service.dart';

class WeatherRepository {
  final WeatherService _weatherService = WeatherService();

  // fetch weather
  Future<WeatherModel> fetchWeather(String cityName) =>
      _weatherService.getCurrentWeather(cityName);
}
