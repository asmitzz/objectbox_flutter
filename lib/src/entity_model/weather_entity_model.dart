import 'package:objectbox/objectbox.dart';

@Entity()
@Sync()
class WeatherEntityModel {
  int id;

  double temp;
  double feelsLike;
  double low;
  double high;
  String description;
  String cityName;

  WeatherEntityModel(
      {this.id = 0,
      required this.feelsLike,
      required this.low,
      required this.high,
      required this.description,
      required this.cityName,
      required this.temp});

  factory WeatherEntityModel.fromJson(Map<String, dynamic> json) {
    return WeatherEntityModel(
      cityName: json['name'],
      temp: json['temp'].toDouble(),
      feelsLike: json['feels_like'].toDouble(),
      low: json['low'].toDouble(),
      high: json['high'].toDouble(),
      description: json['description'],
    );
  }
}
