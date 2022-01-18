part of 'weather_bloc.dart';

@immutable
abstract class WeatherEvent {}

class StartEvent extends WeatherEvent {
  final String cityName;
  StartEvent({required this.cityName});
}

class FetchWeatherEvent extends WeatherEvent {
  final String cityName;
  FetchWeatherEvent({required this.cityName});
}

class CacheWeatherEvent extends WeatherEvent {
  final WeatherModel weather;
  CacheWeatherEvent({required this.weather});
}