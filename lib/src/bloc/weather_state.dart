part of 'weather_bloc.dart';

@immutable
abstract class WeatherState {}

class WeatherUninitializedState extends WeatherState {}

class WeatherFetchingState extends WeatherState {}

class WeatherFetchedState extends WeatherState {
  final WeatherEntityModel weather;
  WeatherFetchedState({required this.weather});
}

class WeatherErrorState extends WeatherState {}